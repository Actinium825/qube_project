import 'package:flutter/material.dart';
import 'package:qube_project/classes/gradient_border_side.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/styles.dart';
import 'package:qube_project/widgets/gradient_point.dart';

class DetailsField extends StatefulWidget {
  const DetailsField({
    required this.hintText,
    required this.textEditingController,
    this.isEnabled = true,
    this.keyboardType,
    super.key,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool isEnabled;
  final TextInputType? keyboardType;

  @override
  State<DetailsField> createState() => _DetailsFieldState();
}

class _DetailsFieldState extends State<DetailsField> {
  late final _isErrorNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _isErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(detailsCardRadius),
      borderSide: BorderSide(
        width: detailsCardBorderWidth,
        color: Colors.white.withValues(alpha: 0.3),
      ),
    );
    final errorBorder = border.copyWith(borderSide: errorFieldBorderSide);

    return SizedBox(
      height: detailsCardHeight,
      child: TextFormField(
        enabled: widget.isEnabled,
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        style: TextStyles.xxs,
        decoration: InputDecoration(
          enabledBorder: widget.textEditingController.text.isEmpty ? border : const GradientBorderSide(),
          focusedBorder: const GradientBorderSide(),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          disabledBorder: border,
          prefixIcon: ValueListenableBuilder<bool>(
            valueListenable: _isErrorNotifier,
            builder: (_, isError, _) => Container(
              margin: detailsCardPrefixMargin,
              foregroundDecoration: switch (isError) {
                true => const BoxDecoration(
                  color: errorFieldColor,
                  shape: BoxShape.circle,
                ),
                false => null,
              },
              child: const GradientPoint(),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.zero,
          hintStyle: TextStyles.xxs,
          errorStyle: const TextStyle(fontSize: 0),
        ),
        validator: (value) {
          _isErrorNotifier.value = value?.isEmpty == true;
          return _isErrorNotifier.value ? '' : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
