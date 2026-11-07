import 'package:flutter/material.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/features/gamification/services/challenge_service.dart';
import 'package:notch_app/features/gamification/widgets/challenges_content.dart';

class ChallengesView extends StatelessWidget {
  const ChallengesView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ValueListenableBuilder(
        valueListenable: EncounterRepository.listenable(),
        builder: (context, _, _) {
          return ChallengesContent(
            challenges: ChallengeService.getChallengesWithProgress(),
            encounters: EncounterRepository.getAll(),
          );
        },
      ),
    );
  }
}
