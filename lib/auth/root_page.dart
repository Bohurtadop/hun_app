import 'package:flutter/material.dart';
import 'package:hun_app/Animations/auth_updating.dart';
import 'package:hun_app/Screens/Login.dart';
import 'package:hun_app/Screens/Main.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository userRepo, _) {
          switch (userRepo.status) {
            case AuthStatus.Uninitialized:
              return AuthAnimation();
            case AuthStatus.Unauthenticated:
            case AuthStatus.Authenticating:
              return Login();
            case AuthStatus.Authenticated:
              return MainPage();
            default:
              return AuthAnimation();
          }
        },
      ),
    );
  }
}
