import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/utils/class/stats.dart';

class StatsNetwork {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<List<Stats>> loadBestStatsByIdUsers(int idUser) async {
    try {
      final List<dynamic> response = await supabaseClient
          .from("stats")
          .select()
          .eq("idUser", idUser)
          .order('distance', ascending: false)
          .limit(1);
      List<Stats> stats = response.map((json) => Stats.fromJson(json)).toList();
      return stats;
    } catch (e) {
      throw Exception("Erreur lors de la réceptions des Stats : $e");
    }
  }

  Future fetchStats(List data) async {
    try {
      print("❌ici❌");
      await supabaseClient.from("stats").insert(data);
    } catch (e) {
      throw Exception("Erreur lors de l'envoi des Stats : $e");
    }
  }
}
