import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage2 extends ConsumerWidget {
  // final _usernameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: Text(
                            "Continue",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: Colors.redAccent,
                            onPressed: () {},
                          child: Text("Skip"),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Height",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    TextField(
                                      // keyboardType: i,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color:
                                                Colors.redAccent, //0xffF14C37
                                            width: 2,
                                          ),
                                        ),
                                        hintText: "Enter Your height",
                                        hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Age",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    TextField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color:
                                                Colors.redAccent, //0xffF14C37
                                            width: 2,
                                          ),
                                        ),
                                        hintText: "Your Age",
                                        hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.redAccent, //0xffF14C37
                                        width: 2,
                                      ),
                                    ),
                                    hintText: "Enter your height",
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color),
                                  ),
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
                                  "About",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.redAccent, //0xffF14C37
                                        width: 2,
                                      ),
                                    ),
                                    hintText: "Enter your About",
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color),
                                  ),
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
                                  "Bio",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.redAccent, //0xffF14C37
                                        width: 2,
                                      ),
                                    ),
                                    hintText: "Enter your Bio",
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color),
                                  ),
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
                                    'Continue Sign up',
                                    style: kRoundedButtonTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {}),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Already have an account?",
                        //       style: kRoundedButtonTextStyle.copyWith(
                        //           color: Theme.of(context)
                        //               .textTheme
                        //               .bodyText2!
                        //               .color),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //       child: Text(
                        //         "Log In",
                        //         style: kRoundedButtonTextStyle.copyWith(
                        //             color: Colors.redAccent,
                        //             decoration: TextDecoration.underline),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 50,
                    // ),
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
