import 'package:flutter/material.dart';
import 'package:prmagito/utils/provider.dart';

 const bool darkmode=true;

class VA extends StatefulWidget {
  const VA({Key? key}) : super(key: key);

  @override
  State<VA> createState() => _VAState();
}

class _VAState extends State<VA> {
  @override
  Widget build(BuildContext context) {
    var  provaider= VriableProvaoder.of(context);
        provaider?.darkmode;

    return const Placeholder();
  }
}

const darker = Color(0xFF070A52);


const communityCardBackGroundColor= darkmode ? Color(0xFF8294C4) : Colors.white;

const appBarbackgroundColor = darkmode ?Color(0xFF576CBC):Color(0xFFF7F7F7);

const textColor= darkmode ? Color(0xFFFFB100):  Colors.white ;

const textFiledBackGroundColor=darkmode ?Color(0xFF576CBC):Colors.white;

const BottombarbackGroundColor=darkmode ?Color(0xFF2A2F4F) :Colors.white ;

const  greyColor= darkmode ? Colors.white :  Colors.grey;

const scaffoldBackgroundColor= darkmode ? darker : Colors.white;
const boBackgroundColor= darkmode ? Color(0xFF576CBC) : Colors.white;
const whiteColor =darkmode ? Colors.white : Colors.black;
const mainColor = darkmode ? darker : Color(0xFFF7F7F7);
const primary =darkmode ? Color(0xFFD989B5) :  Color(0xFFf77080);
const shadowColor = darkmode ? Colors.white : Colors.black87;
const kBlackColor = darkmode ? Colors.white : Color(0xFF393939);
const blackColor =darkmode ? Colors.white :  Colors.black87;
const kBlueColor = Color(0xFF6E8AFA);
const yellow = Color(0xFFffcb66);





// My Text Styles

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle2 = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);


const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: whiteColor,
  // fontWeight: FontWeight.bold,
);
