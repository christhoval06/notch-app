import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PartnerAvatarService {
  const PartnerAvatarService._();

  static Future<bool> pickImageFromGallery(
    Partner partner, {
    ImagePicker? picker,
  }) async {
    try {
      final imagePicker = picker ?? ImagePicker();
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (image == null) return false;

      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${partner.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = p.join(directory.path, fileName);
      final newImage = await File(image.path).copy(newPath);

      partner.avatarType = AvatarType.image;
      partner.avatarContent = newImage.path;
      await partner.save();
      return true;
    } catch (error) {
      debugPrint('PartnerAvatarService.pickImageFromGallery failed: $error');
      return false;
    }
  }

  static Future<void> updateEmoji(Partner partner, String emoji) async {
    partner.avatarType = AvatarType.emoji;
    partner.avatarContent = emoji;
    await partner.save();
  }
}
