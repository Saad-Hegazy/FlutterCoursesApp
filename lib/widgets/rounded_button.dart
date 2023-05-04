import 'package:flutter/material.dart';
import 'package:prmagito/pages/root_app.dart';
import 'package:prmagito/theme/color.dart';
class RoundedButton extends StatelessWidget {

  final String text;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  RoundedButton({
    required this.text,
    this.verticalPadding = 16,
    this.horizontalPadding = 30,
    this.fontSize = 16,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RootApp()));},
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 20),
        padding:
        EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Color(0xFF666666).withOpacity(.11),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}