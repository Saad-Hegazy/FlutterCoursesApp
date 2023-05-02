import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prmagito/pages/root_app.dart';
import 'package:prmagito/theme/color.dart';
import 'package:prmagito/widgets/rounded_button.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/gradient.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
                "assets/icons/programing.svg",
              width: 100,
              height: 210,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall,
                children: [
                  TextSpan(
                    text: "Parma",
                    style: TextStyle(color: mainColor),
                  ),
                  TextSpan(
                    text: "gito.",
                    style: TextStyle(fontWeight: FontWeight.bold,color:mainColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: RoundedButton(
                text: "Start Your Journey",
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
