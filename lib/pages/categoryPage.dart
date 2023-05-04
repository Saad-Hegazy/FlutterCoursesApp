import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prmagito/models/category.dart';
import 'package:prmagito/pages/booksFromCategory.dart';
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
      backgroundColor: mainColor,
      appBar: AppBar(
          leading: const BackButton(
            color: blackColor,
          ),
        elevation: 0.5,
        backgroundColor: appBarbackgroundColor,
          centerTitle: true,
        title:
            Text("Categories",
          style: TextStyle(
              fontSize: 28,
              color: blackColor,
              fontWeight: FontWeight.w600)
          ,)
      ),
      
      body:Padding(
        padding: EdgeInsets.all(10),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 13,
          mainAxisSpacing: 20,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()
              =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BooksFromCategoryPage(categories[index]['name']))),

              child: Container(
                padding: EdgeInsets.all(20),
                height: index.isEven ? 185 : 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(categories[index]['image']),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      categories[index]['name'],
                      style: kTitleTextStyle2,),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }



}
