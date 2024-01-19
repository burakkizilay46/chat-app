import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/constants/image/image_constants.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';

import 'package:chat_app/features/signin/provider/signin_provider.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInProvider>(
      provider: SignInProvider(),
      onProviderReady: (provider) {
        provider.setContext(context);
      },
      onPageBuilder: Scaffold(
        backgroundColor: context.appColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sign in Chat App',
                  style: context.normalTextStyle.copyWith(fontSize: 32, color: context.appWhite),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height: 24, width: 24, child: Image.asset(ImageConstants.instance.googleLogo)),
                        Text(
                          'Sign in with Google',
                          style: context.normalTextStyle,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
