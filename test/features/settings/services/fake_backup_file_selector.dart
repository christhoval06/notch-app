import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

class FakeBackupFileSelector extends FileSelectorPlatform {
  XFile? selected;
  int calls = 0;

  @override
  Future<XFile?> openFile({
    List<XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) async {
    calls++;
    return selected;
  }
}
