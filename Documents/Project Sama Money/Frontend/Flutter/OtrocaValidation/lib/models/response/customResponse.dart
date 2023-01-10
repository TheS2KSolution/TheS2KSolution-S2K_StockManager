import 'package:json_annotation/json_annotation.dart';

part 'customResponse.g.dart';

@JsonSerializable()
class CustomResponse {
  Object object;

  CustomResponse(
    this.object,
  );

  factory CustomResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomResponseFromJson(json);

  /// Connect the generated [_$CustomResponseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CustomResponseToJson(this);
}
