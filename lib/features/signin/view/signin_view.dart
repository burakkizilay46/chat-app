import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/constants/image/image_constants.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';

import 'package:chat_app/features/signin/provider/signin_provider.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        provider: SignInProvider(),
        onProviderReady: (SignInProvider provider) {
          provider.setContext(context);
          provider.init();
        },
        onPageBuilder: (SignInProvider provider) => Scaffold(
              backgroundColor: context.appColor,
              body: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign In With Google!',
                          style: context.normalTextStyle.copyWith(fontSize: 32, color: context.appWhite)),
                      ElevatedButton(
                          onPressed: () => context.read<UserProvider>().signIn(),
                          child: Row(
                            children: [
                              SizedBox(height: 24, child: Image.asset(ImageConstants.instance.googleLogo)),
                              const Text('Sign in with Google')
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ));
  }
}
