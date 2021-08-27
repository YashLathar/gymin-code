import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/login_page.dart';
// import 'package:gym_in/pages/signup_page2.dart';
import 'package:gym_in/widgets/rounded_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


// ignore: must_be_immutable
class SignupPage extends ConsumerWidget {
  // final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //to validate email
  String validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(email)) {
      return 'Enter Valid Email';
    }
    return email;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: watch(loadingStateProvider).state,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: NetworkImage(
          //       'https://images.pexels.com/photos/1431282/pexels-photo-1431282.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
          //     ),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          width: size.width,
          height: size.height,
          child: ListView(physics: ClampingScrollPhysics(), children: [
            SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/img/splashlogo.png',
                    height: 100,
                    width: 200,
                  ),
                ),
                Container(
                    height: 150,
                    width: 270,
                    child: Image.asset('assets/home-page-heading.png'),
                        ),
                SizedBox(
                    height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Text(
                //     'Sign Up with your Email',
                //     style: kLoginPageSubHeadingTextStyle.copyWith(
                //         color: Colors.white),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      // // setting up username textfield
                      // RoundedTextField(
                      //   controller: _usernameController,
                      //   hintText: 'What should we call you?',
                      //   secureIt: false,
                      // ),
                      RoundedTextField(
                        controller: _emailController,
                        hintText: 'Your Email',
                        secureIt: false,
                      ),
                      RoundedTextField(
                        controller: _passwordController,
                        hintText: 'create a Password',
                        secureIt: true,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 8, top: 7),
                      child: Row(
                        children: [
                          Icon(Icons.select_all),
                          Text("I agree with Privacy and Policy"),
                        ],
                      ),
                    ),
                    GestureDetector(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffc0c0aa),
                                Color(0xff1cefff),
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
                                'SignUp Securely',
                                style: kRoundedButtonTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          // to add the update username function
                          context.read(loadingStateProvider).state = true;
                          await context
                              .read(authControllerProvider.notifier)
                              .signUp(_emailController.text.trim(),
                                  _passwordController.text.trim(), context);
                          context.read(loadingStateProvider).state = false;
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SignupPage2()));
                        }
                      ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: kRoundedButtonTextStyle.copyWith(
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
