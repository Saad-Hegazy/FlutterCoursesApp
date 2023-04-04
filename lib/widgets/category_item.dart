import 'package:flutter/material.dart';
import 'package:prmagito/pages/booksFromCategory.dart';
class CategoryItem extends StatelessWidget {

   final String name;
  final String imageUrl;
  CategoryItem({required this.imageUrl,required this.name,super.key});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BooksFromCategoryPage(name))),
      splashColor: Theme.of(context).primaryColor,
      borderRadius:BorderRadius.circular(15),
      child: Stack(

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,height: 250,
                  fit: BoxFit.cover,
            ),
          ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text(name,
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
}
