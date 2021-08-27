import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
// import 'package:uuid/uuid.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// final StorageReference storageRef = FirebaseStorage.instance.ref();
// final usersRef = Firestore.instance.collection('users');
// final postsRef = Firestore.instance.collection('posts');

class UploadPage extends StatefulWidget {
  
  // final User currentUser;
  // Upload({ this.currentuser });


  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

    TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late File file;
  bool isUploading = false;
  //String postId = Uuid().v4();

  // handleTakePhoto() async {
  //   Navigator.pop(context);
  //   File file = await ImagePicker.pickImage(source: ImageSource.camera,
  //   maxHeight: 675,
  //   maxWidth: 960);
  //   setState(() {
  //     this.file = file;
  //   });
  // }

  // handleChooseFromGallery() async {
  //   Navigator.pop(context);
  //   File file = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     this.file = file;
  //   });
  // }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext, 
      builder: (context) {
        return SimpleDialog(
          title: Text("Create a Post"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Photo with Camera'),
              onPressed: () {},//handleTakePhoto
            ),
            SimpleDialogOption(
              child: Text('Image with Gallery'),
              onPressed: () {},  //handleChooseFromGallery
            ),
            SimpleDialogOption(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  }

  clearImage() {
    setState(() {
      //file = null;
    });
  }

  // compressImage() async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
  //   final compressedImageFile = File('$path/img_$postId.jpg')
  //   ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
  //   setState(() {
  //     file = compressedImageFile;
  //   });
  // }

  // Future<String> uploadImage(imageFile) async {
  //   StorageUploadTask uploadTask = storageRef.child("post_$postId.jpg").putFile(imageFile);
  // StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
  // String downloadUrl = await storageSnap.ref.getDownloadURL();
  // return downloadUrl;
  // }

  // createPostInFirestore({ String mediaUrl, String location, String description}) {
  //   postsRef.document(widget.currentUser.id)
  //   .collection("userPosts")
  //   .document(postId)
  //   .setData({
  //     "postId": postId,
  //     "ownerId": currentUser.Id,
  //     "username": currentUser.username,
  //     "mediaUrl": mediaUrl,
  //     "description": description,
  //     "location": location,
  //     "likes": {},
  //   });
  // }

   handleSubmit() async {
  //   setState(() {
  //     isUploading = true;
  //   });
  //   await compressImage();
  //   String mediaUrl = await uploadImage(file);
  //   createPostInFireStore(
  //     mediaUrl: mediaUrl,
  //     location: locationController.text,
  //     description: captionController.text,
  //   );
  //   captionController.clear();
  //   locationController.clear();
  //   setState(() {
  //     file = null;
  //     isUploading = false;
  //     postId = Uuid().v4();
  //   });
   }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: clearImage()
          ),
          title: Text("Caption Post"),
          actions: [TextButton(
            onPressed: 
            isUploading ? null : () => handleSubmit(), 
            child: Text("Post"))
            ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? LinearProgressIndicator() : Text(""),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file
                      )
                      )
                  ),
                ),
                ),
                ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0)
            ),
            ListTile(
              leading: CircleAvatar(
              //backgroundImage: CachedNetworkImageProvider
              //(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  helperText: "Write a caption",
                  border: InputBorder.none,),
              ),
            ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.pin_drop),
              title: Container(
                width: 250.0,
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "Where was this Photo Captured?",
                    border: InputBorder.none,
                    ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              // ignore: deprecated_member_use
              child: RaisedButton.icon(
                icon: Icon(Icons.my_location),
                onPressed: getUserLocation , 
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
                  label: Text("Use Current location"),
                ),
            )
        ],
        ),
    );
  }

    getUserLocation() async {
      // Position position = await Geolocator().getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.high); 
      // List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(position.latitude,
      // position.longitude);
      // Placemark placemark = placemarks[0];
      // String completeAddress = '${placemark.subThoroughfare}, ${placemark.thoroughfare}, ${placemark.sublocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.AdministrativeArea}, ${placemark.postalCode}, ${placemark.country}';
      // print(completeAddress);
      // String formattedAddress = "'${placemark.locality}, ${placemark.country}";
      // locationController.text = formattedAddress;
    }


   uploadSplashScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello There"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/home-page-heading.png'),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextButton(
                child: Text("Create a post"),
                onPressed: () {
                  selectImage(context);
                },
              )
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return uploadSplashScreen();
    // file == null ? uploadSplashScreen() : buildUploadForm();
  }
}