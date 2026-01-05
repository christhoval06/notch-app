import 'package:flutter/material.dart';
import 'package:notch_app/screens/insights_screen.dart';
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

  // 2. TÍTULOS PARA EL APPBAR
  static const List<String> _appBarTitles = [
    'NOTCH',
    'Black Book 📒',
    'Trophy Room 🏆',
    'Health Passport 🏥',
    'Estadísticas 📊',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Título dinámico según la pestaña
        title: Text(
          _appBarTitles[_selectedIndex],
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
          if (_selectedIndex == 4)
            IconButton(
              icon: const Icon(Icons.psychology, color: Colors.blueAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InsightsScreen()),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Black Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Trofeos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Salud',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
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
