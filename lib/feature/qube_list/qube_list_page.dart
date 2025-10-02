import 'package:flutter/material.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/feature/qube_list/step_2/step_2_tab_connector.dart';
import 'package:qube_project/feature/qube_list/widgets/loading_list.dart';
import 'package:qube_project/feature/qube_list/widgets/qube_list.dart';
import 'package:qube_project/feature/qube_list/widgets/qube_list_tab.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/widgets/spacings.dart';

class QubeListPage extends StatefulWidget {
  const QubeListPage({
    required this.onSelectQube,
    required this.isPosting,
    required this.isGettingList,
    super.key,
  });

  final ValueChanged<QubeItem> onSelectQube;
  final bool isPosting;
  final bool isGettingList;

  @override
  State<QubeListPage> createState() => _QubeListPageState();
}

class _QubeListPageState extends State<QubeListPage> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: tabBarCount, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Switch to Step 2 Tab after pressing 'Go To Step 2' on a qube item
  /// Sets the provided [qubeItem] as the selected to show in Step 2
  void _onSelectQube(QubeItem qubeItem) {
    _tabController.animateTo(1);
    widget.onSelectQube(qubeItem);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          QubeListTab(
            tabController: _tabController,
            isPosting: widget.isPosting,
            isGettingList: widget.isGettingList,
          ),
          const VerticalSpace(space: 32.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (widget.isGettingList) const LoadingList() else QubeList(onSelectQube: _onSelectQube),
                const Step2TabConnector(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
