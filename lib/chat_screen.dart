import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_chat/custom_textformfield.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  final messageController = TextEditingController();
  final user = FirebaseAuth.instance;
  Future<void> callback() async {
    if (messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('messages').add(
        {
          'text': messageController.text,
          'from': user.currentUser!.email,
        },
      );
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: 300.milliseconds, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset('assets/png/logo.png'),
          ),
        ),
        title: const Text('IChat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.back();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final List<QueryDocumentSnapshot> docs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      reverse: false,
                      controller: scrollController,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final bool isMe =
                            docs[index]['from'] == user.currentUser?.email;
                        return Message(
                          me: isMe,
                          from: docs[index]['from'],
                          text: docs[index]['text'],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextformField(
                    hintText: 'Messages',
                    controller: messageController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    callback();
                  },
                  icon: const Icon(Icons.send_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final bool me;
  final String from;
  final String text;
  const Message({
    super.key,
    required this.me,
    required this.from,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(from).marginAll(5),
          Material(
            color: me ? Colors.teal : Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(text),
              ),
            ),
          ).marginAll(5),
        ],
      ),
    );
  }
}
