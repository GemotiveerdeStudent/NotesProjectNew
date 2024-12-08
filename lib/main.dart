import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Notes Project',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 96, 150, 219)),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          print('Connection state: ${snapshot.connectionState}');
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Text('Error initializing Firebase');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              final emailVerified = user?.emailVerified ?? false;
              if (emailVerified) {
                print('You are a verified user');
              } else {
                print('You are not a verified user, you need to verify!');
              }
              return const Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}