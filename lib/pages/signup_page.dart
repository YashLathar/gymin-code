import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/pages/signup_page2.dart';
import 'package:gym_in/widgets/rounded_textfield.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: ref.watch(loadingStateProvider.state).state,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RoundedTextField(
                                  controller: _usernameController,
                                  hintText: 'What should we call you?',
                                  secureIt: false,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RoundedTextField(
                                  controller: _emailController,
                                  hintText: 'Your Email',
                                  secureIt: false,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RoundedTextField(
                                  controller: _passwordController,
                                  hintText: 'Create a Password',
                                  secureIt: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom: 30,
                                top: 10,
                              ),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.red,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff1EE1D72),
                                    Color(0xffF14C37),
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Sign up Securely',
                                    style: kRoundedButtonTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              if (_usernameController.text.isNotEmpty) {
                                ref.read(loadingStateProvider.state).state =
                                    true;
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .signUp(
                                        ref,
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        context);
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .setUserName(
                                        _usernameController.text.trim());
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .setProfilePhoto(
                                        "https://firebasestorage.googleapis.com/v0/b/gym-in-14938.appspot.com/o/defaultprofile%2Flogopng.png?alt=media&token=4b958ae5-addc-4cf6-a24e-fb73643ca863");
                                ref.read(loadingStateProvider.state).state =
                                    false;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage2(),
                                  ),
                                );
                              } else {
                                aShowToast(msg: "Please provide your name");
                              }

                              // Navigator.pop(context);
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: kRoundedButtonTextStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Log In",
                                style: kRoundedButtonTextStyle.copyWith(
                                    color: Colors.redAccent,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/splashlogo.png',
                        height: 100,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
