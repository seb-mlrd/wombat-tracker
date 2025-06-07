import 'package:supabase_flutter/supabase_flutter.dart';

class FriendRelation {
  static final SupabaseClient supabaseClient = Supabase.instance.client;

  static sendRequest(int idRecieve, int idCurrentUser) async {
    await supabaseClient.from('friend-relation').insert([
      {"friendId": idRecieve, "requesterId": idCurrentUser},
    ]);
  }

  static Future<List<Map<String, dynamic>>> getFriend(int idUser) async {
    var friends = await supabaseClient
        .from('friend-relation')
        .select(
          "friendId(firstName, lastName, avatar, bio), requesterId(firstName, lastName, avatar, bio)",
        )
        .eq("requesterId", idUser);
    return friends;
  }

  static Future<PostgrestList> getIdFriend(int idUser) async {
    var friends = await supabaseClient
        .from('friend-relation')
        .select("friendId(id)")
        .eq("requesterId", idUser);
    return friends;
  }
}
