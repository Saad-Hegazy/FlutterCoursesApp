import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prmagito/models/Api.dart';
import 'package:prmagito/pages/pdf_viewer_page.dart';
class BookCard extends StatefulWidget {
  final String imageURL;
  final String name;
  const  BookCard({Key? key, required this.imageURL, required this.name}) : super(key: key);
  @override
  _BookCardState createState() => _BookCardState();
}
class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {},

      borderRadius:BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              this.widget.imageURL,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(
                this.widget.name
                ,
                style: TextStyle(fontSize: 22,color: Colors.blue,),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              )

          ),

            Container(
              alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(5),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:Icon(Icons.menu_book_outlined),
                    color: Colors.blue,
                    onPressed:() async {
                      final url = this.widget.name +'.pdf';
                      final file = await PDFApi.loadFirebase(url);
                      if (file == null) return;
                      openPDF(context, file);
                      },
                     ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1,0,1,1),
                    child: IconButton(
                      onPressed: () async{
                        final url = this.widget.name +'.pdf';
                        downloadFile(url);
                        },
                      icon:Icon(Icons.save_alt_outlined),
                      color: Colors.blue,
                    ),
                ),
    ],
  ),
)
        ],
      ),
    );
  }
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );


  Future downloadFile(String url) async {

    final ref = FirebaseStorage.instance.ref().child(url);

    Directory appDocDir = await getApplicationDocumentsDirectory();

    final File tempFile = File(appDocDir.path + "/" + url);

    try{
      await ref.writeToFile(tempFile);
      await tempFile.create();
      await OpenFile.open(tempFile.path);
    }on FirebaseException{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error . file tidak biase diunduh ',
            style: Theme.of(context).textTheme.bodyMedium,
          )
          )
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'File Berhasil diunduh',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
      ),

    )
    );
  }
}
