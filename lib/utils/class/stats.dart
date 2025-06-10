class Stats {
  final int id;
  final String time;
  final int distance;
  final int speed;
  final int idUser;
  final DateTime date;
  Stats({
    required this.date,
    required this.distance,
    required this.id,
    required this.idUser,
    required this.speed,
    required this.time,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "distance": distance,
      "date": date,
      "idUser": idUser,
      "speed": speed,
      "time": time,
    };
  }

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      date: json["date"],
      distance: json["distance"],
      id: json["id"],
      idUser: json["idUser"],
      speed: json["speed"],
      time: json["time"],
    );
  }
}
