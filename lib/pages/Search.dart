import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prmagito/pages/pdf_viewer_page.dart';
import 'package:prmagito/theme/color.dart';

import '../models/Api.dart';
class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}
class _SearchWidgetState extends State<SearchWidget> {
   String name='' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  BackButton(
          color: blackColor,
        ),
        elevation: 0.5,
        backgroundColor: appBarbackgroundColor,
        title:
           TextField(
             style: TextStyle(color: blackColor ),
            decoration: InputDecoration(
              prefixIcon:Icon(Icons.search_sharp),
              hintText: "Search... ",
            ),
            onChanged: (val){
              setState(() {
                name=val;
              });
            },
          ),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Books').snapshots(),
        builder: (context,snapshots){
          return (snapshots.connectionState==ConnectionState.waiting)?
          Center(child: CircularProgressIndicator(),):
          ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
                var data=snapshots.data!.docs[index].data() as Map<String,dynamic>;
                if(name.isEmpty){
                  return InkWell(
                    onDoubleTap: ()async {
                        await PDFApi().CheckUserConnectionButton(context,'Read');
                        final url = data['name'] +'.pdf';
                        final file = await PDFApi.loadFirebase(url);
                        if (file == null) return;
                        openPDF(context, file);
                      },
                    onLongPress:() async{
                      final url = data['name'] +'.pdf';

                        await PDFApi().CheckUserConnectionButton(context,'Download');
                        downloadFile(url);



                    },


                    child: ListTile(
                      title: Text(data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data['caregory'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      leading: CircleAvatar(backgroundImage: NetworkImage(data['imageUrl']),),
                    ),
                  );
                }
                if(data['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
                  return ListTile(
                    title: Text(data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      data['caregory'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    leading: CircleAvatar(backgroundImage: NetworkImage(data['imageUrl']),),
                  );
                }
                return Container();
              }
          );
        },
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
