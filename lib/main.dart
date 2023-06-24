import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/pages/Start.dart';
import 'package:prmagito/theme/color.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parmageto',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          textTheme: Theme.of(context).textTheme.apply(displayColor: kBlackColor,),
        ),
        home: WelcomeScreen(),
      );

  }
}
