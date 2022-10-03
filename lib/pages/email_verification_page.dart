import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailVerificationPage extends HookConsumerWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    final actionCodeSettings = ActionCodeSettings(
        url: 'https://www.gymin.co.in',
        handleCodeInApp: true,
        androidInstallApp: true,
        androidMinimumVersion: '12');

    Future<void> checkEmailVerified() async {
      await user!.reload();

      if (user.emailVerified) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        aShowToast(msg: "Enter a verified email");
      }
    }

    useEffect(
      () {
        user!.sendEmailVerification(actionCodeSettings);

        final timer = Timer.periodic(Duration(seconds: 5), (timer) async {
          await checkEmailVerified();
        });
        return () {
          timer.cancel();
        };
      },
      [user],
    );

    return Scaffold(
      body: Center(
        child: Text("Email Verifying Link has been sent to ${user!.email}"),
      ),
    );
  }
}
