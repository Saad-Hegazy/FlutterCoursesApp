import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
class PDFViewerPage extends StatefulWidget {
  final File file;
  const PDFViewerPage({
    required this.file,
  }) ;
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}
class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(name)),
      ),
      body: PDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}