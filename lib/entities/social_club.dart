import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'user.dart';

part 'social_club.g.dart';

@HiveType(typeId: 102)
class SocialClub extends Equatable {
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
  final String? avatarUrl;

  SocialClub(this.owner, this.moderators, this.members, this.title, this.description, this.tags, this.avatarUrl);
  factory SocialClub.createSocialClub({required String title , required String description , required List<String> tags , List<String> moderators = const [], String? avatarUrl}){
    return SocialClub(GetIt.I.get<User>(), [], [], title, description, tags, avatarUrl);
  }

  @override
  List<Object> get props => [owner, moderators, members, title, description, tags];

  SocialClub copyWith({
    User? owner,
    List<String>? moderators,
    List<String>? members,
    String? title,
    String? description,
    List<String>? tags,
    String? avatarUrl,
  }) {
    return SocialClub(
      owner ?? this.owner,
      moderators ?? this.moderators,
      members ?? this.members,
      title ?? this.title,
      description ?? this.description,
      tags ?? this.tags,
      avatarUrl ?? this.avatarUrl
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'moderators': moderators.map((x) => x).toList(),
      'members': members.map((x) => x).toList(),
      'title': title,
      'description': description,
      'tags': tags,
      'avatarUrl': avatarUrl
    };
  }

  factory SocialClub.fromMap(Map<String, dynamic> map) {
  
    return SocialClub(
     User.fromMap(map['owner']),
      map['moderators'] == null? []:List<String>.from(map['moderators'].map((x) => x)),
      map['members'] == null? []:List<String>.from(map['members'].map((x) => x)),
      map['title'],
      map['description'],
      map['tags'] == null? []:List<String>.from(map['tags']),
      map['avatarUrl']
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialClub.fromJson(String source) => SocialClub.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
