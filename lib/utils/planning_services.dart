import 'package:supabase_flutter/supabase_flutter.dart';

class PlanningServices {
  static final SupabaseClient supabaseClient = Supabase.instance.client;
  Future<PostgrestList> getPlanning() async {
    var response = await supabaseClient.from('planning').select('*');
    return response;
  }
}
