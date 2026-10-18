import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/utils/analyzer_scoring_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/insight.dart';

void main() {
  test('score ignores title when content is the same', () {
    final service = AnalyzerScoringService(
      [
        _encounter('1', DateTime(2026, 4, 2), 9),
        _encounter('2', DateTime(2026, 4, 5), 8),
        _encounter('3', DateTime(2026, 4, 8), 10),
        _encounter('4', DateTime(2026, 4, 12), 9),
      ],
      const [],
    );

    final first = service.score(
      'context',
      _insight('Best Tag Combo', 'Travel and Date Night appeared 4 times at 9.2.'),
    );
    final second = service.score(
      'context',
      _insight('Anything Else', 'Travel and Date Night appeared 4 times at 9.2.'),
    );

    expect(first.score, second.score);
  });
}

Insight _insight(String title, String description) {
  return Insight(
    title: title,
    description: description,
    icon: Icons.star,
    color: Colors.orange,
  );
}

Encounter _encounter(String id, DateTime date, int rating) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: rating,
  );
}
