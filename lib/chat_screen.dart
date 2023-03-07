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
                      reverse: true,
                      controller: scrollController,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final bool isMe =
                            docs[index]['from'] == user.currentUser?.email;
                        return Message(
                          isMe: isMe,
                          sender: docs[index]['from'],
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
  final bool isMe;
  final String sender;
  final String text;

  const Message({
    Key? key,
    required this.isMe,
    required this.sender,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isMe ? 48 : 0,
        right: isMe ? 0 : 48,
      ),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                sender,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
