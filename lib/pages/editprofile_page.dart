import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:gym_in/services/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserEditBottomSheet extends HookWidget {
  const UserEditBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = useProvider(imagePickerProvider);
    final usernameController = useTextEditingController();
    final imagePath = useState("");

    Future<XFile?> imagePicker() async {
      final image = await imageProvider.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagePath.value = image.path;
        return image;
      }
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
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
                        await context
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
                    color: Theme.of(context).textTheme.bodyText2!.color),
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
                  padding: EdgeInsets.only(right: 15.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 2,
                        ),
                      ),
                      hintText: "Enter Your Name",
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      helperText: 'What should we call you?',
                      helperStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
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
                padding: EdgeInsets.all(30),
                child: MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onPressed: () async {
                    if (usernameController.text == "") {
                      return ErrorHandler.errorDialog(
                          context, ErrorWidget("This field can't be empty"));
                    }

                    final downloadUrl = await context
                        .read(storageServiceProvider)
                        .getDownloadUrl();

                    await context
                        .read(authControllerProvider.notifier)
                        .setUserName(usernameController.text);

                    await context
                        .read(authControllerProvider.notifier)
                        .setProfilePhoto(downloadUrl);

                    usernameController.text = "";
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
