import 'package:flutter/material.dart';
import 'package:wombat_tracker/content.dart';
// import 'package:wombat_tracker/styles.dart';
import './secret/supabase-secret-key.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: "${secret_key["SUPABASE_URL"]}",
    anonKey: "${secret_key["SUPABASE_ANON_KEY"]}",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Content())),
    );
  }
}
