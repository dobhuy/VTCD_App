// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class NewMessage extends StatefulWidget {
//   const NewMessage({super.key});

//   @override
//   State<NewMessage> createState() => _NewMessageState();
// }

// class _NewMessageState extends State<NewMessage> {
//   var _messageController = TextEditingController();

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   void _submitMessage() async {
//     final enteredMessage = _messageController.text;

//     if (enteredMessage.trim().isEmpty) {
//       return;
//     }

//     _messageController.clear(); // clear the text
//     // FocusScope.of(context).unfocus(); // add this line to close keyboard, but we don't need because this is a texting app

//     final user = FirebaseAuth.instance.currentUser!;

//     final userData = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();
//     // send http request to firestore to retrieve data stored in user collection

//     FirebaseFirestore.instance.collection('chat').add({
//       'text': enteredMessage,
//       'timeCreated': DateTime.now(),
//       'userId': user.uid,
//       'username': userData.data()!['username'],
//       'userImage': userData.data()!['image_url'],
//     });
//     // automatically generated name instead of the one we made in auth_screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 10, bottom: 40),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               textCapitalization: TextCapitalization.sentences,
//               autocorrect: true,
//               enableSuggestions: true,
//               decoration: const InputDecoration(labelText: 'Send a message...'),
//             ),
//           ),
//           IconButton(
//             color: Theme.of(context).colorScheme.primary,
//             onPressed: _submitMessage,
//             icon: const Icon(Icons.send),
//           ),
//         ],
//       ),
//     );
//   }
// }
