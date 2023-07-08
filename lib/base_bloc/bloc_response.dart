import 'package:impacteer/base_bloc/bloc_event.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';

class BlocResponse<T> {
  final BlocState? state;
  final BlocEvent? event;
  final T? data;
  final T? dataNew;
  final String? message;
  final int? statusCode;
  final Type? exceptionType;

  BlocState? prevState;
  BlocEvent? prevEvent;

  BlocResponse({
    this.state,
    this.event,
    this.data,
    this.dataNew,
    this.message,
    this.statusCode,
    this.exceptionType,
    this.prevState,
    this.prevEvent,
  });
}
