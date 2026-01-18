import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

// import '../screens/premium_upsell_screen.dart';

void navigateWithPremiumGuard(
  BuildContext context, {
  required Widget destination,
}) {
  final subscriptionService = SubscriptionService();

  if (subscriptionService.isPremium) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        // En lugar de este widget simple, aquí deberías poner tu
        // pantalla de venta 'PremiumUpsellScreen'.
        return Container(
          padding: const EdgeInsets.all(30),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 40, color: Colors.amberAccent),
              const SizedBox(height: 20),
              const Text(
                "Función Premium",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Desbloquea esta y otras funciones avanzadas con NOTCH Premium.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumUpsellScreen()));
                },
                child: const Text(
                  "Ver Planes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
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
