import 'package:flutter/material.dart';
import 'package:notch_app/features/premium/models/premium_access.dart';
import 'package:notch_app/features/premium/models/premium_feature.dart';

void navigateWithPremiumGuard(
  BuildContext context, {
  required Widget destination,
  PremiumFeature feature = PremiumFeature.insights,
}) {
  PremiumAccess.guard(
    context: context,
    feature: feature,
    onAllowed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
  );
}

// Usos

// floatingActionButton: _selectedIndex == 0
//         ? FloatingActionButton(...)
//         : _selectedIndex == 4 // Pestaña Estadísticas
//           ? FloatingActionButton.extended(
//               backgroundColor: Colors.purpleAccent,
//               onPressed: () {
//                 // --- CAMBIO AQUÍ ---
//                 // En lugar de Navigator.push...
//                 navigateWithPremiumGuard(
//                   context,
//                   destination: InsightsScreen(), // Le dices a dónde quieres ir
//                 );
//               },
//               icon: const Icon(Icons.psychology, color: Colors.white),
//               label: const Text("Insights"),
//             )
//           : null,

// _buildTile(
//             icon: Icons.cloud_sync_outlined,
//             color: Colors.blueAccent,
//             title: "Datos y Respaldo",
//             subtitle: "Copias de seguridad y Exportar PDF",
//             onTap: () {
//               // --- CAMBIO AQUÍ ---
//               navigateWithPremiumGuard(
//                 context,
//                 destination: DataManagementScreen(),
//               );
//             },
//           ),
