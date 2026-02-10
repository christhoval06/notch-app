import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/models/partner.dart';
import 'package:notch_app/services/achievement_engine.dart';
import 'package:notch_app/utils/achievement_localization.dart';
import 'package:uuid/uuid.dart';
import '../models/encounter.dart';
import '../utils/translations.dart';
import '../utils/gamification_engine.dart';

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  // Clave global para controlar el formulario
  final _formKey = GlobalKey<FormBuilderState>();

  double _lastHapticValue = 8.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.save),
        actions: [
          // Botón Guardar en la barra superior (opcional, o abajo)
          IconButton(
            icon: Icon(Icons.check, color: Colors.blueAccent),
            onPressed: () => _submitForm(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. CAMPO PERSONALIZADO: EMOJI SELECTOR
              _buildLabel(l10n.mood),
              FormBuilderField<String>(
                name: 'moodEmoji',
                builder: (FormFieldState<String> field) {
                  return SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: moodEmojis.length,
                      itemBuilder: (context, index) {
                        final emoji = moodEmojis[index];
                        final isSelected = field.value == emoji;
                        return GestureDetector(
                          onTap: () => field.didChange(emoji),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blueAccent.withOpacity(0.3)
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(color: Colors.blueAccent)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                emoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // 2. TEXT FIELD: PAREJA
              _buildLabel(l10n.partner),
              _buildPartnerField(),

              // FormBuilderTextField(
              //   name: 'partnerName',
              //   validator: FormBuilderValidators.required(
              //     errorText: "Required / Requerido",
              //   ),
              //   style: const TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.grey[900],
              //     hintText: "Ej. Alias 'X'...",
              //     hintStyle: TextStyle(color: Colors.grey[600]),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide.none,
              //     ),
              //     errorStyle: const TextStyle(color: Colors.redAccent),
              //   ),
              // ),
              const SizedBox(height: 25),

              // 3. FILTER CHIPS: TAGS (Traducción automática)
              _buildLabel(l10n.tags),
              FormBuilderField<List<String>>(
                name: 'tags',
                initialValue: [], // Valor inicial lista vacía
                builder: (FormFieldState<List<String>> field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorText: field.errorText,
                    ),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: tagKeys.map((key) {
                        // Obtenemos el valor actual del campo
                        final currentList = field.value ?? [];
                        final isSelected = currentList.contains(key);

                        return FilterChip(
                          label: Text(tagLabelFromL10n(l10n, key)),
                          selected: isSelected,
                          // Diseño Dark Mode
                          backgroundColor: Colors.grey[900],
                          selectedColor: Colors.blueAccent,
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[400],
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.grey[800]!,
                            ),
                          ),
                          // Lógica para agregar/quitar
                          onSelected: (selected) {
                            final newList = List<String>.from(currentList);
                            HapticFeedback.mediumImpact();
                            if (selected) {
                              newList.add(key);
                            } else {
                              newList.remove(key);
                            }
                            // Avisamos al Formulario que el valor cambió
                            field.didChange(newList);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // 4. CAMPO PERSONALIZADO: CONTADOR DE ORGASMOS
              _buildLabel(l10n.orgasms),
              FormBuilderField<int>(
                name: 'orgasmCount',
                initialValue: 1,
                builder: (FormFieldState<int> field) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundButton(Icons.remove, () {
                        HapticFeedback.lightImpact();
                        if ((field.value ?? 0) > 0)
                          field.didChange((field.value ?? 0) - 1);
                      }),
                      Text(
                        '${field.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _roundButton(Icons.add, () {
                        HapticFeedback.lightImpact();
                        field.didChange((field.value ?? 0) + 1);
                      }),
                    ],
                  );
                },
              ),

              const SizedBox(height: 25),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: FormBuilderSwitch(
                  name: 'protected',
                  initialValue: true, // Valor por defecto activado
                  title: Row(
                    children: [
                      Icon(Icons.security, color: Colors.greenAccent, size: 20),
                      SizedBox(width: 10),
                      Text(
                        l10n.usedProtection,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  activeColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[800],
                  onChanged: (val) => HapticFeedback.mediumImpact(),
                ),
              ),

              const SizedBox(height: 25),

              // 5. SLIDER: RATING
              FormBuilderSlider(
                name: 'rating',
                initialValue: 8.0,
                min: 1.0,
                max: 10.0,
                divisions: 9,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey[800],
                decoration: InputDecoration(
                  labelText: l10n.rating,
                  labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  if (val != null && val != _lastHapticValue) {
                    HapticFeedback.selectionClick();

                    _lastHapticValue = val;
                  }
                },
                valueTransformer: (val) => val?.round(),
              ),

              const SizedBox(height: 40),

              // BOTÓN FINAL
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => _submitForm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    l10n.save,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- LÓGICA DE GUARDADO ---
  Future<void> _submitForm(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    // 1. Validar y Guardar el estado del formulario
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // 2. Obtener los valores en un Mapa limpio
      final values = _formKey.currentState!.value;

      print(
        values,
      ); // Para depuración: verás algo como {partnerName: Maria, rating: 8.0, ...}

      // 3. Crear el objeto
      final newEncounter = Encounter(
        id: const Uuid().v4(),
        date: DateTime.now(),
        partnerName: values['partnerName'],
        rating: values['rating'] as int,
        orgasmCount: values['orgasmCount'] ?? 0,
        tags: List<String>.from(values['tags'] ?? []),
        moodEmoji: values['moodEmoji'],
        protected: values['protected'] ?? true,
      );

      // 4. Guardar en Hive
      final box = Hive.box<Encounter>('encounters');
      await box.add(newEncounter);

      HapticFeedback.heavyImpact();

      final List<Achievement> unlockedAchievements =
          await GamificationEngine.processEncounter(newEncounter);

      if (context.mounted) {
        Navigator.pop(context);
      }

      if (unlockedAchievements.isNotEmpty && context.mounted) {
        // Usamos un pequeño delay para asegurarnos de que la pantalla anterior se haya reconstruido
        await Future.delayed(const Duration(milliseconds: 300));

        for (var achievement in unlockedAchievements) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Text(achievement.icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.achievementUnlockedTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          localizeAchievementName(
                            l10n,
                            achievement.id,
                            achievement.name,
                          ),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.amber[800],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 3),
            ),
          );
          // Esperamos un poco entre cada notificación si hay varias
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    } else {
      HapticFeedback.vibrate();
      print("Validation failed");
    }
  }

  // --- WIDGETS UI ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  Widget _buildPartnerField() {
    final partnerBox = Hive.box<Partner>('partners');
    final allPartnerNames = partnerBox.values
        .map((p) => p.name)
        .toSet()
        .toList();

    return FormBuilderField<String>(
      name: 'partnerName',
      validator: FormBuilderValidators.required(
        errorText: "El nombre es requerido",
      ),
      builder: (FormFieldState<String> field) {
        return Autocomplete<String>(
          initialValue: TextEditingValue(text: field.value ?? ''),

          optionsBuilder: (TextEditingValue textEditingValue) {
            final String text = textEditingValue.text;

            if (text.isEmpty || !text.startsWith('@')) {
              return const Iterable<String>.empty();
            }

            final String query = text.substring(1).toLowerCase();

            if (query.isEmpty) {
              return const Iterable<String>.empty();
            }

            final results = allPartnerNames
                .where((String option) {
                  return option.toLowerCase().contains(query);
                })
                .take(4);

            return results.map((name) => '@$name');
          },

          onSelected: (String selection) {
            final String realName = selection.startsWith('@')
                ? selection.substring(1)
                : selection;
            field.didChange(realName);
            FocusScope.of(context).unfocus();
          },

          // Usamos nuestro nuevo widget helper para el campo de texto
          fieldViewBuilder:
              (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return _PartnerTextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: onFieldSubmitted,
                  field: field,
                );
              },

          optionsViewBuilder:
              (
                BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options,
              ) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width -
                          40, // Ancho del campo
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return ListTile(
                            title: Text(
                              option,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              onSelected(option);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
        );
      },
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[800],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class _PartnerTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final FormFieldState<String> field;

  const _PartnerTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.field,
  }) : super(key: key);

  @override
  __PartnerTextFieldState createState() => __PartnerTextFieldState();
}

class __PartnerTextFieldState extends State<_PartnerTextField> {
  @override
  void initState() {
    super.initState();
    // Añadimos el listener de forma segura en initState
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Limpiamos el listener para evitar fugas de memoria
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final String text = widget.controller.text;

    final String valueToSave = text.startsWith('@') ? text.substring(1) : text;

    if (valueToSave != widget.field.value) {
      widget.field.didChange(valueToSave);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onSubmitted: (_) => widget.onFieldSubmitted(),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[900],
        hintText: AppLocalizations.of(context).addEntryPartnerHint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorText: widget.field.errorText,
      ),
    );
  }
}
