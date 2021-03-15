import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(2)
  final String? photoUrl;
  @HiveField(3)
  final DateTime? createdAt;
  @HiveField(4)
  final DateTime? lastLogin;
  @HiveField(5)
  final String? status;
  @HiveField(6)
  final String? bio;
  @HiveField(7)
  final String fid;
  @HiveField(8)
  final List<String>? tags;
  @HiveField(9)
  final List<String>? socials;
  @HiveField(10)
  final String? link;
  @HiveField(11)
  final List<String>? subs;
  @HiveField(12)
  final List<String>? followers;
  @HiveField(13)
  final String id;
  User({
    required this.name,
    this.photoUrl,
    this.createdAt,
    this.lastLogin,
    this.status,
    this.bio,
    required this.fid,
    this.tags,
    this.socials,
    this.link,
    this.subs,
    this.followers,
    required this.id,
  });
  const User.cnst({
    required this.name,
    this.photoUrl,
    this.createdAt,
    this.lastLogin,
    this.status,
    this.bio,
    required this.fid,
    this.tags,
    this.socials,
    this.link,
    this.subs,
    this.followers,
    required this.id,
  });

  @override
  List<Object> get props => [fid];
  

  User copyWith({
    String? name,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLogin,
    String? status,
    String? bio,
    String? fid,
    List<String>? tags,
    List<String>? socials,
    String? link,
    List<String>? subs,
    List<String>? followers,
    String? id,
  }) {
    return User(
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      status: status ?? this.status,
      bio: bio ?? this.bio,
      fid: fid ?? this.fid,
      tags: tags ?? this.tags,
      socials: socials ?? this.socials,
      link: link ?? this.link,
      subs: subs ?? this.subs,
      followers: followers ?? this.followers,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'status': status,
      'bio': bio,
      'fid': fid,
      'tags': tags?.map((x) => x).toList(),
      'socials': socials?.map((x) => x).toList(),
      'link': link,
      'subs': subs?.map((x) => x).toList(),
      'followers': followers?.map((x) => x).toList(),
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      photoUrl: map['photoUrl'],
      createdAt: DateTime.tryParse(map['createdAt']??'2002-02-27T19:00:00Z'),
      lastLogin: DateTime.tryParse(map['lastLogin']??'2002-02-27T19:00:00Z'),
      status: map['status'],
      bio: map['bio'],
      fid: map['fid'],
      tags: map['tags'] == null? []: List<String>.from(map['tags']?.map((x) => x)),
      socials: map['socials'] == null? [] : List<String>.from(map['socials']?.map((x) => x)),
      link: map['link'],
      subs: map['subs'] == null? []:List<String>.from(map['subs']?.map((x) => x)),
      followers:map['followers'] == null? []: List<String>.from(map['followers']?.map((x) => x)),
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
