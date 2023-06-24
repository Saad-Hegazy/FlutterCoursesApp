import 'package:flutter/material.dart';
import 'package:prmagito/models/Api.dart';
import 'package:prmagito/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';
class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? appBarbackgroundColor.withOpacity(0.8)
                            : appBarbackgroundColor),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child:
                    InkWell(
                        onTap: () async{
                          await PDFApi().CheckUserConnectionPage(context);
                          launchURLBrowser(widget.messages[index]['message'].text.text[0]);
                        },
                        child: Text(widget.messages[index]['message'].text.text[0],
                          style: TextStyle(
                              fontSize: 16, color: blackColor, fontWeight: FontWeight.w400),
                        ))),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
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