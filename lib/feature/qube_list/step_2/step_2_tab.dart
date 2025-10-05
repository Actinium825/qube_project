import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/feature/qube_list/step_2/widgets/details_field.dart';
import 'package:qube_project/feature/qube_list/widgets/date_indicator.dart';
import 'package:qube_project/models/qube_details.dart';
import 'package:qube_project/models/qube_details_form.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/strings.dart';
import 'package:qube_project/utils/styles.dart';
import 'package:qube_project/widgets/custom_elavated_button.dart';
import 'package:qube_project/widgets/spacings.dart';

class Step2Tab extends StatefulWidget {
  const Step2Tab({
    required this.isLoading,
    required this.onDeliver,
    required this.onUpdateForm,
    required this.qubeDetails,
    this.isSuccessful,
    this.selectedQube,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onDeliver;
  final ValueChanged<QubeDetailsForm> onUpdateForm;
  final QubeDetails qubeDetails;
  final bool? isSuccessful;
  final QubeItem? selectedQube;

  @override
  State<Step2Tab> createState() => _Step2TabState();
}

class _Step2TabState extends State<Step2Tab> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameTextController = TextEditingController();
  late final _emailTextController = TextEditingController();
  late final _phoneTextController = TextEditingController();
  late String _emailHintText = _emailHintText;

  @override
  void initState() {
    _nameTextController.addListener(() => widget.onUpdateForm(QubeDetailsForm.name(_nameTextController.text)));
    _emailTextController.addListener(() => widget.onUpdateForm(QubeDetailsForm.email(_emailTextController.text)));
    _phoneTextController.addListener(() => widget.onUpdateForm(QubeDetailsForm.phone(_phoneTextController.text)));
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.isSuccessful != widget.isSuccessful && widget.isSuccessful == false) _onInvalidEmailFormat();
    super.didUpdateWidget(oldWidget);
  }

  /// Shows an invalid email hint text in the email text field if the format is wrong upon delivering
  /// Resets the email text field value
  void _onInvalidEmailFormat() {
    _emailTextController.clear();
    _emailHintText = invalidEmailHintText;
  }

  /// Delivers the qube with the provided details
  /// Unfocuses the text field
  void _onPressDeliver() {
    FocusScope.of(context).unfocus();
    widget.onDeliver();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryDate = widget.selectedQube?.deliveryDate ?? DateTime.now();
    final isDeliverSuccessful = widget.isSuccessful == true;
    final areDetailsFilled =
        widget.qubeDetails.name.isNotEmpty &&
        widget.qubeDetails.email.isNotEmpty &&
        widget.qubeDetails.phone.isNotEmpty;
    final isTextFieldEnabled = !widget.isLoading && !isDeliverSuccessful;
    const largeVerticalSpace = VerticalSpace(space: 16.0);
    const mediumVerticalSpace = VerticalSpace(space: 12.0);

    return Column(
      children: [
        DateIndicator(date: DateFormat(dateIndicatorFormat).format(deliveryDate)),
        largeVerticalSpace,
        Container(
          padding: qubeCardPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(qubeCardRadius),
            color: qubeCardBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.jm().format(deliveryDate),
                style: TextStyles.xxs,
              ),
              const VerticalSpace(space: 4.0),
              Text(
                enterDetailsHeader,
                style: TextStyles.base,
              ),
              largeVerticalSpace,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DetailsField(
                      hintText: nameHintText,
                      textEditingController: _nameTextController,
                      isEnabled: isTextFieldEnabled,
                    ),
                    mediumVerticalSpace,
                    DetailsField(
                      hintText: _emailHintText,
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: _emailTextController,
                      isEnabled: isTextFieldEnabled,
                    ),
                    mediumVerticalSpace,
                    DetailsField(
                      hintText: phoneNumberHintText,
                      keyboardType: TextInputType.phone,
                      textEditingController: _phoneTextController,
                      isEnabled: isTextFieldEnabled,
                    ),
                  ],
                ),
              ),
              largeVerticalSpace,
              AbsorbPointer(
                absorbing: isDeliverSuccessful,
                child: CustomElevatedButton(
                  label: isDeliverSuccessful
                      ? postedLabel
                      : widget.isLoading
                      ? postingLabel
                      : deliverButtonLabel,
                  onPress: widget.isLoading || !areDetailsFilled ? null : _onPressDeliver,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
