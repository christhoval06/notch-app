import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/services/share_service.dart';
import 'package:notch_app/features/gamification/widgets/share_preview_action_bar.dart';
import 'package:notch_app/features/gamification/widgets/share_preview_card.dart';
import 'package:notch_app/features/gamification/widgets/share_preview_header.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SharePreviewView extends StatefulWidget {
  const SharePreviewView({
    super.key,
    required this.rankName,
    required this.currentXp,
    required this.progressToNextLevel,
    required this.totalEncountersThisMonth,
  });

  final String rankName;
  final int currentXp;
  final double progressToNextLevel;
  final int totalEncountersThisMonth;

  @override
  State<SharePreviewView> createState() => _SharePreviewViewState();
}

class _SharePreviewViewState extends State<SharePreviewView> {
  final _shareCardKey = GlobalKey();
  final _shareService = ShareService();
  var _isLoading = false;

  Future<void> _shareCard() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isLoading = true);
    await _shareService.captureAndShareWidget(
      context,
      widgetKey: _shareCardKey,
      text: l10n.shareCardText,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const SizedBox.shrink(),
      ),
      bottomNavigationBar: SharePreviewActionBar(
        isLoading: _isLoading,
        onShare: _shareCard,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.surface,
              scheme.surfaceContainerHigh,
              scheme.surfaceContainerLowest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SharePreviewHeader(),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainer.withValues(alpha: 0.64),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: scheme.outlineVariant.withValues(alpha: 0.28),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: RepaintBoundary(
                          key: _shareCardKey,
                          child: SharePreviewCard(
                            rankName: widget.rankName,
                            currentXp: widget.currentXp,
                            progressToNextLevel: widget.progressToNextLevel,
                            totalEncountersThisMonth:
                                widget.totalEncountersThisMonth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
