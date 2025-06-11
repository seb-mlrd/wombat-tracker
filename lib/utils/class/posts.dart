class Posts {
  final int id;
  final String post;
  final int idStats;
  final int idUserWhoPost;

  Posts({
    required this.id,
    required this.idStats,
    required this.idUserWhoPost,
    required this.post,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idStats": idStats,
      "idUserWhoPost": idUserWhoPost,
      "post": post,
    };
  }

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      idStats: json["idStats"],
      idUserWhoPost: json["idUserWhoPost"],
      id: json["id"],
      post: json["post"],
    );
  }
}
