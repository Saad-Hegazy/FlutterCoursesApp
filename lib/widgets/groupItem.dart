
import 'package:flutter/material.dart';
import 'package:prmagito/widgets/custom_image.dart';
import 'package:url_launcher/url_launcher.dart';
class GroupItem extends StatelessWidget {
  GroupItem({ required this.name, required this.CommunityUrl, required this.CommunityimageUrl});
  final String name;
  final String CommunityUrl;
  final String  CommunityimageUrl;
  @override
  Widget build(BuildContext context){
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(
                  CommunityimageUrl,
                  width: 80,
                  height: 80,
                ),
                Expanded(
                    child:
                    Container(
                        child:
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                        children:[
                                          InkWell(
                                              child: Text(
                                                    name,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                                                ),
                                                onTap: () => launchUrl(Uri.parse(CommunityUrl))
                                            ),
                                          Text('subtitel', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: Colors.grey))
                                        ]

                                    )

                                ),


                              ],
                            ),

                          ],
                        )
                    )
                ),
              ],
            ),
          ],
        ),
      );





  }
}