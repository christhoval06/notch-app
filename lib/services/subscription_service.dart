import 'package:flutter/foundation.dart';

class SubscriptionService extends ChangeNotifier {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  bool _isPremium = false;

  bool get isPremium => _isPremium;

  void upgradeToPremium() {
    _isPremium = true;
    notifyListeners();
  }

  void downgradeToFree() {
    _isPremium = false;
    notifyListeners();
  }
}


// Ejemplo
//
// Dentro del ListView de SettingsScreen, añade esto (puede ser al final)
          // _buildSectionHeader("DEBUG"),
          // ListTile(
          //   leading: Icon(Icons.star, color: Colors.amber),
          //   title: Text("Simular ser Premium (DEBUG)", style: TextStyle(color: Colors.white)),
          //   trailing: Switch(
          //     value: SubscriptionService().isPremium,
          //     onChanged: (value) {
          //       if (value) {
          //         SubscriptionService().upgradeToPremium();
          //       } else {
          //         SubscriptionService().downgradeToFree();
          //       }
          //       // Usamos setState para redibujar el Switch
          //       setState(() {});
          //     },
          //   ),
          // ),
