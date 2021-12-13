import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignupPage2 extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final heightController = useTextEditingController();
    final ageController = useTextEditingController();
    final weightController = useTextEditingController();
    final phoneController = useTextEditingController();
    final bioController = useTextEditingController();
    final aboutController = useTextEditingController();
    final userDetailProvider = useProvider(userDetailServiceProvider);

    return ModalProgressHUD(
      inAsyncCall: context.read(loadingStateProvider).state,
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
                          padding: EdgeInsets.only(
                              right: 30, top: 20, left: 30, bottom: 0),
                          child: Text(
                            "More About\nYou...",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 20.0),
                        //   // ignore: deprecated_member_use
                        //   child: RaisedButton(
                        //     color: Colors.redAccent,
                        //     onPressed: () {},
                        //   child: Text("Skip"),
                        //   ),
                        // )
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
                                      controller: heightController,
                                      keyboardType: TextInputType.phone,
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
                                        hintText: "Enter Your height(cms)",
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
                                      controller: ageController,
                                      keyboardType: TextInputType.phone,
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
                                  controller: weightController,
                                  keyboardType: TextInputType.phone,
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
                                    hintText: "Enter your Weight(Kg)",
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
                                  "Phone Number",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
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
                                    hintText: "Enter your Phone Number",
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
                                  controller: bioController,
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
                                  controller: aboutController,
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
                              top: 5,
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
                          onTap: () async {
                            final intHeight = int.parse(heightController.text);
                            final intAge = int.parse(ageController.text);
                            final intWeight = int.parse(weightController.text);
                            final intPhone = int.parse(phoneController.text);
                            context.read(loadingStateProvider).state = true;

                            await userDetailProvider.addUserInfo(
                              intHeight,
                              intAge,
                              intPhone,
                              intWeight,
                              bioController.text,
                              aboutController.text,
                            );
                            context.read(loadingStateProvider).state = false;

                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
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
                    // Center(
                    //   child: Image.asset(
                    //     'assets/img/splashlogo.png',
                    //     height: 100,
                    //     width: 200,
                    //   ),
                    // ),
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
