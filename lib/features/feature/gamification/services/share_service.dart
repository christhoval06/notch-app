import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> captureAndShareWidget(
    BuildContext context, {
    required GlobalKey widgetKey,
    String text = "¡Mira mi progreso en la app NOTCH! 🏆",
  }) async {
    try {
      // 1. Encontrar el widget a través de su Key
      RenderRepaintBoundary boundary =
          widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // 2. Renderizar a una imagen
      // Aumentamos pixelRatio para mayor calidad en pantallas de alta densidad
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 3. Convertir a datos de bytes (PNG)
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) throw Exception("No se pudo convertir a imagen");

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // 4. Guardar en un archivo temporal
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/notch_share_card.png').create();
      await file.writeAsBytes(pngBytes);

      // 5. Compartir usando share_plus
      await Share.shareXFiles([XFile(file.path)], text: text);
    } catch (e) {
      print("Error al compartir: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).shareErrorGeneratingImage),
        ),
      );
    }
  }
}
