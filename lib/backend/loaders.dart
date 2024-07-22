import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';

// SECTION: Loaders for RAG.
/// A collection of file loaders for different file types.
class Loaders {

  /// Loads a local PDF.
  Future<String> pickPdfText() async {
    final filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      final PDFDoc pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      String text = await pdfDoc.text;
        return text;
    } else {
      return '';
    }
  }

  /// Loads a remote PDF.
  Future<String> _fromPdfUrl({required String url}) async {
    final PDFDoc pdfDoc = await PDFDoc.fromPath(url.trim());
      String text = await pdfDoc.text;
      return text;
  }
}