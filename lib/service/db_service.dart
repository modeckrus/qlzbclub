import '../entities/closed_club.dart';
import '../entities/open_club.dart';
import '../entities/social_club.dart';
import '../entities/user.dart';
import 'dart:async';

abstract class Db {
  Future<User?> createUser(User nuser);
  Future<User?> updateUser(User nuser);
  Future<User?> getUser();
  //OpenClub 
  //Открытый клуб
  Future<OpenClub?> createOpenClub(OpenClub club);
  //SocialClub 
  //клуб по подпискам
  Future<SocialClub?> createSocialClub(SocialClub club);
  //ClosedClub 
  //Открытый клуб
  Future<ClosedClub?> createClosedClub(ClosedClub club);

  Future<OpenClub?> updateClub(OpenClub club);
  Future<ClosedClub?> invitePeople(String clubId, List<String> peoples);

  Future<bool> deleteClub(String id);
  //Search
  //Поиск
  Future<List<OpenClub>?> findByTitle(String title);
  Future<List<SocialClub>?> socialClubs();
  Future<List<ClosedClub>?> closedClubs();
  bool initialised();
}