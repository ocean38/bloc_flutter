import 'package:flutter/material.dart';
import 'package:impacteer/models/user_model.dart';
import 'package:impacteer/ui/screens/details_screen.dart';
import 'package:impacteer/utils/app_colors.dart';
import 'package:impacteer/utils/app_styles.dart';

class UserTile extends StatelessWidget {
  final Users? user;
  const UserTile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: AppColors.themeColor.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => DetailsScreen(users: user?.id),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(user?.avatar ?? ''),
        ),
        title: Text(
          '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
          style: AppStyles.whiteBold,
        ),
        subtitle: Row(
          children: <Widget>[
            const Icon(Icons.linear_scale, color: AppColors.yellowAccent),
            Flexible(
              child: Text(
                ' ${user?.email ?? ''}',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.white14,
              ),
            )
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
