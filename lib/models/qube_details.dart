import 'package:freezed_annotation/freezed_annotation.dart';

part 'qube_details.freezed.dart';

@freezed
abstract class QubeDetails with _$QubeDetails {
  const factory QubeDetails({
    @Default('') String name,
    @Default('') String email,
    @Default('') String phone,
  }) = _QubeDetails;
}
