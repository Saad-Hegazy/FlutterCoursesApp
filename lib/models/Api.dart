import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
class PDFApi {
  static Future<File?> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final bytes = await refPDF.getData();
      return _storeFile(url, bytes as List<int>);
    } catch (e) {
      return Future.error(e);
    }
  }
  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
  String snackBareMaseg='';
  Future CheckUserConnectionButton(context,String buttonName) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (await DataConnectionChecker().hasConnection) {
          if(buttonName=='Read'){
            snackBareMaseg='لحظات : يتم إعداد الملف  الأن';
          }else if(buttonName=='Download'){
            snackBareMaseg='لحظات : يتم تحميل الملف الأن';
          }
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                    snackBareMaseg,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              duration:Duration(seconds:1) ,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
            )
        );
        }
      }
    } on SocketException catch (_) {
       return    ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Center(
               child: Text(
                 'تأكد من الاتصال باللإنترنت',
                 style: Theme.of(context).textTheme.bodyMedium,


               ),
             ),
             behavior: SnackBarBehavior.floating,
             duration:Duration(milliseconds:1000) ,
             backgroundColor: Theme.of(context).primaryColorDark,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30.0)
             ),

           )
       );
    }
  }
  Future CheckUserConnectionPage(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return ;
      }
    } on SocketException catch (_) {
      return    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                'تأكد من الاتصال باللإنترنت',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            duration:Duration(seconds:1) ,
            backgroundColor: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
            ),

          )
      );
    }
  }


}