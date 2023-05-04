import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:prmagito/models/community.dart';
import 'package:prmagito/theme/color.dart';
import 'package:prmagito/widgets/groupItem.dart';
class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key,}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List <Community> community_data = [];
  List community = [];
  CollectionReference Communitye = FirebaseFirestore.instance.collection(
      'Community');

  getCommunityData() async {
    var responsbody = await Communitye.get();
    responsbody.docs.forEach((element) {
      setState(() {
        community.add(element.data());
      });
    });
    for (int i = 0; i <= community.length; i++) {
      community_data.insert(i, Community(
        name: community[i]['name'],
        category: community[i]['category'],
        CommunityimageUrl: community[i]['CommunityimageUrl'],
        CommunityUrl: community[i]['CommunityUrl'],

      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommunityData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: appBarbackgroundColor,
          elevation: 0.5,
          centerTitle: true,
        title:
         Text("Groups",
        style: TextStyle(
        fontSize: 28,
        color: blackColor,
        fontWeight: FontWeight.w600)
    ,)


    ),
    body: Flex(
      direction: Axis.vertical,
      children: [
         SizedBox(height: 6,),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 10,left: 15, right: 15),

            shrinkWrap: true,

            children: List.generate(community.length,
                    (index) =>
                    GroupItem(name: community[index]['name'],
                      CommunityUrl: community[index]['CommunityUrl'],
                      CommunityimageUrl: community[index]['CommunityimageUrl'],
                      subtitel: community[index]['subtitel'],
                    )
            )

      ),
        ),],

    ),
    );
  }
}