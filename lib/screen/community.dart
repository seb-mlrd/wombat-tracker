import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/convert_time.dart';
import 'package:wombat_tracker/utils/friend_relation.dart';
import 'package:wombat_tracker/utils/network/posts_network.dart';
import 'package:wombat_tracker/utils/text_services.dart';
import 'package:wombat_tracker/widget/app_bar_wombat.dart';
import 'package:wombat_tracker/widget/profil/thumbnail_user.dart';

class Community extends StatefulWidget {
  final List<dynamic> profils;
  const Community({super.key, required this.profils});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List allPostsFriends = [];
  bool isLoadData = true;

  Future<void> loadAllPosts() async {
    final friendsList = await FriendRelation.getFriend(widget.profils[0]["id"]);
    try {
      List responsePosts = await PostsNetwork().loadPostsByIdUsers(
        widget.profils[0]["id"],
        friendsList,
      );
      setState(() {
        allPostsFriends = responsePosts;
        isLoadData = false;
      });
    } catch (e) {
      throw Exception("Erreur lors de la requete des Posts : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadData) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBarWombat(mainTitle: "Communauté"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: allPostsFriends.isNotEmpty
                ? Column(
                    children: [
                      for (var postFriend in allPostsFriends)
                        templatePostUser(
                          postFriend.idUserWhoPost["avatar"],
                          postFriend.idUserWhoPost["firstName"],
                          postFriend.idUserWhoPost["lastName"],
                          postFriend.idStats["date"],
                          postFriend.idStats["time"],
                          postFriend.idStats["distance"],
                          postFriend.idStats["speed"],
                          // postFriend.idStats["post"],
                        ),
                    ],
                  )
                : Center(child: Text("Aucun post")),
          ),
        ),
      );
    }
  }

  Column templatePostUser(
    String avatar,
    String firstName,
    String lastName,
    String date,
    int time,
    int distance,
    int speed,
    // Prochaine intégration la posibilité de laisser des messages avec le poste
    // String textPost
  ) {
    return Column(
      children: [
        SizedBox(height: 24),
        ThumbnailUser(
          avatar: avatar,
          firstName: firstName,
          lastName: lastName,
          text: date,
          colorText: primaryBase,
          fontText: subSubTitle,
        ),
        SizedBox(height: 16),
        Image.asset("assets/img/map_test.png"),
        SizedBox(height: 16),

        containerLabelStat(
          ConvertTime().convertTimeToStringCompressed(time),
          "${TextServices.truncateInt((distance / 1000).toString(), 3)} km",
          // "Paris 11ème",
          "${TextServices.truncateInt(speed.toString(), 3)} km/h",
        ),
        SizedBox(height: 24),
        Divider(thickness: 2),
      ],
    );
  }

  Row containerLabelStat(
    String time,
    String distance,
    // Prochaine intégration
    // String location,
    String speed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        labelStatPost("assets/img/time_black.png", time),
        labelStatPost("assets/img/distance_black.png", distance),
        // labelStatPost("assets/img/location_black.png", location),
        labelStatPost("assets/img/speed_black.png", speed),
      ],
    );
  }

  Row labelStatPost(String icon, String time) {
    return Row(
      children: [
        Image.asset(icon),
        SizedBox(width: 10),
        Text(time, style: subSubSubTitle.copyWith(color: primaryBase)),
      ],
    );
  }
}
