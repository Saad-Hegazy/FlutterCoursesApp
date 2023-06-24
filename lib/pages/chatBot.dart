import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:prmagito/pages/Messages.dart';
import 'package:prmagito/theme/color.dart';

class CharBotPage extends StatefulWidget {
  const CharBotPage({Key? key}) : super(key: key);

  @override
  State<CharBotPage> createState() => _CharBotPageState();
}

class _CharBotPageState extends State<CharBotPage> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: appBarbackgroundColor,
        title: Center(
            child: Text(
          "CHAT BOT",
          style: TextStyle(
              fontSize: 28, color: blackColor, fontWeight: FontWeight.w600),
        )),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: textFiledBackGroundColor,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        textAlign: TextAlign.end ,
                    decoration: InputDecoration(
                      hintText: "   write Start...  ",

                      hintStyle:TextStyle(
                            fontSize: 18, color: blackColor, fontWeight: FontWeight.w500),

                    ),
                    controller: _controller,
                            style:TextStyle(fontSize: 18, color: blackColor,fontWeight: FontWeight.w500) ,
                  ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: blackColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
