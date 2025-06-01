import 'package:freezed_annotation/freezed_annotation.dart';

part 'qube_details_form.freezed.dart';

@freezed
sealed class QubeDetailsForm with _$QubeDetailsForm {
  const factory QubeDetailsForm.name(String name) = Name;
  const factory QubeDetailsForm.email(String email) = Email;
  const factory QubeDetailsForm.phone(String phone) = Phone;
}
