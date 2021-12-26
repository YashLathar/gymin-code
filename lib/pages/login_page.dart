import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/user.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:gym_in/widgets/oauthlogin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gym_in/widgets/rounded_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final loadingStateProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;
    final user = watch(authControllerProvider);

    return ModalProgressHUD(
      inAsyncCall: watch(loadingStateProvider).state,
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
                        "Log in",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Log in with one of the following options.",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OAuthLoginButton(
                                  icon: Icon(FontAwesomeIcons.google,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color),
                                  onPressed: () async {
                                    await context
                                        .read(authControllerProvider.notifier)
                                        .signInWithGoogle(context);
                                    final firestore =
                                        context.read(firestoreProvider);

                                    final doc = await firestore
                                        .collection("users")
                                        .doc(user!.uid)
                                        .get();

                                    if (!doc.exists) {
                                      final userInAPP = UserInApp(
                                        age: 0,
                                        about: "not given",
                                        phoneNumber: 0,
                                        height: 0,
                                        weight: 0,
                                        userName: user.displayName ?? "",
                                        userPhoto: user.photoURL ?? "",
                                        bio: "not given",
                                        address: "not given",
                                      );

                                      await context
                                          .read(userDetailServiceProvider)
                                          .addUserInfo(
                                            userInAPP.height,
                                            userInAPP.age,
                                            userInAPP.phoneNumber,
                                            userInAPP.weight,
                                            userInAPP.userName,
                                            userInAPP.userPhoto,
                                            userInAPP.bio,
                                            userInAPP.about,
                                            userInAPP.address,
                                            false,
                                            false,
                                          );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: OAuthLoginButton(
                                  icon: Icon(
                                    FontAwesomeIcons.apple,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
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
                                  hintText: 'Enter your Password',
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
                                    'Log in Securely',
                                    style: kRoundedButtonTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              context.read(loadingStateProvider).state = true;
                              await context
                                  .read(authControllerProvider.notifier)
                                  .signIn(_emailController.text.trim(),
                                      _passwordController.text.trim(), context);

                              context.read(loadingStateProvider).state = false;
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: kRoundedButtonTextStyle.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => SignupPage2(),
                                //   ),
                                // );
                                Navigator.pushNamed(context, "/signUpPage");
                              },
                              child: Text(
                                "Sign up",
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
