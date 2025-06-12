// lib/utils/network/post_network.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/utils/class/posts.dart';

class PostsNetwork {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<List<Posts>> loadPostsByIdUsers(int idUserWhoConnect, List listFriends) async {
    try {
      List newListe = [
        ...listFriends.map((friend) => friend["friendId"]['id']),
        idUserWhoConnect,
      ];
      final List response = await supabaseClient
          .from("posts")
          .select(
            "id, post, idStats(time, distance, speed, date) ,idUserWhoPost(firstName, lastName, avatar) ",
          )
          .inFilter("idUserWhoPost(id)", newListe);
      List<Posts> posts = response.map((json) => Posts.fromJson(json)).toList();
      return posts;
    } catch (e) {
      throw Exception("Erreur lors de la réceptions des Posts : $e");
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
