import 'package:betalyze_mobile/domain/Match.dart';
import 'package:betalyze_mobile/services/favoriteClient.dart';
import 'package:betalyze_mobile/views/widgets/match_card.dart';
import 'package:betalyze_mobile/views/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import '../services/matchClient.dart';

var mockUserId = "64a4d231-0846-4d96-9dbc-82cd3789ec87";

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<MatchGame> _matches = [];
  MatchClient client = MatchClient();
  FavoriteTeamClient favoriteTeamClient = FavoriteTeamClient();
  TextEditingController _seasonController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  void _updateMatches() {
    print("[DashboardView._updateMatches] season: '${_seasonController.text.isEmpty}'");
    print("[DashboardView._updateMatches] startDate: '${_startDateController.text}'");
    print("[DashboardView._updateMatches] endDate: '${_endDateController.text}'");

    String? season = _seasonController.text.isNotEmpty ? _seasonController.text.trim() : null;
    String? startDate = _startDateController.text.isNotEmpty ? _startDateController.text.trim() : null;
    String? endDate = _endDateController.text.isNotEmpty ? _endDateController.text.trim() : null;

    client.getPredictions(season, startDate, endDate).then((value) {
      setState(() {
        _matches = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _updateMatches();
  }

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> datePicker() async {
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar(context, 'Notifications'),
        onSettingsTap: () => _showSnackBar(context, 'Settings'),
        onProfileTap: () => _showSnackBar(context, 'Profile'),
      ),

      body: RefreshIndicator(
        onRefresh: () async => _updateMatches(),
        color: const Color(0xFF00D9A3),
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Matches',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            // // Filters
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        controller: _seasonController,
                        decoration: const InputDecoration(
                          hintText: 'Search for a season',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onChanged: (value) {
                          // debouncer
                          setState(() {
                            _seasonController.text = value;

                            // debouncer
                            _updateMatches();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      child: TextField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          hintText: 'Search for a start date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onTap: () async {
                          var selection = await datePicker();
                          if (selection != null) {
                            setState(() {
                              var date = selection.toLocal();
                              var year = date.year;
                              var month = date.month;
                              var day = date.day;

                              _startDateController.text = '$year-$month-$day';

                              _updateMatches();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      child: TextField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          hintText: 'Search for an end date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onTap: () async {
                          var selection = await datePicker();
                          if (selection != null) {
                            setState(() {
                              var date = selection.toLocal();
                              var year = date.year;
                              var month = date.month;
                              var day = date.day;

                              _startDateController.text = '$year-$month-$day';

                              _updateMatches();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (_matches.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'No matches found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  return MatchCard(
                    match: _matches[index],
                    onPressedHomeStar: () {
                      var userId = mockUserId;
                      favoriteTeamClient.addTeam(userId, _matches[index].home_team_name).then((value) {
                        setState(() {
                          _updateMatches();
                        });
                      });
                    },
                    onPressedAwayStar: () {
                      var userId = mockUserId;
                      favoriteTeamClient.addTeam(userId, _matches[index].away_team_name).then((value) {
                        setState(() {
                          _updateMatches();
                        });
                      });
                    },
                    onDetailsTap: () {
                //       Navigator.push(
                // context,
                //   MaterialPageRoute(builder: (context) => SegundaVista()),
                //       );
                    },
                  );
                }, childCount: _matches.isEmpty ? 1 : _matches.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00D9A3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
