import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/models/category.dart';
import 'package:prmagito/widgets/category_item.dart';
import 'package:prmagito/theme/color.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}


class _CategoriesPageState extends State<CategoriesPage> {
  List  categories=[];
  List<Category> Categories_data=[];
  CollectionReference category = FirebaseFirestore.instance.collection('category');
  getCategoryData()async{
    var responsbody = await category.get();
    responsbody.docs.forEach((element) {
      setState(() {
        categories.add(element.data());

      });
    });
    for(int i=0;i<categories.length;i++) {
      Categories_data.insert(i,
          Category(
              name:categories[i]['name'],
              imageUrl: categories[i]['image']
          ));
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: appBgColor,
          centerTitle: true,
        title:
            Text("Categories",
          style: TextStyle(
              fontSize: 28,
              color: Colors.black87,
              fontWeight: FontWeight.w600)
          ,)
      ),
      
      body: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:200,
            childAspectRatio: 7/8 ,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children:
          Categories_data.map(
                  (categotyData)=>
                  CategoryItem(
                    imageUrl:categotyData.imageUrl , name: categotyData.name,
                  )
          ).toList()


      ),

    );
  }



}
