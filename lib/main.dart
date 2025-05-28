import 'package:flutter/material.dart';
import 'package:wombat_tracker/auth.dart';
import 'package:wombat_tracker/content.dart';
// import 'package:wombat_tracker/styles.dart';
import 'secret/supabase_secret_key.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: "${secretKey["SUPABASE_URL"]}",
    anonKey: "${secretKey["SUPABASE_ANON_KEY"]}",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: Scaffold(body: Center(child: Content())),
      home: Scaffold(body: Center(child: Auth())),
    );
  }
}
