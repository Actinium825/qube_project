import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/strings.dart';
import 'package:qube_project/utils/styles.dart';
import 'package:qube_project/widgets/custom_elavated_button.dart';
import 'package:qube_project/widgets/gradient_point.dart';
import 'package:qube_project/widgets/spacings.dart';

class QubeCard extends StatelessWidget {
  const QubeCard({
    required this.qubeItem,
    required this.onPress,
    super.key,
  });

  final VoidCallback onPress;
  final QubeItem qubeItem;

  @override
  Widget build(BuildContext context) {
    const verticalSpace = VerticalSpace(space: 4.0);
    const horizontalSpace = HorizontalSpace(space: 8.0);

    return Container(
      padding: qubeCardPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(qubeCardRadius),
        color: qubeCardBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.jm().format(qubeItem.deliveryDate),
                style: TextStyles.xxs,
              ),
              if (qubeItem.deliveryDate.isBefore(DateTime.now()))
                CircleAvatar(
                  radius: overdueIndicatorOuterSize,
                  backgroundColor: overdueIndicatorColor.withValues(alpha: 0.2),
                  child: const CircleAvatar(
                    backgroundColor: overdueIndicatorColor,
                    radius: overdueIndicatorInnerSize,
                    child: Icon(
                      Icons.priority_high,
                      size: overdueIndicatorOuterSize,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          verticalSpace,
          Text(
            qubeItem.identification,
            style: TextStyles.base,
          ),
          verticalSpace,
          Row(
            children: [
              const GradientPoint(),
              const HorizontalSpace(space: 4.0),
              Text(
                qubeItem.location,
                style: TextStyles.xxs,
              ),
              horizontalSpace,
              const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
                size: qubeCardArrowSize,
              ),
              horizontalSpace,
              const GradientPoint(isFilled: false),
              const HorizontalSpace(space: 4.0),
              Text(
                qubeItem.receiver,
                style: TextStyles.xxs,
              ),
            ],
          ),
          const VerticalSpace(space: 20.0),
          CustomElevatedButton(
            label: qubeCardButtonLabel,
            onPress: onPress,
          ),
        ],
      ),
    );
  }
}
