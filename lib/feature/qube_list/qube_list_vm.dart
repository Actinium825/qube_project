import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/feature/qube_list/qube_list_connector.dart';
import 'package:qube_project/state/action/actions.dart';
import 'package:qube_project/state/app_state.dart';

class QubeListVmFactory extends VmFactory<AppState, QubeListConnector, QubeListVM> {
  @override
  QubeListVM fromStore() {
    final wait = state.wait;
    return QubeListVM(
      onSelectQube: _onSelectQube,
      isPosting: wait.isWaiting(DeliverAction.waitKey),
      isGettingList: wait.isWaiting(GetInitialListAction.waitKey),
    );
  }

  void _onSelectQube(QubeItem selectedQube) => dispatch(SelectQubeAction(selectedQube: selectedQube));
}

class QubeListVM extends Vm {
  final ValueChanged<QubeItem> onSelectQube;
  final bool isPosting;
  final bool isGettingList;

  QubeListVM({
    required this.onSelectQube,
    required this.isPosting,
    required this.isGettingList,
  }) : super(
         equals: [
           isPosting,
           isGettingList,
         ],
       );
}
