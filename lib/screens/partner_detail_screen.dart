import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/widgets/partner_avatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/models/partner.dart';

class PartnerDetailScreen extends StatefulWidget {
  final Partner partner;

  const PartnerDetailScreen({Key? key, required this.partner})
    : super(key: key);

  @override
  _PartnerDetailScreenState createState() => _PartnerDetailScreenState();
}

class _PartnerDetailScreenState extends State<PartnerDetailScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditingNotes = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.partner.notes ?? "";
  }

  Future<void> _showAvatarOptions() async {
    HapticFeedback.mediumImpact();
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context).partnerChangeAvatar,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Colors.blueAccent,
              ),
              title: Text(
                AppLocalizations.of(context).partnerChooseFromGallery,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.emoji_emotions,
                color: Colors.orangeAccent,
              ),
              title: Text(
                AppLocalizations.of(context).partnerChooseEmoji,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickEmoji();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final String fileName =
          '${widget.partner.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String newPath = p.join(directory.path, fileName);
      final File newImage = await File(image.path).copy(newPath);

      setState(() {
        widget.partner.avatarType = AvatarType.image;
        widget.partner.avatarContent = newImage.path;
      });
      await widget.partner.save();
      HapticFeedback.mediumImpact();
    } catch (e) {
      print("Error guardando imagen: $e");
    }
  }

  Future<void> _pickEmoji() async {
    final List<String> emojis = [
      '😈',
      '🥰',
      '😎',
      '🔥',
      '😇',
      '😏',
      '🦄',
      '🌹',
      '🦊',
      '🐻',
      '👑',
      '💎',
    ];

    final selectedEmoji = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: Text(
          AppLocalizations.of(context).partnerChooseEmojiTitle,
          style: TextStyle(color: Colors.white),
        ),
        content: Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: emojis
              .map(
                (e) => GestureDetector(
                  onTap: () => Navigator.pop(context, e),
                  child: Text(e, style: const TextStyle(fontSize: 32)),
                ),
              )
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancel),
          ),
        ],
      ),
    );

    if (selectedEmoji != null) {
      setState(() {
        widget.partner.avatarType = AvatarType.emoji;
        widget.partner.avatarContent = selectedEmoji;
      });
      await widget.partner.save();
    }
  }

  void _saveNotes() {
    widget.partner.notes = _notesController.text;
    widget.partner.save(); // Guarda en Hive automáticamente
    setState(() => _isEditingNotes = false);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).partnerNotesSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        // Usamos CustomScrollView para un efecto más profesional
        slivers: [
          // 1. APPBAR CON FOTO
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.grey[900],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.partner.name,
                style: const TextStyle(
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: GestureDetector(
                onTap: _showAvatarOptions,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    PartnerAvatar(
                      partner: widget.partner,
                      radius: 125,
                    ), // Radio grande para el fondo
                    // Gradiente oscuro para que el texto sea legible
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).partnerEdit,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.edit, color: Colors.white70, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. CONTENIDO SCROLLEABLE
          SliverList(
            delegate: SliverChildListDelegate([
              // SECCIÓN DE NOTAS
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).partnerPrivateNotes,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isEditingNotes ? Icons.check_circle : Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            if (_isEditingNotes)
                              _saveNotes();
                            else
                              setState(() => _isEditingNotes = true);
                          },
                        ),
                      ],
                    ),
                    _isEditingNotes
                        ? TextField(
                            controller: _notesController,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 5,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(
                                context,
                              ).partnerNotesHint,
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[900],
                            ),
                          )
                        : Text(
                            (widget.partner.notes == null ||
                                    widget.partner.notes!.isEmpty)
                                ? AppLocalizations.of(
                                    context,
                                  ).partnerNotesTapToAdd
                                : widget.partner.notes!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                  ],
                ),
              ),

              // SECCIÓN DE HISTORIAL
              const Divider(color: Colors.grey),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context).partnerHistoryTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Aquí va la lista de encuentros
              _buildHistoryList(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Encounter>('encounters').listenable(),
      builder: (context, Box<Encounter> box, _) {
        final history = box.values
            .where((e) => e.partnerName == widget.partner.name)
            .toList();
        history.sort((a, b) => b.date.compareTo(a.date));

        if (history.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                AppLocalizations.of(context).partnerNoEncounters,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getRatingColor(item.rating),
                    width: 2,
                  ),
                  color: _getRatingColor(item.rating).withOpacity(0.1),
                ),
                child: Text(
                  "${item.rating}",
                  style: TextStyle(
                    color: _getRatingColor(item.rating),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                DateFormat('EEEE, d MMMM y').format(item.date),
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Row(
                children: [
                  if (item.moodEmoji != null) Text("${item.moodEmoji!} "),
                  Icon(Icons.bolt, size: 14, color: Colors.grey[400]),
                  Text(
                    " ${item.orgasmCount}",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              trailing: item.protected
                  ? const Icon(
                      Icons.security,
                      color: Colors.greenAccent,
                      size: 18,
                    )
                  : null,
            );
          },
        );
      },
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 9) return Colors.purpleAccent;
    if (rating >= 7) return Colors.greenAccent;
    if (rating >= 5) return Colors.blueAccent;
    return Colors.grey;
  }
}
