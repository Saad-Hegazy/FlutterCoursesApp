import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/pages/booksFromCategory.dart';

import 'custom_image.dart';
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
            child:
            CachedNetworkImage(
              imageUrl:imageUrl??'',
              placeholder: (context, url) => BlankImageWidget(),
              errorWidget: (context, url, error) => BlankImageWidget(),
              height: 250,
                  fit: BoxFit.cover,
            ),
          ),
            Container(
              padding: EdgeInsets.fromLTRB(5,0,0,0),
              alignment: Alignment.centerLeft,
              child:Center(
                child: Text(name,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              )


            )

        ],
      ),
    );
  }
}
