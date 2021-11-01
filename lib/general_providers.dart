import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) =>
    FirebaseStorage.instanceFor(bucket: "gs://gym-in-14938.appspot.com"));

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

//gs://gym-in-14938.appspot.com

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

// final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

// class AppThemeState extends ChangeNotifier {
//   var isDarkModeEnabled = false;
//   void setLightTheme() {
//     isDarkModeEnabled = false;
//     notifyListeners();
//   }
//   void setDarkTheme() {
//     isDarkModeEnabled = true;
//     notifyListeners();
//   }
// }