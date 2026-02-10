import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

import '../services/share_service.dart';

class SharePreviewScreen extends StatefulWidget {
  // Datos que necesitamos para construir la tarjeta
  final String rankName;
  final int currentXp;
  final double progressToNextLevel;
  final int totalEncountersThisMonth; // Nuevo dato para "flexing"

  const SharePreviewScreen({
    Key? key,
    required this.rankName,
    required this.currentXp,
    required this.progressToNextLevel,
    required this.totalEncountersThisMonth,
  }) : super(key: key);

  @override
  _SharePreviewScreenState createState() => _SharePreviewScreenState();
}

class _SharePreviewScreenState extends State<SharePreviewScreen> {
  final _shareCardKey = GlobalKey();
  final _shareService = ShareService();
  bool _isLoading = false;

  Future<void> _shareCard() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isLoading = true);
    await _shareService.captureAndShareWidget(
      context,
      widgetKey: _shareCardKey,
      text: l10n.shareCardText,
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.sharePreviewTitle),
        actions: [
          // Botón para iniciar el proceso de compartir
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.ios_share),
                  onPressed: _shareCard,
                ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: AspectRatio(
            aspectRatio: 9 / 16, // Formato ideal para Stories de Instagram
            child: RepaintBoundary(
              key: _shareCardKey,
              child: _buildShareCard(), // El widget que se va a capturar
            ),
          ),
        ),
      ),
    );
  }

  // EL DISEÑO DE LA TARJETA PERSONALIZADA
  Widget _buildShareCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [Colors.blueAccent.shade700, Colors.purple.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sección Superior
            Column(
              children: [
                Text(
                  AppLocalizations.of(context).shareCurrentSeason,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    widget.rankName,
                    style: TextStyle(
                      fontFamily: 'BebasNeue',
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ],
            ),

            // Sección Media (Datos de "Flexing")
            Column(
              children: [
                _buildStatRow(
                  icon: Icons.flash_on,
                  label: AppLocalizations.of(context).shareSeasonXp,
                  value: widget.currentXp.toString(),
                ),
                const SizedBox(height: 15),
                _buildStatRow(
                  icon: Icons.flag,
                  label: AppLocalizations.of(context).shareMonthEncounters,
                  value: widget.totalEncountersThisMonth.toString(),
                ),
              ],
            ),

            // Sección Inferior (Logo)
            Text(
              "NOTCH",
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.6),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.8), size: 18),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
