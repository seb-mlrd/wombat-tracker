// lib/utils/class/modules_network.dart

import 'package:supabase_flutter/supabase_flutter.dart';

// utils/class 
import 'package:wombat_tracker/utils/class/modules.dart';

class ModulesNetwork {
  static final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<List<Modules>> loadModules() async{
    try {
      final List<dynamic> response = await supabaseClient.from('modules').select('*');
      List<Modules> modules = response.map((json) => Modules.fromJson(json)).toList();
      return modules;
    } catch (e) {
      throw Exception('Erreur lors du chargement des modules : $e');
    }

  }
}