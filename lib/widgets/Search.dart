import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SearchWidget extends StatefulWidget {
  SearchWidget({required this.name});
  final String name ;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Books').snapshots(),
      builder: (context,snapshots){
        return (snapshots.connectionState==ConnectionState.waiting)?
        Center(child: CircularProgressIndicator(),):
        ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context,index){
              var data=snapshots.data!.docs[index].data() as Map<String,dynamic>;
              if(this.widget.name.isEmpty){
                return ListTile(
                  title: Text(data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data['caregory'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  leading: CircleAvatar(backgroundImage: NetworkImage(data['imageUrl']),),
                );
              }
              if(data['name'].toString().toLowerCase().startsWith(this.widget.name.toLowerCase())){
                return ListTile(
                  title: Text(data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data['caregory'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  leading: CircleAvatar(backgroundImage: NetworkImage(data['imageUrl']),),
                );
              }
              return Container();
            }
        );
      },
    );
  }
}
