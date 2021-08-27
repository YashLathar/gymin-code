class Gym {
  final String gymName;
  final List<String> gymPhotoUrl;
  final int ratings;
  final String description;
  final String address;
  final bool isOpen;
  final List<String> trainersPhotoUrl;

  Gym({
    required this.gymName,
    required this.gymPhotoUrl,
    required this.ratings,
    required this.address,
    required this.description,
    required this.isOpen,
    required this.trainersPhotoUrl,
  });
}
