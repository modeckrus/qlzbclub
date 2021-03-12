// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      photoUrl: fields[2] as String,
      createdAt: fields[3] as DateTime,
      lastLogin: fields[4] as DateTime,
      status: fields[5] as String,
      bio: fields[6] as String,
      fid: fields[7] as String,
      tags: (fields[8] as List).cast<String>(),
      socials: (fields[9] as List).cast<String>(),
      link: fields[10] as String,
      subs: (fields[11] as List).cast<String>(),
      followers: (fields[12] as List).cast<String>(),
      id: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.lastLogin)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.fid)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.socials)
      ..writeByte(10)
      ..write(obj.link)
      ..writeByte(11)
      ..write(obj.subs)
      ..writeByte(12)
      ..write(obj.followers)
      ..writeByte(13)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
