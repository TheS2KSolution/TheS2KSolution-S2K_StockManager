// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      json['id'] as int,
      (json['price'] as num).toDouble(),
      Client.fromJson(json['client'] as Map<String, dynamic>),
      Ride.fromJson(json['ride'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'client': instance.client,
      'ride': instance.ride,
    };
