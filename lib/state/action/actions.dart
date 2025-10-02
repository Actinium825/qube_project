import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:dartx/dartx.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qube_project/database/database.dart';
import 'package:qube_project/models/qube_details.dart';
import 'package:qube_project/state/app_state.dart';

/// Reusable loading page state for actions
abstract class LoadingAction extends ReduxAction<AppState> {
  LoadingAction({required this.actionKey});

  final String actionKey;

  @override
  void before() => dispatch(WaitAction.add(actionKey));

  @override
  void after() => dispatch(WaitAction.remove(actionKey));
}

/// Deliver the qube
/// Set the state's is successful if email is valid
class DeliverAction extends LoadingAction {
  DeliverAction() : super(actionKey: waitKey);

  static const waitKey = 'deliver-action';

  @override
  Future<AppState> reduce() async {
    // Mock a delay
    await Future<void>.delayed(3.seconds);
    final isEmailValid = EmailValidator.validate(state.qubeDetails?.email ?? '');
    return state.copyWith(isSuccessful: isEmailValid);
  }
}

/// Reset the details, selected qube, and is successful event on Step 2
/// Gets called after leaving Step 2 Tab
class ResetDetailsAction extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(
        isSuccessful: null,
        selectedQube: null,
        qubeDetails: null,
      );
}

/// Selects a qube to be shown in Step 2
/// Gets called when pressing go to step 2 in a qube card
class SelectQubeAction extends ReduxAction<AppState> {
  SelectQubeAction({required this.selectedQube});

  final QubeItem? selectedQube;

  @override
  AppState reduce() => state.copyWith(selectedQube: selectedQube);
}

/// Update the qube details in step 2 card
/// Gets called when updating either email, phone, or name in the step 2 card
class UpdateQubeDetailsAction extends ReduxAction<AppState> {
  UpdateQubeDetailsAction({required this.updatedQubeDetails});

  final QubeDetails? updatedQubeDetails;

  @override
  AppState reduce() => state.copyWith(qubeDetails: updatedQubeDetails);
}

/// Gets the initial list of qube at app start
/// Gets called on [HomeConnector]
class GetInitialListAction extends LoadingAction {
  GetInitialListAction() : super(actionKey: waitKey);

  static const waitKey = 'get-initial-list';

  @override
  Future<AppState> reduce() async {
    // Mock a delay
    await Future<void>.delayed(3.seconds);
    return state;
  }
}
