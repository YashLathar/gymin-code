import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/services/contact_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final messageController = useTextEditingController();
    final contactService = ref.watch(contactServiceProvider);
    final user = ref.watch(authControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context).backgroundColor),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Get in Touch",
                          style: kSubHeadingStyle.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
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
                    SizedBox(height: 10),
                    TextField(
                      controller: usernameController,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.contact_mail,
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
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
                        hintText: "Enter your Full Name",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                    SizedBox(height: 25),
                    // Text(
                    //   "Your Email",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // TextField(
                    //   controller: emailController,
                    //   keyboardType: TextInputType.phone,
                    //   style: TextStyle(
                    //       color: Theme.of(context).textTheme.bodyText2!.color),
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.mail,
                    //         color:
                    //             Theme.of(context).textTheme.bodyText2!.color),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //       borderSide: BorderSide(
                    //         color: Theme.of(context).backgroundColor,
                    //         width: 2,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //       borderSide: BorderSide(
                    //         color: Colors.redAccent, //0xffF14C37
                    //         width: 2,
                    //       ),
                    //     ),
                    //     hintText: "Enter your email",
                    //     hintStyle: TextStyle(
                    //         color:
                    //             Theme.of(context).textTheme.bodyText2!.color),
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
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
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      "Message",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.text_fields,
                        //     color:
                        //         Theme.of(context).textTheme.bodyText2!.color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        hintText: "Enter your message",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10,
                          left: MediaQuery.of(context).size.width / 3.5),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () async {
                          if (phoneController.text.length == 10) {
                            final intPhone = int.parse(phoneController.text);

                            if (messageController.text.isNotEmpty) {
                              await contactService
                                  .addContactDocument(
                                      usernameController.text,
                                      user!.email!,
                                      intPhone,
                                      messageController.text,
                                      user.uid)
                                  .onError((error, stackTrace) => aShowToast(
                                      msg:
                                          "Cannot make multiple contact requests"));

                              usernameController.clear();
                              phoneController.clear();
                              messageController.clear();
                              aShowToast(
                                  msg: "Your request has been submitted");
                            } else {
                              aShowToast(msg: "Fields can't be empty");
                            }
                          } else {
                            aShowToast(msg: "Invalid Number");
                          }
                        },
                        child: Text("Submit Response"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
