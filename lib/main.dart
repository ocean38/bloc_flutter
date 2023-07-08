import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/controllers/get_user_details/user_details_controller.dart';
import 'package:impacteer/controllers/get_user_list/user_controller.dart';
import 'package:impacteer/ui/screens/home_screen.dart';
import 'package:impacteer/utils/app_styles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserController()),
        BlocProvider(create: (_) => UserDetailController()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: AppStyles.fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
