import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/models/partner.dart';
import 'package:notch_app/widgets/partner_avatar.dart';
import 'package:uuid/uuid.dart';

import 'partner_detail_screen.dart'; // La crearemos en el paso 4

class BlackBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final encounterBox = Hive.box<Encounter>('encounters');
    final partnerBox = Hive.box<Partner>('partners');

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: ValueListenableBuilder(
        valueListenable: encounterBox.listenable(),
        builder: (context, Box<Encounter> box, _) {
          // 1. Obtener nombres únicos de los encuentros
          final Set<String> uniqueNames = box.values
              .map((e) => e.partnerName.trim())
              .where((name) => name.isNotEmpty)
              .toSet();

          // Convertir a lista y ordenar alfabéticamente
          final List<String> namesList = uniqueNames.toList()..sort();

          if (namesList.isEmpty) {
            return Center(
              child: Text(
                "No hay registros aún",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: namesList.length,
            itemBuilder: (context, index) {
              final name = namesList[index];

              // Calcular datos al vuelo (Estadísticas rápidas)
              final encountersWithPerson = box.values
                  .where((e) => e.partnerName == name)
                  .toList();
              final count = encountersWithPerson.length;
              final lastEncounter = encountersWithPerson.reduce(
                (curr, next) => curr.date.isAfter(next.date) ? curr : next,
              );

              // Ver si ya existe un perfil de Partner creado para obtener notas
              Partner? partnerProfile;
              try {
                partnerProfile = partnerBox.values.firstWhere(
                  (p) => p.name == name,
                );
              } catch (e) {
                // No existe perfil aún, no pasa nada
              }

              final tempPartner =
                  partnerProfile ??
                  Partner(
                    id: '',
                    name: name,
                    avatarType: AvatarType.initial,
                    avatarContent: Colors
                        .primaries[name.hashCode % Colors.primaries.length]
                        .value
                        .toString(),
                  );

              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListTile(
                  leading: PartnerAvatar(partner: tempPartner, radius: 22),
                  title: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "$count Encuentros • Último: ${_formatDate(lastEncounter.date)}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 14,
                  ),
                  onTap: () {
                    if (partnerProfile == null) {
                      final randomColor = Colors
                          .primaries[name.hashCode % Colors.primaries.length];

                      partnerProfile = Partner(
                        id: const Uuid().v4(),
                        name: name,
                        avatarType: AvatarType.initial,
                        avatarContent: randomColor.value.toString(),
                      );
                      partnerBox.add(partnerProfile!);
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PartnerDetailScreen(partner: partnerProfile!),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}";
  }
}
