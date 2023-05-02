import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/theme/color.dart';
class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}
class _SearchWidgetState extends State<SearchWidget> {
   String name='' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0.5,
        backgroundColor: mainColor,
        title:
           TextField(
            decoration: InputDecoration(
              prefixIcon:Icon(Icons.search_sharp),
              hintText: "Search... ",
            ),
            onChanged: (val){
              setState(() {
                name=val;
              });
            },
          ),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Books').snapshots(),
        builder: (context,snapshots){
          return (snapshots.connectionState==ConnectionState.waiting)?
          Center(child: CircularProgressIndicator(),):
          ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
                var data=snapshots.data!.docs[index].data() as Map<String,dynamic>;
                if(name.isEmpty){
                  return InkWell(
                    onTap: (){},
                    child: ListTile(
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
                    ),
                  );
                }
                if(data['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
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
      ),
    );
  }
}
