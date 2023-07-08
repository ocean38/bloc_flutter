import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/base_bloc/bloc_event.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';
import 'package:impacteer/controllers/get_user_details/user_detail_events.dart';

import 'package:impacteer/services/api_keys.dart';
import 'package:impacteer/services/api_service.dart';

class UserDetailController extends Bloc<BlocEvent, BlocEventState> {
  UserDetailController()
      : super(BlocEventState(
          state: BlocState.none,
          event: InitialEvent(),
          response: null,
        )) {
    on<GetUserDetails>(getDetails);
  }
  final _apiServices = ApiServices();

  /// get user details
  Future getDetails(GetUserDetails event, Emitter<BlocEventState> emit) async {
    emit(BlocEventState(state: BlocState.loading, event: event));

    final response = await _apiServices.apiRequest(
      ApiRequestType.apiGet,
      event,
      ApiEndPoints.getUsetList(event.userId),
    );

    emit(
      BlocEventState(state: response.state, event: event, response: response),
    );
  }
}
