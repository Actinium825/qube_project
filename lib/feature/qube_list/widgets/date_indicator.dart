import 'package:flutter/material.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/styles.dart';
import 'package:qube_project/widgets/custom_divider.dart';
import 'package:qube_project/widgets/spacings.dart';

class DateIndicator extends StatelessWidget {
  const DateIndicator({
    required this.date,
    super.key,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    const horizontalSpace = HorizontalSpace(space: 12.0);
    return Row(
      children: [
        const CustomDivider(),
        horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: qubeCardBackgroundColor,
            borderRadius: BorderRadius.circular(qubeCardButtonRadius),
          ),
          padding: dateIndicatorPadding,
          child: Text(
            date,
            style: TextStyles.medium.copyWith(fontSize: 10.0),
          ),
        ),
        horizontalSpace,
        const CustomDivider(),
      ],
    );
  }
}
