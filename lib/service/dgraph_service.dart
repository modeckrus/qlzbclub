import 'dart:async';
import 'dart:io';

import '../entities/social_club.dart';
import '../entities/open_club.dart';
import '../entities/closed_club.dart';
import 'db_service.dart';
import 'path_service.dart';
import 'user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../entities/user.dart';

class Dgraph extends Db {
  GraphQLClient? graph;
  GraphQLClient? nocache;
  String? jwtToken;
  static String get host => Platform.isAndroid ? '10.0.2.2' : 'localhost';
  String? uid;
  @override
  bool initialised() {
    return isInited;
  }

  bool isInited = false;
  Future<int> init() async {
    jwtToken = await GetIt.I.get<UserService>().getJwtToken();
    uid = GetIt.I.get<UserService>().user!.fid;
    final HttpLink _httpLink = HttpLink(
      'http://$host:8080/graphql',
      // defaultHeaders: {'X-Auth-Token': jwtToken}
    );

    final WebSocketLink websocketLink = WebSocketLink(
      'ws://$host:8080/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 180),
        delayBetweenReconnectionAttempts: const Duration(seconds: 180),
        initialPayload: () async {
          // return {'X-Auth-Token': jwtToken};
        },
      ),
    );
    final _link = Link.split(
        (request) => request.isSubscription, websocketLink, _httpLink);

    graph = GraphQLClient(
      cache: GraphQLCache(
        store: await HiveStore.open(path: PathService.hiveDir),
      ),
      link: _link,
    );
    nocache = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
    GetIt.I.registerFactory(() => graph, instanceName: 'graphql');
    GetIt.I.registerFactory(() => nocache, instanceName: 'nocache');
    isInited = true;
    return 1;
  }

  // static Future<String> updateUserClaims() async {
  //   String url =
  //       'https://us-central1-qlzbclubhouse.cloudfunctions.net/addUserClaim?email=';
  //   Map<String, String> headers = {"Content-type": "application/json"};
  //   String json = '{"email": "$uid"}';
  //   http.Response res = await http.post(url, headers: headers, body: json);
  //   if (res.statusCode > 300) {
  //     print('Error while updateClaims');
  //     print(res.body);
  //     return '';
  //   }
  //   return fdart.FirebaseAuth.instance.tokenProvider.idToken;
  // }

  static const String addOpenClubStr = r'''
mutation AddOpenClub($title: String!, $description: String!, $avatarUrl: String, $tags:[String!], $fid: String!, $moderators: [UserRef!]){
  addOpenClub(input: [
    {
      owner: {
        fid: $fid
      }
      title: $title
      description: $description
      avatarUrl: $avatarUrl
      tags: $tags
      moderators: $moderators
      members: [
        {
          fid: $fid
        }
      ]
    }
  ]){
    openClub{
      owner{
        fid
      }
      moderators{
        fid
      	name
        avatarUrl
      }
      members{
        fid
        name
        avatarUrl
      }
      title
      description
      tags
    }
  }
}
  ''';

  static const String getUserStr = r'''
  query GetUser($fid: String!){
  queryUser(filter:  {fid: {eq: $fid} }){
      fid
      name
      bio
      socials
      createdAt
      lastLogin
      link
      tags
  }
}
''';
  Future<User?> getUser() async {
    final result = await nocache?.query(
        QueryOptions(document: gql(getUserStr), variables: {'fid': uid}));
    if (result == null) {
      return null;
    }
    if (!result.hasException && result.isConcrete) {
      final userMap = result.data['queryUser'][0];
      final user = User.fromMap(userMap);
      return user;
    }
  }

  static Future deleteAccount() async {
    throw UnimplementedError();
  }

  static const String updateUserStr = r'''
mutation UpdateUser($fid: String!, $name: String!, $bio: String, $socials: [String!], $lastLogin: DateTime!, $link: String, $tags: [String!]){
  updateUser(input: {
    filter:{
      fid: {eq: $fid}
    }
    set: {
      name: $name,
      bio: $bio,
      socials: $socials,
      lastLogin: $lastLogin,
      link: $link,
      tags: $tags
    }
  }){
    user{
      fid
      name
      bio
      socials
      createdAt
      lastLogin
      link
      tags
    }
  }
}
  ''';
  @override
  Future<User?> updateUser(User newUser) async {
    final result = await graph
        ?.mutate(MutationOptions(document: gql(updateUserStr), variables: {
      'fid': uid,
      'name': newUser.name,
      'bio': newUser.bio,
      'lastLogin': DateTime.now().toIso8601String(),
      'tags': newUser.tags
    }));
    if (result == null) return null;
    if (result.isConcrete) {
      final userJs = result.data['updateUser']['user'][0];
      final user = User.fromMap(userJs);
      return user;
    } else {
      print('UpdateUser exeption');
    }
  }

  static const String closedClubsStr = r'''

  ''';

  @override
  Future<List<ClosedClub>?> closedClubs() async {
    try {
      final result = await graph?.query(QueryOptions(
          document: gql(
            closedClubsStr,
          ),
          variables: {

          }));
      if (result!.isConcrete) {
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }

    return null;
  }

  static const String createClosedClubStr = r'''
mutation AddClosedClub($title: String!, $description: String!, $avatarUrl: String, $tags:[String!], $fid: String!, $moderators: [UserRef!]){
  addClosedClub(input: [
    {
      owner: {
        fid: $fid
      }
      title: $title
      description: $description
      avatarUrl: $avatarUrl
      tags: $tags
      moderators: $moderators
      members: [
        {
          fid: $fid
        }
      ]
    }
  ]){
    closedClub{
      owner{
        fid
        name
        avatarUrl
      }
      moderators{
        fid
      	name
        avatarUrl
      }
      members{
        fid
        name
        avatarUrl
      }
      title
      description
      tags
      invitedPeoples{
        fid
        name
        avatarUrl
      }
    }
  }
}
  ''';
  @override
  Future<ClosedClub?> createClosedClub(ClosedClub club) async{
    final result = await graph?.mutate(MutationOptions(
      document: gql(createClosedClubStr),
      variables: {
        'title':club.title,
        'description': club.description,
        'avatarUrl':club.avatarUrl,
        'tags':club.tags,
        'fid':uid,
        'moderators': [
          uid,
          ...club.moderators
        ],
        
      }
    ));
  }

  @override
  Future<SocialClub> createSocialClub(SocialClub club) {
    // TODO: implement createSocialClub
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(User nuser) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteClosedClub(ClosedClub club) {
    // TODO: implement deleteClosedClub
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOpenClub(OpenClub club) {
    // TODO: implement deleteOpenClub
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSocialClub(SocialClub club) {
    // TODO: implement deleteSocialClub
    throw UnimplementedError();
  }

  @override
  Future<List<OpenClub>> findByTitle(String title) {
    // TODO: implement findByTitle
    throw UnimplementedError();
  }

  @override
  Future<List<SocialClub>> socialClubs() {
    // TODO: implement socialClubs
    throw UnimplementedError();
  }

  @override
  Future<ClosedClub> updateClosedClub(ClosedClub club) {
    // TODO: implement updateClosedClub
    throw UnimplementedError();
  }

  @override
  Future<OpenClub> updateOpenClub(OpenClub club) {
    // TODO: implement updateOpenClub
    throw UnimplementedError();
  }

  @override
  Future<SocialClub> updateSocialClub(SocialClub club) {
    // TODO: implement updateSocialClub
    throw UnimplementedError();
  }

  @override
  Future<OpenClub> createOpenClub(OpenClub club) {
    // TODO: implement createOpenClub
    throw UnimplementedError();
  }
}
