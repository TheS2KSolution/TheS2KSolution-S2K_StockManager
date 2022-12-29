// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ride _$RideFromJson(Map<String, dynamic> json) => Ride(
      json['id'] as int,
      (json['price'] as num).toDouble(),
      Address.fromJson(json['departure'] as Map<String, dynamic>),
      Address.fromJson(json['arrival'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RideToJson(Ride instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'departure': instance.departure,
      'arrival': instance.arrival,
    };
