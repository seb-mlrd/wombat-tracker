import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/utils/class/stats.dart';

class StatsNetwork {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<List<dynamic>> loadBestStatsByIdUsers(int idUser) async {
    try {
      final List<dynamic> response = await supabaseClient
          .from("stats")
          .select()
          .eq("idUser", idUser)
          .order('distance', ascending: false)
          .limit(1);
      return response;
    } catch (e) {
      throw Exception("Erreur lors de la réceptions des Stats : $e");
    }
  }

  Future fetchStats(List data) async {
    try {
      final response = await supabaseClient.from("stats").insert(data).select();
      return response[0]["id"];
    } catch (e) {
      throw Exception("Erreur lors de l'envoi des Stats : $e");
    }
  }
}
