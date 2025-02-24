import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'pages/community/Adopt.dart';
import 'pages/community/Locate.dart';
import 'pages/community/Sitter.dart';
import 'pages/chats/Chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("✅ Firebase initialized successfully");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Community',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/adopt',
      // Start with the Adopt page
      routes: {
        '/adopt': (context) => const Adopt(),
        '/locate': (context) => const Locate(),
        '/sitter': (context) => const Sitter(),
        '/chat': (context) => Chat(),
      },
    );
  }

  void sendMessage(String senderId, String receiverId, String message) {
    FirebaseFirestore.instance.collection('messages').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}