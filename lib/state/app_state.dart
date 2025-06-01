import 'package:async_redux/async_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/models/qube_details.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(Wait.empty) @JsonKey(includeFromJson: false, includeToJson: false) Wait wait,
    @Default(null) bool? isSuccessful,
    @Default(null) QubeItem? selectedQube,
    @Default(null) QubeDetails? qubeDetails,
  }) = _AppState;
}
