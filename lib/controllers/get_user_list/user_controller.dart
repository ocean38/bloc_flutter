import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/base_bloc/bloc_event.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';
import 'package:impacteer/controllers/get_user_list/user_events.dart';

import 'package:impacteer/services/api_keys.dart';
import 'package:impacteer/services/api_service.dart';

class UserController extends Bloc<BlocEvent, BlocEventState> {
  UserController()
      : super(BlocEventState(
          state: BlocState.none,
          event: InitialEvent(),
          response: null,
        )) {
    on<GetUserListEvent>(getUsers);
  }
  final _apiServices = ApiServices();

  /// for pagination
  static int page = 1;
  static int totalPaginationCount = 1;

  /// get user list
  Future getUsers(GetUserListEvent event, Emitter<BlocEventState> emit) async {
    /// to avoid extra pagination
    if ((page >= totalPaginationCount) && event.isPaginationCalled) return;

    emit(BlocEventState(state: BlocState.loading, event: event));

    if (event.isPaginationCalled) ++page;

    final response = await _apiServices.apiRequest(
      ApiRequestType.apiGet,
      event,
      ApiEndPoints.getUser(page),
    );

    emit(
      BlocEventState(state: response.state, event: event, response: response),
    );
  }
}
