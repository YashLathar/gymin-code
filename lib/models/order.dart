import 'dart:convert';

class Order {
  final String gymName;
  final String? userName;
  final String docId;
  final String fromDate;
  final String fromTime;
  final String planSelected;
  final String? userImage;
  Order({
    required this.gymName,
    this.userName,
    required this.docId,
    required this.fromDate,
    required this.fromTime,
    required this.planSelected,
    this.userImage,
  });

  Order copyWith({
    String? gymName,
    String? userName,
    String? docId,
    String? fromDate,
    String? fromTime,
    String? planSelected,
    String? userImage,
  }) {
    return Order(
      gymName: gymName ?? this.gymName,
      userName: userName ?? this.userName,
      docId: docId ?? this.docId,
      fromDate: fromDate ?? this.fromDate,
      fromTime: fromTime ?? this.fromTime,
      planSelected: planSelected ?? this.planSelected,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gymName': gymName,
      'userName': userName,
      'docId': docId,
      'fromDate': fromDate,
      'fromTime': fromTime,
      'planSelected': planSelected,
      'userImage': userImage,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      gymName: map['gymName'],
      userName: map['userName'] != null ? map['userName'] : null,
      docId: map['docId'],
      fromDate: map['fromDate'],
      fromTime: map['fromTime'],
      planSelected: map['planSelected'],
      userImage: map['userImage'] != null ? map['userImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(gymName: $gymName, userName: $userName, docId: $docId, fromDate: $fromDate, fromTime: $fromTime, planSelected: $planSelected, userImage: $userImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.gymName == gymName &&
        other.userName == userName &&
        other.docId == docId &&
        other.fromDate == fromDate &&
        other.fromTime == fromTime &&
        other.planSelected == planSelected &&
        other.userImage == userImage;
  }

  @override
  int get hashCode {
    return gymName.hashCode ^
        userName.hashCode ^
        docId.hashCode ^
        fromDate.hashCode ^
        fromTime.hashCode ^
        planSelected.hashCode ^
        userImage.hashCode;
  }
}
