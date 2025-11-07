import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/shopping_list/presentation/lists_page.dart';
import 'features/shopping_list/presentation/sign_in_page.dart';

class OFAApp extends StatelessWidget {
  const OFAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OFA - Lista de Compras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final user = snapshot.data;
        if (user == null) {
          return const SignInPage();
        } else {
          return const ListsPage();
        }
      },
    );
  }
}
