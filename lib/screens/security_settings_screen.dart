import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import '../widgets/pin_selection_sheet.dart'; // Importa el modal

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;

  // Valores iniciales
  Map<String, dynamic> _initialValues = {};

  @override
  void initState() {
    super.initState();
    _loadPins();
  }

  Future<void> _loadPins() async {
    final real = await _storage.read(key: 'real_pin');
    final fake = await _storage.read(key: 'fake_pin');
    final kill = await _storage.read(key: 'kill_pin');

    setState(() {
      _initialValues = {
        'real_pin': real ?? '',
        'fake_pin': fake ?? '',
        'kill_pin': kill ?? '',
      };
      _isLoading = false;
    });
  }

  Future<void> _saveForm() async {
    final l10n = AppLocalizations.of(context);
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      await _storage.write(key: 'real_pin', value: values['real_pin']);
      await _storage.write(key: 'fake_pin', value: values['fake_pin']);
      await _storage.write(key: 'kill_pin', value: values['kill_pin']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.securityUpdated),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_isLoading)
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.securityTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValues,
          child: Column(
            children: [
              Text(
                l10n.securityConfigureKeys,
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 30),

              // CAMPO 1: PIN REAL
              _buildPinField(
                name: 'real_pin',
                title: l10n.securityRealPinTitle,
                desc: l10n.securityRealPinDesc,
                color: Colors.blueAccent,
                icon: Icons.vpn_key,
              ),

              const SizedBox(height: 20),

              // CAMPO 2: PIN PÁNICO
              _buildPinField(
                name: 'fake_pin',
                title: l10n.securityPanicPinTitle,
                desc: l10n.securityPanicPinDesc,
                color: Colors.orangeAccent,
                icon: Icons.masks, // Icono de máscara o similar
              ),

              const SizedBox(height: 20),

              // CAMPO 3: KILL SWITCH
              _buildPinField(
                name: 'kill_pin',
                title: l10n.securityKillSwitchTitle,
                desc: l10n.securityKillSwitchDesc,
                color: Colors.redAccent,
                icon: Icons.delete_forever,
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    l10n.securitySaveConfig,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET CONSTRUCTOR DE CAMPO
  Widget _buildPinField({
    required String name,
    required String title,
    required String desc,
    required Color color,
    required IconData icon,
  }) {
    return FormBuilderField<String>(
      name: name,
      builder: (FormFieldState<String> field) {
        final isEmpty = field.value == null || field.value!.isEmpty;

        return InkWell(
          onTap: () async {
            // Abrir el BottomSheet con nuestro diseño reutilizable
            final newPin = await showModalBottomSheet<String>(
              context: context,
              isScrollControlled: true, // Para que ocupe pantalla casi completa
              builder: (context) => PinSelectionSheet(
                title: AppLocalizations.of(context).securityConfigurePin(title),
                color: color,
              ),
            );

            if (newPin != null) {
              field.didChange(newPin); // Guardar en el formulario
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: field.hasError ? Colors.red : Colors.grey[800]!,
              ),
            ),
            child: Row(
              children: [
                // Icono
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 15),
                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        desc,
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Visualización del PIN (Puntitos o Texto "Sin definir")
                if (isEmpty)
                  Text(
                    AppLocalizations.of(context).securityNotSet,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                else
                  Row(
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
