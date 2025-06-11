import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/utils/class/posts.dart';

class PostsNetwork {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<List<Posts>> loadPostsByIdUsers(
    int idUserWhoConnect,
    List listFriends,
  ) async {
    List<int> newListe = [
      ...listFriends
          .map((friend) => friend['id'])
          .where((id) => id != null)
          .cast<int>(),
      idUserWhoConnect,
    ];
    try {
      final List<dynamic> response = await supabaseClient
          .from("posts")
          .select()
          .inFilter("idUser", newListe);
      print(newListe);
      print(listFriends);
      List<Posts> stats = response.map((json) => Posts.fromJson(json)).toList();
      print(stats);
      return stats;
    } catch (e) {
      throw Exception("Erreur lors de la réceptions des Stats : $e");
    }
  }

  Future fetchPostsByIdUsers(List data) async {
    try {
      await supabaseClient.from("posts").insert(data);
    } catch (e) {
      throw Exception("Erreur lors de l'envoi des Stats : $e");
    }
  }
}
