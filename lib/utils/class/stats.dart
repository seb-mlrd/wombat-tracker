// lib/utils/class/stats.dart

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
      id: json["id"],
      time: json["time"],
      distance: json["distance"],
      speed: json["speed"],
      date: json["date"],
      idUser: json["idUser"],
    );
  }
}
