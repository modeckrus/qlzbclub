import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'user.dart';

part 'closed_club.g.dart';

@HiveType(typeId: 103)
class ClosedClub extends Equatable {
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
  final List<String>? invitedPeoples; 
  @HiveField(7)
  final String? avatarUrl;
  @HiveField(8)
  final String? id;
  ClosedClub(this.owner, this.moderators, this.members, this.title, this.description, this.tags, this.invitedPeoples, this.avatarUrl, this.id);
  factory ClosedClub.createClosedClub({required String title, required String description, required List<String> tags, List<String>? invitedPeople = const [], List<String> moderators = const [], String? avatarUrl, String? id}){
    return ClosedClub(GetIt.I.get<User>(), [], [], title, description, tags, invitedPeople, avatarUrl, id);
  }

  @override
  List<Object> get props => [owner, moderators, members, title, description, tags];

  

  ClosedClub copyWith({
    User? owner,
    List<User>? moderators,
    List<User>? members,
    String? title,
    String? description,
    List<String>? tags,
    List<String>? invitedPeoples,
    String? avatarUrl,
  }) {
    return ClosedClub(
      owner ?? this.owner,
      moderators ?? this.moderators,
      members ?? this.members,
      title ?? this.title,
      description ?? this.description,
      tags ?? this.tags,
      invitedPeoples ?? this.invitedPeoples,
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
      'invitedPeoples': invitedPeoples,
      'avatarUrl': avatarUrl,
      'id':id
    };
  }

  factory ClosedClub.fromMap(Map<String, dynamic> map) {
    return ClosedClub(
      User.fromMap(map['owner']),
      map['moderators'] == null ? [] : List<User>.from(map['moderators']?.map((x) => User.fromMap(x))),
      map['members'] == null ? [] : List<User>.from(map['members']?.map((x) => User.fromMap(x))),
      map['title'],
      map['description'],
      map['tags'] == null ? [] :List<String>.from(map['tags']),
      map['invitedPeoples'] == null ? []: List<String>.from(map['invitedPeoples']),
      map['avatarUrl'],
      map['id']
    );
  }

  String toJson() => json.encode(toMap());

  factory ClosedClub.fromJson(String source) => ClosedClub.fromMap(json.decode(source));
}
