import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/repositories/health_log_repository.dart';
import 'package:notch_app/features/feature/health/services/health_logs_view_service.dart';
import 'package:notch_app/features/feature/health/services/health_passport_summary_service.dart';
import 'package:notch_app/features/feature/health/widgets/health_add_log_sheet.dart';
import 'package:notch_app/features/feature/health/widgets/health_logs_list.dart';
import 'package:notch_app/features/feature/health/widgets/health_passport_hero_card.dart';
import 'package:notch_app/features/feature/health/widgets/health_passport_result_chip.dart';
import 'package:notch_app/features/feature/health/widgets/health_passport_section_header.dart';
import 'package:notch_app/features/feature/health/widgets/health_passport_summary_row.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HealthPassportView extends StatelessWidget {
  const HealthPassportView({super.key});

  Future<void> _openAddLogSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const HealthAddLogSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeHealthPassportTitle)),
      body: ValueListenableBuilder(
        valueListenable: HealthLogRepository.listenable(),
        builder: (context, _, _) {
          final logs = HealthLogsViewService.getSortedLogs();
          final summary = HealthPassportSummaryService.build(
            logs: logs,
            now: DateTime.now(),
          );
          final latest = summary.latestLog;
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  sliver: SliverList.list(
                    children: [
                      HealthPassportHeroCard(
                        title: l10n.homeHealthPassportTitle,
                        subtitle: _heroSubtitle(l10n, summary),
                        primaryLabel: l10n.healthRegisterTest,
                        onPrimaryTap: () => _openAddLogSheet(context),
                        latestDateLabel: latest == null
                            ? null
                            : _formatDate(context, latest.date),
                        followUpLabel:
                            summary.followUpRecommendation ==
                                FollowUpRecommendation.overdue
                            ? l10n.insightHealthCheckOverdueDescription(
                                summary.elapsedMonths,
                              )
                            : null,
                        resultChild: latest == null
                            ? null
                            : HealthPassportResultChip(result: latest.result),
                        summaryChild: latest == null
                            ? null
                            : Column(
                                children: [
                                  HealthPassportSummaryRow(
                                    label: _cleanLabel(
                                      l10n.healthTestTypeLabel,
                                    ),
                                    value: latest.testType,
                                    icon: Icons.biotech_outlined,
                                  ),
                                  const SizedBox(height: 12),
                                  HealthPassportSummaryRow(
                                    label: _cleanLabel(l10n.healthResultLabel),
                                    value: latest.result,
                                    icon: Icons.verified_outlined,
                                    trailing: HealthPassportResultChip(
                                      result: latest.result,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 24),
                      HealthPassportSectionHeader(
                        title: l10n.homeHealthPassportTitle,
                        subtitle: latest?.testType ?? l10n.healthNoRecords,
                        actionLabel: l10n.healthRegisterTest,
                        onActionTap: () => _openAddLogSheet(context),
                      ),
                      const SizedBox(height: 12),
                      HealthLogsList(logs: logs),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _cleanLabel(String value) =>
      value.split('(').first.replaceAll(':', '').trim();

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('d MMM y', locale).format(date);
  }

  String _heroSubtitle(AppLocalizations l10n, HealthPassportSummary summary) {
    if (!summary.hasLogs) return l10n.healthNoRecordsSubtitle;
    if (summary.followUpRecommendation == FollowUpRecommendation.overdue) {
      return l10n.insightHealthCheckOverdueDescription(summary.elapsedMonths);
    }
    return l10n.healthSavedReminder;
  }
}
