import '../entities/closed_club.dart';
import '../entities/open_club.dart';
import '../entities/social_club.dart';
import '../entities/user.dart';
import 'dart:async';

abstract class Db {
  Future<void> createUser(User nuser);
  Future<User?> updateUser(User nuser);
  Future<User?> getUser();
  //OpenClub 
  //Открытый клуб
  Future<OpenClub?> createOpenClub(OpenClub club);
  Future<OpenClub?> updateOpenClub(OpenClub club);
  Future<void> deleteOpenClub(OpenClub club);
  //SocialClub 
  //клуб по подпискам
  Future<SocialClub?> createSocialClub(SocialClub club);
  Future<SocialClub?> updateSocialClub(SocialClub club);
  Future<void> deleteSocialClub(SocialClub club);
  //ClosedClub 
  //Открытый клуб
  Future<ClosedClub?> createClosedClub(ClosedClub club);
  Future<ClosedClub?> updateClosedClub(ClosedClub club);
  Future<void> deleteClosedClub(ClosedClub club);
  //Search
  //Поиск
  Future<List<OpenClub>?> findByTitle(String title);
  Future<List<SocialClub>?> socialClubs();
  Future<List<ClosedClub>?> closedClubs();
  bool initialised();
}