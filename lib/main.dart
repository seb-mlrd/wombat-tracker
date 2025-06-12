// lib/main.dart

import 'package:flutter/material.dart';

// screen 
import 'package:wombat_tracker/is_auth.dart';

// secretKey 
import 'secret/supabase_secret_key.dart';

// supabase 
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  
  await Supabase.initialize(
    url: "${secretKey["SUPABASE_URL"]}",
    anonKey: "${secretKey["SUPABASE_ANON_KEY"]}",
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: IsAuth(supabase: supabase));
  }
}