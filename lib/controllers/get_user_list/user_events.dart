import 'package:impacteer/base_bloc/bloc_event.dart';

abstract class UsersEvent implements BlocEvent {
  const UsersEvent();
}

class InitialEvent extends UsersEvent {}

class GetUserListEvent extends UsersEvent {
  bool isPaginationCalled;
  GetUserListEvent({this.isPaginationCalled = false});
}
