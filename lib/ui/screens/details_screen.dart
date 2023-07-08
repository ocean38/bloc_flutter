import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/base_bloc/bloc_builder.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';
import 'package:impacteer/controllers/get_user_details/user_detail_events.dart';
import 'package:impacteer/controllers/get_user_details/user_details_controller.dart';

import 'package:impacteer/models/user_details_model.dart';
import 'package:impacteer/ui/widgets/details_image_view.dart';
import 'package:impacteer/ui/widgets/loading_view.dart';
import 'package:impacteer/utils/app_colors.dart';
import 'package:impacteer/utils/app_strings.dart';
import 'package:impacteer/utils/app_styles.dart';

class DetailsScreen extends StatefulWidget {
  final int? users;
  const DetailsScreen({super.key, this.users});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  UserDetailsModel? _usersDetailsModel;

  @override
  void initState() {
    super.initState();
    context
        .read<UserDetailController>()
        .add(GetUserDetails(userId: widget.users ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<UserDetailController>(
      defaultView: _getBody,
      // loadingView: _loadingView,
      onSuccess: (BlocEventState eventState) {
        _usersDetailsModel =
            UserDetailsModel.fromJson(eventState.response?.data);
      },
    );
  }

  Widget _getBody(BlocEventState eventState) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white.withOpacity(0.85),
          body: CustomScrollView(
            slivers: [
              /// top image
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.themeColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: DetailsImageView(
                    image: _usersDetailsModel?.data?.avatar,
                  ),
                  title: Text(_usersDetailsModel?.data?.firstName ?? ''),
                ),
                expandedHeight: MediaQuery.of(context).size.height * 0.305,
              ),

              /// content
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        _usersDetailsModel?.data?.email ?? '',
                        style: AppStyles.black24SemiBold,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (eventState.state != BlocState.loading)
                        Text(
                          AppStrings.dummtText,
                          style: AppStyles.blackRegular,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (eventState.state == BlocState.loading) const LoadingView(),
      ],
    );
  }
}
