import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';
import '../Widgets/chatbot/chatmodel.dart';
import '../Widgets/chatbot/globalmembers.dart';
import '../Widgets/chatbot/receiver.dart';
import '../Widgets/chatbot/sender.dart';

class MyChatUI extends StatefulWidget {
  const MyChatUI({Key? key}) : super(key: key);

  @override
  MyChatUIState createState() => MyChatUIState();
}

class MyChatUIState extends State<MyChatUI> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: Colors.purple.shade300,

        leadingWidth: 20,
        leading: GestureDetector(
          onTap: () {
            // Call the function to go back
            Navigator.of(context).pop();
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            ),
          ),
        ),
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/256/12430/12430768.png"),
          ),
          title: const Text(
            'Chatbot',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20),
        //     child: Icon(Icons.videocam_rounded),
        //   ),
        //   Padding(
        //     padd-ing: EdgeInsets.only(right: 20),
        //     child: Icon(Icons.call),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: chatModelList.length,
                itemBuilder: (context, index) => chatModelList[index].isMee
                    ? SenderRowView(
                        index: index,
                      )
                    : ReceiverRowView(index: index),
              )),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0, left: 8),
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Color(0xffba68c8),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, true));
                      animateList();
                    });
                    final GoogleTranslator _translator = GoogleTranslator();
                    Translation translation =
                        await _translator.translate(controller.text, to: 'en');

                    var prefs = await SharedPreferences.getInstance();
                    var response = await http.post(
                        Uri.parse(
                          'https://hackathon.aldoiris.online/api/get_data/',
                        ),
                        body: {
                          'latitude': prefs.getString('latitude'),
                          'longitude': prefs.getString('longitude'),
                          'query': translation.text
                        });
                    if (response.statusCode != 200) {
                      setState(() {
                        chatModelList.add(ChatModel(
                            ' ಏನೋ ತಪ್ಪಾಗಿದೆ ದಯವಿಟ್ಟು ಸ್ವಲ್ಪ ಸಮಯದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ',
                            false));
                      });
                    } else {


                      for (var element in jsonDecode(utf8.decode(response.bodyBytes))) {
                       Translation nameTranslation = await _translator.translate(element['name'], to: 'kn');
                       Translation addressTranslation = await _translator.translate(element['address'], to: 'kn');
                      setState(() {
                        chatModelList.add(ChatModel('Name: ${nameTranslation.text}\nAddress: ${addressTranslation.text}\nPhone: ${element['phone']}', false));
                      });
                      }
                    }
                    print(response.body);
                    controller.clear();
                  },
                  onLongPress: () {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, false));
                      animateList();
                      controller.clear();
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffba68c8),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
