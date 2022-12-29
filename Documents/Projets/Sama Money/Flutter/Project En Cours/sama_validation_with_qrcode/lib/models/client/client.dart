import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  int id;

  Client(
    this.id,
  );

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  /// Connect the generated [_$ClientToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
