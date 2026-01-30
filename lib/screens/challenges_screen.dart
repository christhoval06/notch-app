import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/challenge.dart';
import '../models/encounter.dart';
import '../services/challenge_service.dart';

class ChallengesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Retos 💪",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Encounter>('encounters').listenable(),
        builder: (context, Box<Encounter> box, _) {
          final challenges = ChallengeService.getChallengesWithProgress();
          final allEncounters = box.values.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completa estos objetivos para demostrar tu maestría y compromiso.",
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: challenges.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final challenge = challenges[index];
                    return _buildChallengeCard(challenge, allEncounters);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChallengeCard(
    Challenge challenge,
    List<Encounter> allEncounters,
  ) {
    final progress = challenge.getProgress(allEncounters);
    final progressPercent = challenge.getProgressPercent(allEncounters);
    final isCompleted = progressPercent >= 1.0;

    String progressText;
    if (challenge.id == 'legendary_guardian') {
      progressText = "${progress.toStringAsFixed(0)}% / ${challenge.goal}%";
    } else {
      progressText = "${progress.toInt()} / ${challenge.goal}";
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.grey[800]!,
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                challenge.icon,
                color: isCompleted ? Colors.green : Colors.blueAccent,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  challenge.title,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            challenge.description,
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    minHeight: 10,
                    backgroundColor: Colors.black26,
                    color: isCompleted ? Colors.green : Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                progressText,
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
