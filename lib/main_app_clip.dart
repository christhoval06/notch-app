import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/app/app_clip_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const AppClipApp());
}
