// lib/utils/network/sequences_network.dart


import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/utils/class/sequences.dart';

class SequencesNetwork {
  static final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<List<Sequences>> loadSequence(int idSequence) async {
    try {
      final List<dynamic> response = await supabaseClient
          .from("sequences")
          .select()
          .eq("idModule", idSequence);
      List<Sequences> sequences = response
          .map((json) => Sequences.fromJson(json))
          .toList();
      return sequences;
    } catch (e) {
      throw Exception("Erreur lors de la réceptions des sequences : $e");
    }
  }
}
