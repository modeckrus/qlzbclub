// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closed_club.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClosedClubAdapter extends TypeAdapter<ClosedClub> {
  @override
  final int typeId = 103;

  @override
  ClosedClub read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClosedClub(
      fields[0] as User,
      (fields[1] as List).cast<String>(),
      (fields[2] as List).cast<String>(),
      fields[3] as String,
      fields[4] as String,
      (fields[5] as List).cast<String>(),
      (fields[6] as List).cast<String>(),
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClosedClub obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.owner)
      ..writeByte(1)
      ..write(obj.moderators)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.invitedPeoples)
      ..writeByte(7)
      ..write(obj.avatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosedClubAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
