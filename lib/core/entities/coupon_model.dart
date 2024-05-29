class CouponModel {
  final String storeName;
  final String type;
  final int startTime;
  final int endTime;
  final String? content;
  final String? imagePath;

  CouponModel({
    required this.storeName,
    required this.type,
    required this.startTime,
    required this.endTime,
    this.content,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      "store_name": storeName,
      "type": type,
      "start_time": startTime,
      "end_time": endTime,
      "content": content,
      "image_path": imagePath,
    };
  }

  factory CouponModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      CouponModel(
          storeName: map["store_name"],
          type: map["type"],
          startTime: map["start_time"],
          endTime: map["end_time"],
          content: map["content"],
          imagePath: map["image_path"]);
}
