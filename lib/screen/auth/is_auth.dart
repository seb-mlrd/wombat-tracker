import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/auth.dart';
import 'package:wombat_tracker/content.dart';

class IsAuth extends StatefulWidget {
  final SupabaseClient supabase;
  const IsAuth({super.key, required this.supabase});

  @override
  State<IsAuth> createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = widget.supabase.auth.currentUser;

    widget.supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        user = data.session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(body: Center(child: Auth()));
    } else {
      return const Scaffold(body: Center(child: Content()));
    }
  }
}
