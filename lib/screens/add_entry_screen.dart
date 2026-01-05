import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(AppStrings.get('save', lang: currentLang)),
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
              _buildLabel(AppStrings.get('mood', lang: currentLang)),
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
              _buildLabel(AppStrings.get('partner', lang: currentLang)),
              FormBuilderTextField(
                name: 'partnerName',
                validator: FormBuilderValidators.required(
                  errorText: "Required / Requerido",
                ),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Ej. Alias 'X'...",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                ),
              ),

              const SizedBox(height: 25),

              // 3. FILTER CHIPS: TAGS (Traducción automática)
              _buildLabel(AppStrings.get('tags', lang: currentLang)),
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
                          label: Text(AppStrings.get(key, lang: currentLang)),
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
              _buildLabel(AppStrings.get('orgasms', lang: currentLang)),
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
                        AppStrings.get('protected', lang: currentLang),
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
                  labelText: AppStrings.get('rating', lang: currentLang),
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
                    AppStrings.get('save', lang: currentLang),
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

      String? achievementMsg = await GamificationEngine.processEncounter(
        newEncounter,
      );

      // Si desbloqueó algo, mostramos feedback
      if (achievementMsg != null && context.mounted) {
        // Opcional: Vibración especial
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(achievementMsg),
            backgroundColor: Colors.amber[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      // 5. Cerrar
      Navigator.pop(context, true);
    } else {
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
