import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/models/partner.dart';
import 'package:intl/intl.dart';

class PartnerDetailScreen extends StatefulWidget {
  final Partner partner;

  const PartnerDetailScreen({Key? key, required this.partner})
    : super(key: key);

  @override
  _PartnerDetailScreenState createState() => _PartnerDetailScreenState();
}

class _PartnerDetailScreenState extends State<PartnerDetailScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.partner.notes ?? "";
  }

  void _saveNotes() {
    widget.partner.notes = _notesController.text;
    widget.partner.save(); // Guarda en Hive automáticamente
    setState(() => _isEditing = false);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Notas guardadas")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.partner.name),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              if (_isEditing) {
                _saveNotes();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. SECCIÓN DE NOTAS (El "Black Book" real)
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[900],
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock, size: 14, color: Colors.orangeAccent),
                    SizedBox(width: 5),
                    Text(
                      "NOTAS PRIVADAS / PRIVATE NOTES",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _isEditing
                    ? TextField(
                        controller: _notesController,
                        style: TextStyle(color: Colors.white),
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Gustos, disgustos, cumpleaños...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.black,
                        ),
                      )
                    : Text(
                        (widget.partner.notes == null ||
                                widget.partner.notes!.isEmpty)
                            ? "Sin notas registradas."
                            : widget.partner.notes!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
              ],
            ),
          ),

          // 2. SEPARADOR
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "HISTORIAL / HISTORY",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),

          // 3. LISTA DE ENCUENTROS FILTRADOS
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Encounter>('encounters').listenable(),
              builder: (context, Box<Encounter> box, _) {
                // FILTRO: Solo mostrar los de esta pareja
                final history = box.values
                    .where((e) => e.partnerName == widget.partner.name)
                    .toList();

                // Ordenar por fecha (más reciente arriba)
                history.sort((a, b) => b.date.compareTo(a.date));

                return ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getRatingColor(item.rating),
                          ),
                        ),
                        child: Text(
                          "${item.rating}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        DateFormat('EEEE, d MMM y').format(item.date),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.bolt, size: 14, color: Colors.grey),
                          Text(
                            " ${item.orgasmCount}  ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          if (item.moodEmoji != null) Text(item.moodEmoji!),
                        ],
                      ),
                      trailing: item.protected
                          ? Icon(
                              Icons.security,
                              color: Colors.greenAccent,
                              size: 16,
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 9) return Colors.purpleAccent;
    if (rating >= 7) return Colors.greenAccent;
    return Colors.grey;
  }
}
