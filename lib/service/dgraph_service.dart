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
mutation AddClosedClub($title: String!, $description: String!, $avatarUrl: String, $tags:[String!], $fid: String!, $moderators: [UserRef!], $invitedPeoples: [String!]){
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
      ],
      invitedPeoples: $invitedPeoples
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
      invitedPeoples
    }
  }
}
  ''';
  @override
  Future<ClosedClub?> createClosedClub(ClosedClub club) async{
    try{
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
        'invitedPeoples': club.invitedPeoples
      }
    ));
    if(result!.isConcrete){
      if(result.data['closedClub'] == null){
        print('Data null');
        return null;
      }
      final cclub = ClosedClub.fromMap(result.data['closedClub']);
      return cclub;
    }else{
      print('Result not concrete');
      return null;
    }
    }catch(e){
      print(e);
      return null;
    }
  }

  static const String createSocialClubStr = r'''
mutation AddSocialClub($title: String!, $description: String!, $avatarUrl: String, $tags:[String!], $fid: String!, $moderators: [UserRef!]){
  addSocialClub(input: [
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
    socialClub{
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
    }
  }
}
  ''';

  @override
  Future<SocialClub?> createSocialClub(SocialClub club) async{
    try{
    final result = await graph?.mutate(MutationOptions(
      document: gql(createSocialClubStr),
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
    if(result!.isConcrete){
      if(result.data['socialClub'] == null ){
        print('data null');
        return null;
      }
      final cclub = SocialClub.fromMap(result.data['socialClub']);
      return cclub;
    }else{
      print('Result not concrete');
      return null;
    }
    }catch(e){
      print(e);
      return null;
    }
  }

  static const String createOpenClubStr = r'''

  # Welcome to Altair GraphQL Client.
  # You can send your request using CmdOrCtrl + Enter.

  # Enter your graphQL query here.
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
  @override
  Future<OpenClub?> createOpenClub(OpenClub club) async{
    try{
    final result = await graph?.mutate(MutationOptions(
      document: gql(createOpenClubStr),
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
    if(result!.isConcrete){
      if(result.data['openClub'] == null ){
        print('data null');
        return null;
      }
      final cclub = OpenClub.fromMap(result.data['socialClub']);
      return cclub;
    }else{
      print('Result not concrete');
      return null;
    }
    }catch(e){
      print(e);
      return null;
    }
  }

  static const String deleteClubStr = r'''
mutation UpdateClub{
  deleteClub(filter: {
    id: ["id"]
  }){
    msg
  }
}
  ''';

  @override
  Future<bool> deleteClub(String id) async{
    try{
      final result = await graph?.mutate(MutationOptions(
        document: gql(deleteClubStr),
        variables: {
          'id':id
        }
      ));
      if(result == null){
        return false;
      }else{
      if(result.isConcrete){
        if(result.data['deleteClub'] == null) return false;
        if(result.data['deleteClub']['msg'] == null) return false;
        return result.data['deleteClub']['msg'] == 'Deleted';
      }else{
        return false;
      }
      }
    }catch(e){
      print(e);
      return false;
    }
    }
    static const String invitePeopleStr = r'''
mutation InvitePeoples($clubId: ID!,$peoples: [String!]!){
  updateClosedClub(input:{
    filter: {
      id: [$clubId]
    },
    set:{
      invitedPeoples: $peoples
    }
  }){
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
      invitedPeoples
    }
  }
}
    ''';
    @override
    Future<ClosedClub?> invitePeople(String clubId,List<String> peoples) async{
      try{
        final result = await graph?.mutate(MutationOptions(
          document: gql(invitePeopleStr),
          variables: {
            'clubId': clubId,
            'peoples': peoples
          }
        ));
        if(result == null){
          throw Exception('Result null');
        }
        if(result.isConcrete){
          if( result.data['updateClosedClub'] == null || result.data['updateClosedClub']['closedClub'] == null ||  result.data['updateClosedClub']['closedClub'][0] == null){
            throw Exception('Result data null');
          }
          final json = result.data['updateClosedClub']['closedClub'][0];
          final ClosedClub club = ClosedClub.fromMap(json);
          return club;
        }else{
          throw Exception('Result not concrete');
        }
      }catch(e){
        print(e);
        return null;
      }
    }
    static const String updateClubStr = r'''

mutation UpdateClub($clubId: ID!, $moderators: [UserRef!], $title: String, $desc: String, $avatarUrl: String, $tags: [String!]){
  updateClub(input: {
    filter:{
      id: [$clubId]
    },
    set:{
      moderators: $moderators,
      title: $title,
      description: $desc,
      avatarUrl: $avatarUrl,
      tags: $tags
    }
  }){
    club{
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
    @override
    Future<OpenClub?> updateClub(OpenClub club) async{
    try{
        final result = await graph?.mutate(MutationOptions(
          document: gql(updateClubStr),
          variables: {
            'clubId': club.id,
            'moderators': club.moderators,
            'title': club.title,
            'desc':club.description,
            'avatarUrl': club.avatarUrl,
            'tags': club.tags
          }
        ));
        if(result == null){
          throw Exception('Result null');
        }
        if(result.isConcrete){
          if( result.data['updateClub'] == null || result.data['updateClub']['club'] == null ||  result.data['updateClub']['club'][0] == null){
            throw Exception('Result data null');
          }
          final json = result.data['updateClub']['club'][0];
          final OpenClub club = OpenClub.fromMap(json);
          return club;
        }else{
          throw Exception('Result not concrete');
        }
      }catch(e){
        print(e);
        return null;
      }
  }
  static const String createUserStr = r'''
mutation AddUser($fid: String!, $name: String!, $bio: String, $socials: [String!], $createdAt: DateTime!, $link: String!, $tags: [String!]!){
  addUser(input: {
    fid: $fid,
    name: $name,
    bio: $bio,
    socials: $socials,
    createdAt: $createdAt,
    lastLogin: $createdAt,
    link: $link,
    tags: $tags
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
      adminOf{
        id
        title
      }
    }
  }
}
  ''';
  @override
  Future<User?> createUser(User nuser) async{
      try{
        final result = await graph?.mutate(MutationOptions(
          document: gql(createUserStr),
          variables: {
            'fid': uid,
            'name': nuser.name,
            'bio': nuser.bio,
            'socials': nuser.socials,
            'createdAt': DateTime.now().toIso8601String(),
            'link': nuser.link,
            'tags': nuser.tags
          }
        ));
        if(result == null){
          throw Exception('Result null');
        }
        if(result.isConcrete){
          if( result.data['addUser'] == null || result.data['addUser']['user'] == null ||  result.data['addUser']['user'][0] == null){
            throw Exception('Result data null');
          }
          final json = result.data['addUser']['user'][0];
          final User user = User.fromMap(json);
          return user;
        }else{
          throw Exception('Result not concrete');
        }
      }catch(e){
        print(e);
        return null;
      }
    }
    static const String findByTitleStr = r'''
query FindByTitle($title: String!){
  queryOpenClub(filter: {
    title: {anyoftext: $title}
  }){
    id
    owner{
      fid
      name
      avatarUrl
    }
   	description
    title
    avatarUrl
    tags
    
  }
}
    ''';
    @override
    Future<List<OpenClub>?> findByTitle(String title) async{
    try{
        final result = await graph?.mutate(MutationOptions(
          document: gql(findByTitleStr),
          variables: {
            'title': title,
            
          }
        ));
        if(result == null){
          throw Exception('Result null');
        }
        if(result.isConcrete){
          if( result.data['queryOpenClub'] == null){
            throw Exception('Result data null');
          }
          final list = result.data['queryOpenClub'] as List;
          List<OpenClub> clubs = [];
          for (var json in list) {
            final OpenClub openClub = OpenClub.fromMap(json);
            clubs.add(openClub);
          }
          return clubs;
        }else{
          throw Exception('Result not concrete');
        }
      }catch(e){
        print(e);
        return null;
      }
  }

  @override
  Future<List<SocialClub>?> socialClubs() {
    // TODO: implement socialClubs
    throw UnimplementedError();
  }
}
