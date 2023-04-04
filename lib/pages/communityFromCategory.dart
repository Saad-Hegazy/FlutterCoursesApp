import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:prmagito/models/community.dart';

class CommunityPage extends StatefulWidget {
  static const pagedRoute='/communitypage';
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  List <Community> community_data=[];
  List  community=[];

  CollectionReference Communitye = FirebaseFirestore.instance.collection('Community');
  getCommunityData()async{
    var responsbody = await Communitye.get();
    responsbody.docs.forEach((element) {
      setState(() {
        community.add(element.data());

      });
    });

    for(int i=0;i<=community.length; i++) {
      community_data.insert(i, Community(
        name:community[i]['name'],
        category:community[i]['category'],
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
    final routargument=ModalRoute.of(context)?.settings.arguments as Map<String,String>;
    final name= routargument['name'];
    final filterByCategory = community_data.where((Community) {
      return Community.category.contains(name as Pattern );
    }).toList();
    return Scaffold(
        body: Center(
            child: Text('Community Page'),
        )
    );
  }
}
