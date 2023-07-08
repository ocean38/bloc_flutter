import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/base_bloc/bloc_builder.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';
import 'package:impacteer/controllers/get_user_list/user_controller.dart';
import 'package:impacteer/controllers/get_user_list/user_events.dart';
import 'package:impacteer/models/user_model.dart';
import 'package:impacteer/ui/widgets/loading_view.dart';
import 'package:impacteer/ui/widgets/user_tile.dart';
import 'package:impacteer/utils/app_colors.dart';
import 'package:impacteer/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserController>().add(GetUserListEvent());

    /// for pagination
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.maxScrollExtent == _scrollCtrl.position.pixels) {
        context
            .read<UserController>()
            .add(GetUserListEvent(isPaginationCalled: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<UserController>(
      defaultView: _getBody,
      onSuccess: (BlocEventState eventState) {
        final event = eventState.event as GetUserListEvent;
        if (!event.isPaginationCalled) {
          userModel = UserModel.fromJson(eventState.response?.data);
          UserController.totalPaginationCount = userModel?.totalPages ?? 1;
        } else if (event.isPaginationCalled) {
          userModel?.users?.addAll(
            UserModel.fromJson(eventState.response?.data).users ?? [],
          );
        }
      },
    );
  }

  Widget _getBody(BlocEventState eventState) {
    if (eventState.state == BlocState.loading &&
        eventState.event is GetUserListEvent &&
        (eventState.event as GetUserListEvent).isPaginationCalled) {
      _scrollDown;
      return Container(
        color: AppColors.themeColor,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 66,
              child: _child(
                eventState,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
            ),
            const SizedBox(height: 8),
            const CupertinoActivityIndicator(color: AppColors.white),
            const SizedBox(height: 16),
          ],
        ),
      );
    }
    return _child(eventState);
  }

  Widget _child(BlocEventState eventState, {ScrollPhysics? scrollPhysics}) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.users),
            backgroundColor: AppColors.themeColor,
          ),
          backgroundColor: AppColors.themeColor,
          body: ListView.builder(
            controller: _scrollCtrl,
            physics: scrollPhysics ??
                const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
            itemCount: userModel?.users?.length ?? 0,
            itemBuilder: (context, i) => UserTile(user: userModel?.users?[i]),
          ),
        ),

        //// Loading view without pagination
        if (eventState.state == BlocState.loading) ...[
          if (eventState.event is GetUserListEvent &&
              !(eventState.event as GetUserListEvent).isPaginationCalled)
            const LoadingView(),
        ],
      ],
    );
  }

  void get _scrollDown {
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent,
      duration: const Duration(microseconds: 1),
      curve: Curves.linear,
    );
  }
}
