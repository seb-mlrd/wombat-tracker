// lib/utils/class/posts.dart

class Posts {
  final int id;
  final String post;
  final Map idStats;
  final Map idUserWhoPost;

  Posts({
    required this.id,
    required this.post,
    required this.idStats,
    required this.idUserWhoPost,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "post": post,
      "idStats": idStats,
      "idUserWhoPost": idUserWhoPost,
    };
  }

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json["id"],
      post: json["post"],
      idStats: json["idStats"],
      idUserWhoPost: json["idUserWhoPost"],
    );
  }
}
