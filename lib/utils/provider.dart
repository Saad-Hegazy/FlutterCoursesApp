import 'package:flutter/material.dart';
class   VriableProvaoder extends InheritedWidget{
    bool darkmode=false;


  VriableProvaoder({required super.child});

  @override
  bool updateShouldNotify(VriableProvaoder oldwidget){
    return oldwidget.darkmode != darkmode ;
  }
    static VriableProvaoder? of(BuildContext context) =>
        context.dependOnInheritedWidgetOfExactType();
}