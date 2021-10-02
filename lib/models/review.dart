class Review {
  final List<String> userPhotoUrl;
  final String userName;
  final String review;
  final bool editButton;

  Review({
    required this.userPhotoUrl,
    required this.userName,
    required this.review,
    required this.editButton,
  });
}