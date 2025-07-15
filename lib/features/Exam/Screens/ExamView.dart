import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});
  static String id = '/ExamView';

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    // 1. حمل ملف الـ PDF من الأصول
    final byteData = await rootBundle.load('assets/pdfs/DataMining.pdf');

    // 2. حدد مكان التخزين المؤقت في الجهاز
    final dir = await getApplicationDocumentsDirectory();

    // 3. انسخ الملف من الأصول إلى المسار المؤقت
    final file = File('${dir.path}/DataMining.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عرض الامتحان')),
      body: localPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: localPath,
      ),
    );
  }
}
