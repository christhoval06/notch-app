import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notch_app/core/constants/partner_avatar_emojis.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/partners/services/partner_avatar_service.dart';
import 'package:notch_app/features/partners/widgets/partner_avatar_options_sheet.dart';
import 'package:notch_app/features/partners/widgets/partner_detail_header.dart';
import 'package:notch_app/features/partners/widgets/partner_emoji_picker_dialog.dart';
import 'package:notch_app/features/partners/widgets/partner_history_section.dart';
import 'package:notch_app/features/partners/widgets/partner_notes_section.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerDetailView extends StatefulWidget {
  const PartnerDetailView({super.key, required this.partner});

  final Partner partner;

  @override
  State<PartnerDetailView> createState() => _PartnerDetailViewState();
}

class _PartnerDetailViewState extends State<PartnerDetailView> {
  final _notesController = TextEditingController();
  final _picker = ImagePicker();
  var _isEditingNotes = false;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.partner.notes ?? '';
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _showAvatarOptions() async {
    HapticFeedback.mediumImpact();
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => PartnerAvatarOptionsSheet(
        onGalleryTap: _pickImageFromGallery,
        onEmojiTap: _pickEmoji,
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    Navigator.of(context).pop();
    final updated = await PartnerAvatarService.pickImageFromGallery(
      widget.partner,
      picker: _picker,
    );
    if (!mounted || !updated) return;
    setState(() {});
    HapticFeedback.mediumImpact();
  }

  Future<void> _pickEmoji() async {
    Navigator.of(context).pop();
    final emoji = await showDialog<String>(
      context: context,
      builder: (_) => const PartnerEmojiPickerDialog(emojis: partnerAvatarEmojis),
    );
    if (emoji == null) return;
    await PartnerAvatarService.updateEmoji(widget.partner, emoji);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _toggleNotes() async {
    if (!_isEditingNotes) {
      setState(() => _isEditingNotes = true);
      return;
    }
    widget.partner.notes = _notesController.text;
    await widget.partner.save();
    if (!mounted) return;
    setState(() => _isEditingNotes = false);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).partnerNotesSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          PartnerDetailHeader(
            partner: widget.partner,
            onEditAvatar: _showAvatarOptions,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              PartnerNotesSection(
                controller: _notesController,
                isEditing: _isEditingNotes,
                notes: widget.partner.notes,
                onToggle: _toggleNotes,
              ),
              Divider(color: scheme.outlineVariant),
              PartnerHistorySection(partnerName: widget.partner.name),
            ]),
          ),
        ],
      ),
    );
  }
}
