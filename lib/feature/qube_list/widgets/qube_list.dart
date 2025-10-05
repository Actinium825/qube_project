import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/feature/qube_list/widgets/date_indicator.dart';
import 'package:qube_project/feature/qube_list/widgets/qube_card.dart';
import 'package:qube_project/main.dart';
import 'package:qube_project/utils/strings.dart';
import 'package:qube_project/widgets/spacings.dart';

class QubeList extends StatelessWidget {
  const QubeList({
    required this.onSelectQube,
    super.key,
  });

  final ValueChanged<QubeItem> onSelectQube;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QubeItem>>(
      stream: appDatabase.allIQubeItems(),
      builder: (_, snapshot) {
        final allQubeItems = [...?snapshot.data];
        final groupedQubeItems = allQubeItems.groupBy((qubeItem) => DateUtils.dateOnly(qubeItem.deliveryDate)).toList();

        return ListView.separated(
          itemCount: groupedQubeItems.length,
          separatorBuilder: (_, _) => const VerticalSpace(space: 32.0),
          itemBuilder: (_, groupIndex) {
            final qubeItemEntry = groupedQubeItems[groupIndex];
            final qubeItems = qubeItemEntry.second;

            return Column(
              children: [
                DateIndicator(date: DateFormat(dateIndicatorFormat).format(qubeItemEntry.first)),
                const VerticalSpace(space: 16.0),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: qubeItems.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, _) => const VerticalSpace(space: 20.0),
                  itemBuilder: (_, itemIndex) {
                    final qubeItem = qubeItems[itemIndex];
                    return QubeCard(
                      qubeItem: qubeItem,
                      onPress: () => onSelectQube(qubeItem),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
