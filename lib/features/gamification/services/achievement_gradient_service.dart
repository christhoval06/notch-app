import 'package:flutter/material.dart';

class AchievementGradientService {
  const AchievementGradientService._();

  static const _fallback = LinearGradient(
    colors: [Colors.grey, Colors.black38],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient _tone(List<Color> colors) => LinearGradient(
    colors: colors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final Map<String, Gradient> _gradients = {
    'rookie': _tone([const Color(0xFF7ED957), const Color(0xFF1B8F4B)]),
    'legend': _tone([const Color(0xFFFFD166), const Color(0xFFE76F51)]),
    'sprinter': _tone([const Color(0xFF38BDF8), const Color(0xFF312E81)]),
    'safe_player': _tone([const Color(0xFF34D399), const Color(0xFF065F46)]),
    'hat_trick': _tone([const Color(0xFFF59E0B), const Color(0xFFB91C1C)]),
    'marathoner': _tone([const Color(0xFFFFB86C), const Color(0xFFFF6B6B)]),
    'renaissance_man': _tone([
      const Color(0xFFD8B4FE),
      const Color(0xFF6D28D9),
    ]),
    'fire_streak': _tone([const Color(0xFFFF7A18), const Color(0xFFAF002D)]),
    'top_critic': _tone([const Color(0xFFE7C77F), const Color(0xFF8C6239)]),
    'grand_master': _tone([const Color(0xFFC6FFDD), const Color(0xFF2C5364)]),
    'explorer': _tone([const Color(0xFF60A5FA), const Color(0xFF1D4ED8)]),
    'globetrotter': _tone([const Color(0xFF22C1C3), const Color(0xFF3A86FF)]),
    'night_owl': _tone([const Color(0xFF4338CA), const Color(0xFF0F172A)]),
    'single_partner_badge': _tone([
      const Color(0xFFFFA6C1),
      const Color(0xFFC9184A),
    ]),
    'multiple_partners_badge': _tone([
      const Color(0xFF8E9AAF),
      const Color(0xFF3C096C),
    ]),
    'abstinence_bronze': _tone([
      const Color(0xFF8C4E15),
      const Color(0xFFCD7F32),
    ]),
    'abstinence_silver': _tone([
      const Color(0xFF7F7F7F),
      const Color(0xFFC0C0C0),
    ]),
    'abstinence_gold': _tone([
      const Color(0xFF85581A),
      const Color(0xFFD4AF37),
    ]),
    'abstinence_master_45': _tone([
      const Color(0xFF6B4F4F),
      const Color(0xFFB08968),
    ]),
    'abstinence_diamond': _tone([
      const Color(0xFF7DD3FC),
      const Color(0xFFE0FBFC),
    ]),
    'abstinence_master_90': _tone([
      const Color(0xFF1D4ED8),
      const Color(0xFF312E81),
    ]),
    'abstinence_master_120': _tone([
      const Color(0xFF0F766E),
      const Color(0xFF99F6E4),
    ]),
    'monk_mode': _tone([const Color(0xFFF8FAFC), const Color(0xFF94A3B8)]),
    'health_champion': _tone([
      const Color(0xFF2DD4BF),
      const Color(0xFF0F766E),
    ]),
    'archivist': _tone([const Color(0xFF94A3B8), const Color(0xFF334155)]),
  };

  static Gradient gradientFor(String id) => _gradients[id] ?? _fallback;
}
