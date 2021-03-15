import 'package:clubhouse/entities/open_club.dart';
import 'package:clubhouse/entities/user.dart';
import 'package:clubhouse/service/db_service.dart';
import 'package:clubhouse/widgets/avatar_widget.dart';
import 'package:clubhouse/widgets/open_club_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ClubListPage extends StatefulWidget {
  const ClubListPage({Key? key}) : super(key: key);
  @override
  _ClubListPageState createState() => _ClubListPageState();
}

class _ClubListPageState extends State<ClubListPage> {
  TextEditingController _search = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
              onPressed: () {},
              icon: AvatarWidget(avatarUrl: GetIt.I.get<User>().photoUrl,)
              ),
        ],
      ),
      body: FutureBuilder(
        future: GetIt.I.get<Db>().findByTitle('Animal'),
        builder: (context, snap){
        if(!snap.hasData){
          return CircularProgressIndicator();
        }
        if(snap.hasError){
          return ErrorWidget(snap.error.toString());
        }
        if(snap.data == null){
          return ErrorWidget(snap.error.toString());
        }
        final List<OpenClub> clubs = snap.data as List<OpenClub>;
        return Container(
          child: CupertinoScrollbar(
            controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, index){
                          final club = clubs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0),
                            child: OpenClubWidget(club: club),
                          );
                        },
                        itemCount: clubs.length,
            ),
          ),
        );
      }),
    ));
  }
}
