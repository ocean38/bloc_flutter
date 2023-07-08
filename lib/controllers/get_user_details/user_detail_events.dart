import 'package:impacteer/base_bloc/bloc_event.dart';

abstract class UsersDetailEvent implements BlocEvent {
  const UsersDetailEvent();
}

class InitialEvent extends UsersDetailEvent {}

class GetUserDetails extends UsersDetailEvent {
  int userId;
  GetUserDetails({required this.userId});
}
