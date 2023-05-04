
import 'package:flutter/material.dart';
import 'package:prmagito/models/Api.dart';
import 'package:prmagito/theme/color.dart';
import 'package:prmagito/widgets/custom_image.dart';
import 'package:url_launcher/url_launcher.dart';
class GroupItem extends StatefulWidget {
  GroupItem({ required this.name, required this.CommunityUrl, required this.CommunityimageUrl, required this.subtitel});
  final String name;
  final String subtitel;
  final String CommunityUrl;
  final String  CommunityimageUrl;

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  bool  ActiveConnection=false;

  @override
  void initState() {
    PDFApi().CheckUserConnectionPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: communityCardBackGroundColor ,
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
                  widget.CommunityimageUrl,
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
                                                    widget.name,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: blackColor, fontSize: 16, fontWeight: FontWeight.w700)
                                                ),
                                                onTap: () async{
                                                await PDFApi().CheckUserConnectionPage(context);
                                                launchURLBrowser(widget.CommunityUrl);

                                              }
                                            ),
                                          Text(widget.subtitel, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: greyColor ))
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
 Future  launchURLBrowser(var Url) async {
    var url = Uri.parse(Url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}