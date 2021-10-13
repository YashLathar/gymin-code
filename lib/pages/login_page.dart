import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gym_in/widgets/rounded_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final loadingStateProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return value;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: watch(loadingStateProvider).state,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: Container(
            //boxdecoration
            width: size.width,
            height: size.height,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Image.asset('assets/img/splashlogo.png', height: 100, width: 200,),
                      Container(
                        height: 150,
                        width: 270,
                        child: Image.asset('assets/home-page-heading.png'),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        //margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            RoundedTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              secureIt: false,
                            ),
                            RoundedTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              secureIt: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.select_all),
                            Text("I agree with Privacy and Policy"),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5.0,
                      // ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 30, right: 30, bottom: 10),
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.redAccent,
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
                                'Login Securely',
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
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                                  onPressed: () {
                                }, 
                                  child: Text("Forgot Password?", 
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    ),
                                  )
                                ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 345.0,
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          width: 328.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: ImageIcon(
                                  AssetImage('assets/google-icon 1.png'),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                  child: Text('Continue with Google',
                                    style: kRoundedButtonTextStyle.copyWith(
                                    color: Colors.black
                                  )
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        width: 345.0,
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          width: 328.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  FontAwesomeIcons.facebookF,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                  child: Text('Continue with Facebook',
                                  style: kRoundedButtonTextStyle.copyWith(
                                  color: Colors.black
                                  )
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: kRoundedButtonTextStyle.copyWith(
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/signUpPage");
                            },
                            child: Text(
                              "Sign Up",
                              style: kRoundedButtonTextStyle.copyWith(
                                  color: Colors.redAccent,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
