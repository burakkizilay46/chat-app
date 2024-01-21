import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/constants/image/image_constants.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';

import 'package:chat_app/features/signin/provider/signin_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        provider: SignInProvider(),
        onProviderReady: (provider) {
          provider.init();
          provider.setContext(context);
        },
        onPageBuilder: (SignInProvider provider) => Scaffold(
              backgroundColor: context.appColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('sign in', style: context.normalTextStyle.copyWith(fontSize: 32, color: context.appWhite)),
                    ElevatedButton(
                        onPressed: () => context.read<SignInProvider>().signIn(),
                        child: Row(
                          children: [
                            SizedBox(height: 24, child: Image.asset(ImageConstants.instance.googleLogo)),
                            Text('Sign in with Google')
                          ],
                        ))
                  ],
                ),
              ),
            ));
  }
}
