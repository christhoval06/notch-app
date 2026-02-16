import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/monetization/premium_access.dart';
import 'package:notch_app/monetization/premium_feature.dart';
import 'package:notch_app/screens/insights_screen.dart';
import 'package:notch_app/screens/path_screen.dart';
import 'package:notch_app/screens/settings_screen.dart';

// Vistas que mostraremos
import 'package:notch_app/views/calendar_view.dart';
import 'black_book_screen.dart';
import 'trophy_room_screen.dart';
import 'health_passport_screen.dart';
import 'stats_screen.dart';

// Pantalla para agregar
import 'add_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice de la pestaña actual

  // 1. LISTA DE PANTALLAS
  // El orden aquí debe coincidir con el de la barra de navegación
  static final List<Widget> _widgetOptions = <Widget>[
    CalendarView(),
    BlackBookScreen(),
    TrophyRoomScreen(),
    HealthPassportScreen(),
    StatsScreen(),
  ];

  PremiumFeature? _featureForTab(int index) {
    if (index == 1) return PremiumFeature.blackBook;
    if (index == 2) return PremiumFeature.trophyRoom;
    if (index == 3) return PremiumFeature.healthPassport;
    if (index == 4) return PremiumFeature.stats;
    return null;
  }

  void _onItemTapped(int index) async {
    final feature = _featureForTab(index);
    if (feature != null) {
      await PremiumAccess.guard(
        context: context,
        feature: feature,
        onAllowed: () {
          if (!mounted) return;
          setState(() => _selectedIndex = index);
        },
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appBarTitles = [
      'NOTCH',
      '${l10n.homeBlackBookTitle} 📒',
      '${l10n.homeTrophyRoomTitle} 🏆',
      '${l10n.homeHealthPassportTitle} 🏥',
      '${l10n.homeStatsTitle} 📊',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Título dinámico según la pestaña
        title: Text(
          appBarTitles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // El botón de Ajustes ahora vive aquí permanentemente
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
          if (_selectedIndex == 2)
            IconButton(
              icon: const Icon(Icons.map, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PathScreen()),
                );
              },
            ),

          if (_selectedIndex == 4)
            IconButton(
              icon: const Icon(Icons.psychology, color: Colors.white),
              onPressed: () async {
                await PremiumAccess.guard(
                  context: context,
                  feature: PremiumFeature.insights,
                  onAllowed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => InsightsScreen()),
                    );
                  },
                );
              },
            ),
        ],
      ),

      // El cuerpo cambia según la pestaña seleccionada
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      // El botón flotante SOLO aparece en la pestaña del Calendario (índice 0)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEntryScreen()),
                );
              },
            )
          : null,

      // 3. LA BARRA DE NAVEGACIÓN
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: l10n.homeTab),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: l10n.homeBlackBookTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: l10n.homeTrophiesTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: l10n.homeHealthTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: l10n.homeStatsTab,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // Estilo Dark Mode
        backgroundColor: Colors.black.withOpacity(0.8),
        type: BottomNavigationBarType.fixed, // Para que no se muevan
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: false, // Más limpio
      ),
    );
  }
}
