import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:gym_in/services/storage_service.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserEditBottomSheet extends HookConsumerWidget {
  const UserEditBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = ref.watch(imagePickerProvider);
    final usernameController = useTextEditingController();
    final user = ref.watch(authControllerProvider);
    final imagePath = useState("");
    final isLoading = useState(false);

    Future<XFile?> imagePicker() async {
      final image = await imageProvider.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagePath.value = image.path;
        return image;
      }
      return null;
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: isLoading.value
          ? Center(
              child: Container(
                width: 85,
                height: 85,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.drag_handle,
                          color: Theme.of(context).backgroundColor),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 50,
                              backgroundImage: imagePath.value.isEmpty
                                  ? null
                                  : Image.file(File(imagePath.value)).image),
                          InkWell(
                            onTap: () async {
                              await imagePicker().then((xFile) async {
                                if (xFile != null) {
                                  final filePath = xFile.path;
                                  final file = File(filePath);
                                  await ref
                                      .read(storageServiceProvider)
                                      .uploadProfileImage(file);
                                }
                              });
                            },
                            child: Center(
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update Your Profile',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel),
                          color: Theme.of(context).textTheme.bodyText2!.color,
                          iconSize: 25,
                          //label: Text("Cancel")
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                              ),
                              controller: usernameController,
                              decoration: InputDecoration(
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
                                hintText: "Enter Your Name",
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color),
                                helperText: 'What should we call you?',
                                helperStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30,
                              MediaQuery.of(context).viewInsets.bottom),
                          child: MaterialButton(
                            color: Colors.redAccent,
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            onPressed: () async {
                              if (usernameController.text == "") {
                                return ErrorHandler.errorDialog(context,
                                    ErrorWidget("This field can't be empty"));
                              }

                              isLoading.value = true;

                              final downloadUrl = await ref
                                  .read(storageServiceProvider)
                                  .getDownloadUrl();

                              await ref
                                  .read(authControllerProvider.notifier)
                                  .setUserName(usernameController.text);

                              await ref
                                  .read(authControllerProvider.notifier)
                                  .setProfilePhoto(downloadUrl);

                              await ref
                                  .read(userDetailServiceProvider)
                                  .updateUserName(
                                      usernameController.text, user!.uid)
                                  .onError((error, stackTrace) =>
                                      isLoading.value = false);

                              await ref
                                  .read(userDetailServiceProvider)
                                  .updateUserPhoto(downloadUrl, user.uid)
                                  .onError((error, stackTrace) =>
                                      isLoading.value = false);

                              isLoading.value = false;
                              usernameController.text = "";
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
