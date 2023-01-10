// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      json['id'] as int,
       json['immatriculation'] as String,
  json['nbrSeat'] as int,

    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'immatriculation': instance.immatriculation,
      'nbrSeat': instance.nbrSeat,

    };
