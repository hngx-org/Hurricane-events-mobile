import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/sign_up/widgets/google_button.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/domain/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "sign_up";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome on board!",
                      style: TextStyle(
                        fontSize: 64,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    96.height,
                    Image.asset(
                      AppImages.imgWelcome,
                      height: 234,
                      width: 234,
                    ),
                    96.height,
                    Text(
                      "Sign in or Create an account",
                      style: context.body1.copyWith(
                        fontSize: 23,
                      ),
                    ),
                    32.height,
                    Builder(builder: (context) {
                      if (auth.state == AppState.loading) {
                        return const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.darkBlue1,
                            ),
                          ),
                        );
                      }
                      return GoogleButton(
                        onTap: () {
                          auth.googleLogin();
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
