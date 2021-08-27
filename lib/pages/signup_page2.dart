// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:gym_in/constants.dart';
// import 'package:gym_in/pages/login_page.dart';
// import 'package:gym_in/widgets/rounded_textfield.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:image_picker/image_picker.dart';

// class SignupPage2 extends HookWidget {
  
//   final ImagePicker _picker = ImagePicker();
//   final _usernameController = TextEditingController();
//   final _aboutController = TextEditingController();


  

//   @override
//   Widget build(BuildContext context) {
//     final loadingState = useProvider(loadingStateProvider);

//     final _imagePath = useState("");
//     Size size = MediaQuery.of(context).size;
     
// Future<XFile?> imagePicker() async {
//     final image = await _picker.pickImage(source: ImageSource.gallery);
//     _imagePath.value = image!.path;
//     print(_imagePath.value);
//     return image;
//   }
 


//     return ModalProgressHUD(
//       inAsyncCall: loadingState.state,
//       progressIndicator: CircularProgressIndicator(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(
//                 'https://images.pexels.com/photos/1431282/pexels-photo-1431282.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           width: size.width,
//           height: size.height,
//           child: ListView(physics: ClampingScrollPhysics(), children: [
//             SafeArea(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Image.asset(
//                     'assets/img/splashlogo.png',
//                     height: 120,
//                     width: 200,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 200,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Text(
//                     'Fill Up all the Details',
//                     style: kLoginPageSubHeadingTextStyle.copyWith(
//                         color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     children: [
//                       imageProfile(context, _imagePath, imagePicker),
//                       RoundedTextField(
//                         controller: _usernameController,
//                         hintText: 'What should we Call you ?',
//                         secureIt: false,
//                       ),
//                       RoundedTextField(
//                         controller: _aboutController,
//                         hintText: 'Say Something about you',
//                         secureIt: false,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     GestureDetector(
//                       child: Container(
//                         margin:
//                             EdgeInsets.only(left: 30, right: 30, bottom: 40),
//                         height: 45,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(25)),
//                           color: Colors.red,
//                           gradient: LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [
//                               Color(0xffc0c0aa),
//                               Color(0xff1cefff),
//                             ],
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.lock_outlined,
//                               color: Colors.white,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               'Continue to Gymin',
//                               style: kRoundedButtonTextStyle.copyWith(
//                                   color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already have an account?",
//                           style: kRoundedButtonTextStyle.copyWith(
//                               color: Colors.white),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LoginPage()));
//                           },
//                           child: Text(
//                             "Log In",
//                             style: kRoundedButtonTextStyle.copyWith(
//                                 color: Colors.redAccent,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//           ]),
//         ),
//       ),
//     );
//   }

//   Widget imageProfile(BuildContext context, imagePath, Function imagePicker) {
//     return Stack(
//       alignment: Alignment.center,
//       children: <Widget>[
//         CircleAvatar(
//           radius: 60.0,
//           backgroundImage: imagePath.value.isEmpty
//               ? AssetImage("assets/img/splashlogo.png")
//               : Image.file(File(imagePath.value)).image,
//         ),
//         InkWell(
//           onTap: () {
//             showModalBottomSheet<void>(
//                 context: context,
//                 builder: ((BuildContext context) => bottomSheet(context, imagePicker)));
//           },
//           child: Icon(
//             Icons.camera_alt,
//             color: Colors.teal,
//             size: 28,
//           ),
//         )
//       ],
//     );
//   }

//   Widget bottomSheet(BuildContext context, Function imagePicker) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       width: size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: <Widget>[
//           Text('Choose a Profile Pic'),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.camera),
//                   label: Text("Camera")),
//               TextButton.icon(
//                   onPressed: () {
//                     imagePicker();
//                   },
//                   icon: Icon(Icons.image),
//                   label: Text("Gallery"))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
