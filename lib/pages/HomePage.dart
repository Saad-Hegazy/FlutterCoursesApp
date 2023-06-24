import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prmagito/pages/Search.dart';
import 'package:prmagito/pages/booksFromCategory.dart';
import 'package:prmagito/pages/categoryPage.dart';
import 'package:prmagito/theme/color.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String? imagePath;
  File? image;
  List  categories=[];

  CollectionReference category = FirebaseFirestore.instance.collection('category');
  getCategoryData()async{
    var responsbody = await category.get();
    responsbody.docs.forEach((element) {
      setState(() {
        categories.add(element.data());
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
    getImagePath();
  }
  List imageList = [
    {"id": 1, "image_path": 'assets/images/wep.jpg'},
    {"id": 2, "image_path": 'assets/images/Database.png'},
    {"id": 3, "image_path": 'assets/images/python.jpeg'},
    {"id": 4, "image_path": 'assets/images/BCG-Flutter-Featured-Banner.png'},
    {"id": 5, "image_path": 'assets/images/Data-Structures.png'},
    {"id": 6, "image_path": 'assets/images/FREE-Python-Course-For-Beginners.png'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 50, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: appBarbackgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,5,0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap:(){
                      },
                      child: SvgPicture.asset("assets/icons/moon.svg")
                    ),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder)=> bottomsheet())
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: imagePath!=null ? FileImage(File(imagePath!)): AssetImage('assets/images/person-icon.png' ) as ImageProvider,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                color: appBarbackgroundColor,
                borderRadius: BorderRadius.circular(40),
                ),
              child: InkWell(
                      onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchWidget())),
                      child: Row(
                      children: <Widget>[
                      SvgPicture.asset("assets/icons/search.svg"),
                      SizedBox(width: 16),
                      const Text(
                      "Search... ",
                      style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFA0A5BD),
                      ),
                      )
                      ],
                      ),
              ),
              ),
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                        item['image_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Category", style: kTitleTextStyle),
                InkWell(
                 onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesPage())),
                  child: Text(
                    "See All",
                    style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                  ),
                ),
              ],
            ),
          SizedBox(height: 10,),
          Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()
                  =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BooksFromCategoryPage(categories[index]['name']))),

                  child: Container(

                    padding: EdgeInsets.all(20),
                    height: index.isEven ? 190 : 175,
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
                    style: kTitleTextStyle2,
                      ),
                    ],
                    ),
                  ),
                );
                },
              )
          )
          ],
        ),
    ),
    );
  }
  Widget bottomsheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text("Choose Profile Photo",
          style: TextStyle(
            fontSize: 20.0,),),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton.icon(

                  onPressed: (){
                    takePhoto(ImageSource.camera);
                  },

                  icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              SizedBox(width: 10,),
              TextButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery",),
              )
            ],
          )

        ],
      ),
    );

  }
  void takePhoto(ImageSource source)async{
 try{
   final image =await ImagePicker().pickImage(source: source,);
   if(image==null)return;
   saveImagePath(image.path.toString());
   setState(() {
     this.image= File(image.path);
   });
 }on PlatformException catch (e){
   print("Failed to pick image $e");
 }
  }
  void saveImagePath(String val)async{
    final sharedPref= await SharedPreferences.getInstance();
      sharedPref.setString('path', val);
      getImagePath();
  }
  void getImagePath()async{
    final sharedPref= await SharedPreferences.getInstance();
    setState(() {
      imagePath= sharedPref.getString('path');
    });
  }

}
