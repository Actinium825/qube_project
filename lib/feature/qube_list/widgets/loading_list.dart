import 'package:flutter/material.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/strings.dart';
import 'package:qube_project/widgets/custom_divider.dart';
import 'package:qube_project/widgets/custom_elavated_button.dart';
import 'package:qube_project/widgets/loading_shimmer.dart';
import 'package:qube_project/widgets/spacings.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalSpace = HorizontalSpace(space: 12.0);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: const Shimmer(
        gradient: loadingGradient,
        child: FloatingActionButton(
          onPressed: null,
          elevation: 0,
          shape: CircleBorder(),
        ),
      ),
      body: ListView(
        children: [
          const Row(
            children: [
              CustomDivider(),
              horizontalSpace,
              LoadingShimmer(
                width: 84,
                radius: 100,
              ),
              horizontalSpace,
              CustomDivider(),
            ],
          ),
          const VerticalSpace(space: 16.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            shrinkWrap: true,
            separatorBuilder: (_, _) => const VerticalSpace(space: 20.0),
            itemBuilder: (_, itemIndex) {
              const verticalSpace = VerticalSpace(space: 4.0);
              return Container(
                padding: qubeCardPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(qubeCardRadius),
                  color: qubeCardBackgroundColor,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadingShimmer(
                      width: 45,
                      height: 16,
                    ),
                    verticalSpace,
                    LoadingShimmer(width: 100),
                    verticalSpace,
                    LoadingShimmer(
                      width: 230,
                      height: 17,
                    ),
                    VerticalSpace(space: 20.0),
                    CustomElevatedButton(label: collectButtonLabel),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
