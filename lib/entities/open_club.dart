import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'user.dart';

part 'open_club.g.dart';

@HiveType(typeId: 101)
class OpenClub extends Equatable {
  @HiveField(0)
  final User owner;
  @HiveField(1)
  final List<User> moderators;
  @HiveField(2)
  final List<User> members;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final List<String> tags;
  @HiveField(6)
  final String? avatarUrl;
  @HiveField(7)
  final String? id;
  OpenClub(this.owner, this.moderators, this.members, this.title, this.description, this.tags, this.avatarUrl ,this.id);
  factory OpenClub.createOpenClub({required String title, required String description , required List<String> tags , List<String>? moderators, String? avatarUrl, String? id}){
    return OpenClub(GetIt.I.get<User>(), [], [], title, description, tags, avatarUrl, id);
  }

  @override
  List<Object> get props => [owner, moderators, members, title, description, tags];



  OpenClub copyWith({
    User? owner,
    List<User>? moderators,
    List<User>? members,
    String? title,
    String? description,
    List<String>? tags,
    String? avatarUrl,
    String? id,
  }) {
    return OpenClub(
      owner ?? this.owner,
      moderators ?? this.moderators,
      members ?? this.members,
      title ?? this.title,
      description ?? this.description,
      tags ?? this.tags,
      avatarUrl ?? this.avatarUrl,
      id ?? this.id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'moderators': moderators?.map((x) => x.toMap())?.toList(),
      'members': members?.map((x) => x.toMap())?.toList(),
      'title': title,
      'description': description,
      'tags': tags,
      'avatarUrl': avatarUrl,
      'id':id
    };
  }

  factory OpenClub.fromMap(Map<String, dynamic> map) {
    return OpenClub(
      User.fromMap(map['owner']),
      map['moderators'] == null ? [] : List<User>.from(map['moderators']?.map((x) => User.fromMap(x))),
      map['members'] == null ? [] : List<User>.from(map['members']?.map((x) => User.fromMap(x))),
      map['title'],
      map['description'],
      map['tags'] == null ? [] :List<String>.from(map['tags']),
      map['avatarUrl'],
      map['id']
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenClub.fromJson(String source) => OpenClub.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
