import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/encounter.dart';

class PdfService {
  Future<void> generateReport() async {
    final pdf = pw.Document();
    final encounters = Hive.box<Encounter>('encounters').values.toList();

    // Ordenar por fecha
    encounters.sort((a, b) => b.date.compareTo(a.date));

    final fontData = await rootBundle.load(
      "assets/fonts/Nunito-ExtraLight.ttf",
    );
    final ttf = pw.Font.ttf(fontData);

    // Opcional: Cargar también la versión Bold
    final boldFontData = await rootBundle.load("assets/fonts/Nunito-Bold.ttf");
    final boldTtf = pw.Font.ttf(boldFontData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'NOTCH Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: boldTtf,
                    ),
                  ),
                  pw.Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    style: pw.TextStyle(font: ttf),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Resumen Stats
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  _statItem("Total", "${encounters.length}"),
                  _statItem(
                    "Orgasmos",
                    "${encounters.fold(0, (sum, e) => sum + e.orgasmCount)}",
                  ),
                  _statItem(
                    "Promedio",
                    (encounters.isEmpty
                            ? 0
                            : encounters.fold(0, (sum, e) => sum + e.rating) /
                                  encounters.length)
                        .toStringAsFixed(1),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),
            pw.Text(
              "Últimos Registros",
              style: pw.TextStyle(fontSize: 18, font: boldTtf),
            ),
            pw.Divider(),

            // Tabla de Registros
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ['Fecha', 'Pareja', 'Rating', 'Safe', 'Tags'],
              data: encounters
                  .take(50)
                  .map(
                    (e) => [
                      DateFormat('MM/dd').format(e.date),
                      e.partnerName,
                      e.rating.toString(),
                      e.protected ? "Yes" : "No",
                      e.tags.join(', '),
                    ],
                  )
                  .toList(),
            ),

            pw.Footer(
              leading: pw.Text(
                "Generado por NOTCH App - Privado & Confidencial",
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ];
        },
      ),
    );

    // Compartir/Imprimir
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'notch_report.pdf',
    );
  }

  pw.Widget _statItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(label),
      ],
    );
  }
}
