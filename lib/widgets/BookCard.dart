import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prmagito/models/Api.dart';
import 'package:prmagito/pages/pdf_viewer_page.dart';
import 'package:prmagito/theme/color.dart';

import 'custom_image.dart';
class BookCard extends StatefulWidget {
  final String imageURL;
  final String name;
  const  BookCard({Key? key, required this.imageURL, required this.name}) : super(key: key);
  @override
  _BookCardState createState() => _BookCardState();
}
class _BookCardState extends State<BookCard> {
  bool isDownloadStarted = false;
  bool isDownloadFinish = false;
  bool buttonCliked=false;
  late final File locationOfFileDownloaded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {},
      borderRadius:BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child:   CachedNetworkImage(
              imageUrl:this.widget.imageURL,
              placeholder: (context, url) => BlankImageWidget(),
              errorWidget: (context, url, error) => BlankImageWidget(),
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(
                this.widget.name,
                style: TextStyle(fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.1),
              )

          ),

          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(1, 0, 1, 4),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width:68,
                  child: ElevatedButton(
                    onPressed:() async {
                      await PDFApi().CheckUserConnectionButton(context,'Read');
                      final url = this.widget.name +'.pdf';
                      final file = await PDFApi.loadFirebase(url);
                      if (file == null) return;
                      openPDF(context, file);
                      setState(() {
                        buttonCliked=true;
                      });
                    },
                    child: Text("Read",
                      style:TextStyle(
                        color: buttonCliked ? Colors.green : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBgColor,
                      shadowColor:shadowColor,
                      foregroundColor: Colors.black87,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                  ),

                ),
                SizedBox(
                  height: 30,
                  width:95,
                  child: ElevatedButton(
                    onPressed: () async{
                      final url = this.widget.name +'.pdf';
                      if(!isDownloadFinish){
                        await PDFApi().CheckUserConnectionButton(context,'Download');
                        downloadFile(url);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'لقد تم تحميل الملف مسبقاً',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              duration:Duration(milliseconds:1000) ,
                              backgroundColor: Theme.of(context).primaryColorLight,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              ),

                            )
                        );
                        await OpenFile.open(locationOfFileDownloaded.path);
                      }

                    },

                    child: Text("Download",
                      style:TextStyle(
                        color: isDownloadFinish ? Colors.green : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBgColor,
                      shadowColor:shadowColor,
                      foregroundColor: Colors.black87,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                  ),

                )


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
      setState(() {
        isDownloadStarted = true;
      });

      await ref.writeToFile(tempFile);
      await tempFile.create();
      await OpenFile.open(tempFile.path);
      setState(() {
        isDownloadFinish = true;
        locationOfFileDownloaded=tempFile;
      });
    }on FirebaseException{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(
            child: Text('نأسف :تعذر جلب الملف',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
          )
      );
    }
  }

}