class Modules {
  final int id;
  final String titleModule;
  final String objectif;
  final String materiel;

  Modules({
    required this.id,
    required this.titleModule,
    required this.materiel,
    required this.objectif,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "titleModule": this.titleModule,
      "objectif": this.objectif,
      "materiel": this.materiel,
    };
  }

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
      id: json["id"],
      titleModule: json["titleModule"],
      objectif: json["objectif"],
      materiel: json["materiel"],
    );
  }
}
