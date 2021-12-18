import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseContactService {
  Future<void> addContactDocument(
    String userName,
    String email,
    int phoneNumber,
    String message,
    String userUid,
  );
}

final contactServiceProvider = Provider<ContactService>((ref) {
  return ContactService(ref.read);
});

class ContactService implements BaseContactService {
  final Reader _read;

  ContactService(this._read);

  @override
  Future<void> addContactDocument(
    String userName,
    String email,
    int phoneNumber,
    String message,
    String userUid,
  ) async {
    try {
      final docAlready = await _read(firestoreProvider)
          .collection("contactUsForms")
          .doc(userUid)
          .get();
      if (!docAlready.exists) {
        await _read(firestoreProvider)
            .collection("contactUsForms")
            .doc(userUid)
            .set({
          "userName": userName,
          "email": email,
          "phoneNumber": phoneNumber,
          "message": message,
        });
      } else {
        throw CustomExeption(message: "Cannot create multiple documents");
      }
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
