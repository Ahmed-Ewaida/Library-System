import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../Core/custom_appBar.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  const PdfViewerScreen({super.key, required this.pdfUrl});
  static const String id = "/pdf_viewer";

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }
   String projectPdfUrl = "https://ebel-kliniken.com/fileadmin/user_upload/demo/dokument-2.pdf";

  Future<void> loadPdf() async {
    try {
      final url = Uri.parse(widget.pdfUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/project.pdf');
        await file.writeAsBytes(bytes, flush: true);
        if (mounted) {
          setState(() {
            localPath = file.path;
            isLoading = false;
          });
        }
      } else {
        localPath = projectPdfUrl;
        // throw Exception('فشل تحميل الملف: ${response.statusCode}');

      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "حدث خطأ أثناء تحميل الملف: $e";
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : localPath != null
            ? PDFView(
          filePath: localPath,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: true,
        )
            : Text(errorMessage ?? "لم يتم العثور على الملف"),
      ),
    );
  }
}