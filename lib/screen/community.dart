import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/class/posts.dart';
import 'package:wombat_tracker/utils/friend_relation.dart';
import 'package:wombat_tracker/utils/network/posts_network.dart';
import 'package:wombat_tracker/widget/app_bar_wombat.dart';
import 'package:wombat_tracker/widget/profil/thumbnail_user.dart';

class Community extends StatefulWidget {
  final List<dynamic> profils;
  const Community({super.key, required this.profils});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  late Future<List<Posts>> allPostsFuture;

  Future<List<Posts>> loadAllPosts() async {
    final friendsList = await FriendRelation.getFriend(widget.profils[0]["id"]);
    return await PostsNetwork().loadPostsByIdUsers(
      widget.profils[0]["id"],
      friendsList,
    );
  }

  @override
  void initState() {
    super.initState();
    allPostsFuture = loadAllPosts();
    print(allPostsFuture);

    // print(allPostsFuture);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWombat(mainTitle: "Communauté"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [for (var i = 0; i < 5; i++) templatePostUser()],
          ),
        ),
      ),
    );
  }

  Column templatePostUser() {
    return Column(
      children: [
        SizedBox(height: 24),
        ThumbnailUser(
          avatar: "avatar.png",
          firstName: "james",
          lastName: "Ahmaedaly",
          text: "17/05/2025    17:06",
          colorText: primaryBase,
          fontText: subSubTitle,
        ),
        SizedBox(height: 16),
        Image.asset("assets/img/map_test.png"),
        SizedBox(height: 16),

        containerLabelStat("01:12:54", "10 km", "Paris 11ème", "5.4 km/h"),
        SizedBox(height: 24),
        Divider(thickness: 2),
      ],
    );
  }

  Row containerLabelStat(
    String time,
    String distance,
    String location,
    String speed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        labelStatPost("assets/img/time_black.png", time),
        labelStatPost("assets/img/distance_black.png", distance),
        labelStatPost("assets/img/location_black.png", location),
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
