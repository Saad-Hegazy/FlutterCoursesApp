import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prmagito/models/Api.dart';
import 'package:prmagito/pages/pdf_viewer_page.dart';
class BookItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  BookItem({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:() async {
        final url = name +'.pdf';
        final file = await PDFApi.loadFirebase(url);
        if (file == null) return;
        openPDF(context, file);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius:BorderRadius.circular(15),
      child: Stack(

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text(
                name,
                style: TextStyle(fontSize: 20,color: Colors.white),

              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              )


          )

        ],
      ),
    )
    ;
  }
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );
}
