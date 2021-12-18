import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseFeedbackService {
  Future<void> addFeedbackDocument(
    String serviceRating,
    String productsRating,
    String email,
    String feedback,
    String userUid,
  );
}

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  return FeedbackService(ref.read);
});

class FeedbackService implements BaseFeedbackService {
  final Reader _read;

  FeedbackService(this._read);

  @override
  Future<void> addFeedbackDocument(
    String serviceRating,
    String productsRating,
    String email,
    String feedback,
    String userUid,
  ) async {
    try {
      final docAlready = await _read(firestoreProvider)
          .collection("feedbackForms")
          .doc(userUid)
          .get();
      if (!docAlready.exists) {
        await _read(firestoreProvider)
            .collection("feedbackForms")
            .doc(userUid)
            .set({
          "serviceRating": serviceRating,
          "email": email,
          "feedback": feedback,
          "productsRating": productsRating,
        });
      } else {
        throw CustomExeption(message: "Cannot create multiple documents");
      }
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
