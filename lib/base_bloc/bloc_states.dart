import 'package:impacteer/base_bloc/bloc_event.dart';
import 'package:impacteer/base_bloc/bloc_response.dart';

/// Application states
enum BlocState { none, loading, noInternet, success, failed }

class BlocEventState {
  BlocState? state;
  BlocEvent? event;
  BlocResponse? response;

  BlocEventState({
    this.state = BlocState.none,
    this.response,
    this.event,
  });
}

/// ApiRequest Type
enum ApiRequestType { apiGet, apiPost, apiPut, apiPatch, apiDelete }

/// ApiContent Type
enum ApiContentType { json, formData }
