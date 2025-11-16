import 'package:betalyze_mobile/features/favorites/domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({required super.id, required super.fullname});

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      TeamModel(id: json['id'] as int, fullname: json['fullname'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'fullname': fullname};

  factory TeamModel.fromEntity(Team team) =>
      TeamModel(id: team.id, fullname: team.fullname);
}
