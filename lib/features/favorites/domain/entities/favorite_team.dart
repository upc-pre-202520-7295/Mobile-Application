
import 'package:betalyze_mobile/features/favorites/domain/entities/team.dart';

import '../../../user_management/domain/entities/user.dart';

class FavoriteTeam{
  final int id;
  final Team team;
  final User user;
  const FavoriteTeam({
   required this.id,
   required this.team,
   required this.user,
  });
}