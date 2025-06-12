// lib/utils/class/sequences.dart

class Sequences {
  final int id;
  final String titleSequences;
  final List descriptionSequences;
  final int duration;
  final int numberOfCircuit;
  final int idModule;

  Sequences({
    required this.id,
    required this.titleSequences,
    required this.descriptionSequences,
    required this.duration,
    required this.idModule,
    required this.numberOfCircuit,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titleSequences": titleSequences,
      "descriptionSequences": descriptionSequences,
      "duration": duration,
      "idModule": idModule,
      "numberOfCircuit": numberOfCircuit,
    };
  }

  factory Sequences.fromJson(Map<String, dynamic> json) {
    return Sequences(
      id: json["id"],
      titleSequences: json["titleSequences"],
      descriptionSequences: json["descriptionSequences"],
      duration: json["duration"],
      idModule: json["idModule"],
      numberOfCircuit: json["numberOfCircuit"],
    );
  }
}
