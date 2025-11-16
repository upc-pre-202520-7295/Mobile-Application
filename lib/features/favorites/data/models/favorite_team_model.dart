import 'package:betalyze_mobile/features/favorites/data/models/team_model.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';
import 'package:betalyze_mobile/features/user_management/data/models/user_model.dart';


class FavoriteTeamModel extends FavoriteTeam{
  const FavoriteTeamModel({
    required super.id,
    required super.team,
    required super.user});

  factory FavoriteTeamModel.fromJson(Map<String, dynamic> json) {
    final teamMap = json['team'] as Map<String, dynamic>;
    final userMap = json['user'] as Map<String, dynamic>;
    return FavoriteTeamModel(
      id: json['id'] as int,
      team: TeamModel.fromJson(teamMap),
      user: UserModel.fromJson(userMap),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team': (team as TeamModel).toJson(),
      'user': (user as UserModel).toJson(),
    };
  }

  factory FavoriteTeamModel.fromEntity(FavoriteTeam favTeam){
    return FavoriteTeamModel(
        id: favTeam.id,
        team: favTeam.team,
        user: favTeam.user
    );
  }

}