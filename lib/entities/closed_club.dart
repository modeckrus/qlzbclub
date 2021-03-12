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
  final List<String> moderators;
  @HiveField(2)
  final List<String> members;
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
  ClosedClub(this.owner, this.moderators, this.members, this.title, this.description, this.tags, this.invitedPeoples, this.avatarUrl);
  factory ClosedClub.createClosedClub({required String title, required String description, required List<String> tags, List<String>? invitedPeople = const [], List<String> moderators = const [], String? avatarUrl}){
    return ClosedClub(GetIt.I.get<User>(), moderators, [], title, description, tags, invitedPeople, avatarUrl);
  }

  @override
  List<Object> get props => [owner, moderators, members, title, description, tags];

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'moderators': moderators.map((x) => x).toList(),
      'members': members.map((x) => x).toList(),
      'title': title,
      'description': description,
      'tags': tags,
      'invitedPeoples': invitedPeoples?.map((x) => x).toList(),
    };
  }

  factory ClosedClub.fromMap(Map<String, dynamic> map) {
    return ClosedClub(
      User.fromMap(map['owner']),
      map['moderators'] == null? []:List<String>.from(map['moderators'].map((x) => x)),
      map['members'] == null? []:List<String>.from(map['members'].map((x) => x)),
      map['title'],
      map['description'],
      map['tags'] == null? []:List<String>.from(map['tags']),
      map['invitedPeoples'] == null? []:List<String>.from(map['invitedPeoples'].map((x) => x)),
      map['avatarUrl']
    );
  }

  String toJson() => json.encode(toMap());

  factory ClosedClub.fromJson(String source) => ClosedClub.fromMap(json.decode(source));

  ClosedClub copyWith({
    User? owner,
    List<String>? moderators,
    List<String>? members,
    String? title,
    String? description,
    List<String>? tags,
    List<String>? invitedPeoples,
    String? avatarUrl
  }) {
    return ClosedClub(
      owner ?? this.owner,
      moderators ?? this.moderators,
      members ?? this.members,
      title ?? this.title,
      description ?? this.description,
      tags ?? this.tags,
      invitedPeoples ?? this.invitedPeoples,
      avatarUrl ?? this.avatarUrl
    );
  }

  @override
  bool get stringify => true;
}
