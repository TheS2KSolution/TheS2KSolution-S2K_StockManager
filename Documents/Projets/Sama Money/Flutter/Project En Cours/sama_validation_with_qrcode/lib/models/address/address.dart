import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  int id;
  String name;
  String type;

  Address(
    this.id,
    this.name,
    this.type,
  );

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// Connect the generated [_$AddressToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
