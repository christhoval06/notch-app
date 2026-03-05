import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:uuid/uuid.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/features/feature/encounters/widgets/partner_picker_sheet.dart';

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  // Clave global para controlar el formulario
  final _formKey = GlobalKey<FormBuilderState>();
  String _partnerDraftValue = '';

  double _lastHapticValue = 8.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                                  ? Colors.blueAccent.withValues(alpha: 0.3)
                                  : scheme.surface,
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
                          backgroundColor: scheme.surface,
                          selectedColor: Colors.blueAccent,
                          checkmarkColor: scheme.onPrimary,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? scheme.onPrimary
                                : scheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : scheme.outlineVariant,
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
                        style: TextStyle(
                          color: scheme.onSurface,
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
                  color: scheme.surface,
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
                      Icon(Icons.security, color: scheme.success, size: 20),
                      SizedBox(width: 10),
                      Text(
                        l10n.usedProtection,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  activeColor: scheme.success,
                  inactiveThumbColor: scheme.onSurfaceVariant,
                  inactiveTrackColor: scheme.surfaceContainerHighest,
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
                inactiveColor: scheme.surfaceContainerHighest,
                decoration: InputDecoration(
                  labelText: l10n.rating,
                  labelStyle: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 18,
                  ),
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
                    style: TextStyle(fontSize: 18, color: scheme.onPrimary),
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
      final String partnerFromForm = (values['partnerName'] as String? ?? '')
          .trim();
      final String partnerName = partnerFromForm.isNotEmpty
          ? partnerFromForm
          : _partnerDraftValue.trim();
      final String normalizedPartner = partnerName.replaceFirst(
        RegExp(r'^[@＠]'),
        '',
      );
      if (normalizedPartner.isEmpty) {
        HapticFeedback.vibrate();
        return;
      }

      print(
        values,
      ); // Para depuración: verás algo como {partnerName: Maria, rating: 8.0, ...}

      // 3. Crear el objeto
      final newEncounter = Encounter(
        id: const Uuid().v4(),
        date: DateTime.now(),
        partnerName: normalizedPartner,
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
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          localizeAchievementName(
                            l10n,
                            achievement.id,
                            achievement.name,
                          ),
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).colorScheme.warning,
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
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 16),
      ),
    );
  }

  Widget _buildPartnerField() {
    return FormBuilderField<String>(
      name: 'partnerName',
      validator: (value) {
        final current = (value ?? '').trim();
        final draft = _partnerDraftValue.trim();
        if (current.isEmpty && draft.isEmpty) {
          return "El nombre es requerido";
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        final scheme = Theme.of(context).colorScheme;
        final encounterBox = Hive.box<Encounter>('encounters');
        final partnerBox = Hive.box<Partner>('partners');
        final usageCounts = <String, int>{};
        for (final encounter in encounterBox.values) {
          final name = encounter.partnerName.trim();
          if (name.isEmpty) continue;
          usageCounts.update(name, (value) => value + 1, ifAbsent: () => 1);
        }
        final names = {
          ...partnerBox.values.map((p) => p.name.trim()),
          ...usageCounts.keys,
        }.where((name) => name.isNotEmpty).toList()..sort();
        final quickNames = usageCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        final currentValue = (field.value ?? _partnerDraftValue).trim();
        final displayValue = currentValue.isEmpty ? '' : '@$currentValue';

        Future<void> openPicker() async {
          final selected = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FractionallySizedBox(
              heightFactor: 0.88,
              child: PartnerPickerSheet(
                partnerNames: names,
                usageCounts: usageCounts,
                initialValue: currentValue,
              ),
            ),
          );
          if (selected != null && selected.trim().isNotEmpty) {
            final clean = selected.trim().replaceFirst(RegExp(r'^[@＠]'), '');
            _partnerDraftValue = clean;
            field.didChange(clean);
            setState(() {});
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: openPicker,
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: scheme.surface,
                  hintText: AppLocalizations.of(context).addEntryPartnerHint,
                  hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                  errorText: field.errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '@',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        displayValue.isEmpty
                            ? AppLocalizations.of(context).addEntryPartnerHint
                            : displayValue,
                        style: TextStyle(
                          color: displayValue.isEmpty
                              ? scheme.onSurfaceVariant
                              : scheme.onSurface,
                          fontWeight: displayValue.isEmpty
                              ? FontWeight.w400
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    if (displayValue.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: scheme.onSurfaceVariant,
                          size: 18,
                        ),
                        onPressed: () {
                          _partnerDraftValue = '';
                          field.didChange('');
                          setState(() {});
                        },
                      ),
                    Icon(Icons.keyboard_arrow_up, color: scheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
            if (quickNames.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: quickNames.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final partner = quickNames[index].key;
                    return ActionChip(
                      onPressed: () {
                        _partnerDraftValue = partner;
                        field.didChange(partner);
                        setState(() {});
                      },
                      label: Text('@$partner'),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onPressed) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.surfaceContainerHighest,
      ),
      child: IconButton(
        icon: Icon(icon, color: scheme.onSurface),
        onPressed: onPressed,
      ),
    );
  }
}
