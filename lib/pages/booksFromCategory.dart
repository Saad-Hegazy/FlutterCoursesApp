import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/widgets/BookCard.dart';
class BooksFromCategoryPage extends StatefulWidget {
  late String name;
  BooksFromCategoryPage(String name){
    this.name=name;
  }
  @override
  State<BooksFromCategoryPage> createState() => _BooksFromCategoryPageState();
}
class _BooksFromCategoryPageState extends State<BooksFromCategoryPage> {
         List  books=[];
       CollectionReference Books = FirebaseFirestore.instance.collection('Books');
        getBookData()async{
          var  responsbody = await Books
              .where('caregory',isEqualTo:this.widget.name).get();
          responsbody.docs.forEach((element) {
            setState(() {books.add(element.data());}
            );});}

        @override
        void initState() {
          // TODO: implement initState
          super.initState();
          getBookData();
        }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(this.widget.name)),),
      body:  GridView.builder(
         padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:200,
            childAspectRatio: 7/8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        itemBuilder: (context, index)=>
            BookCard(name: books[index]['name'], imageURL: books[index]['imageUrl'],),
        itemCount: books.length,
    ));
    }
  }

/*

  */