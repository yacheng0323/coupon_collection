class CouponModel {
  final String storeName;
  final String category;
  final int startTime;
  final int endTime;
  final String? content;
  final String? imagePath;
  final int createTime;

  CouponModel({
    required this.storeName,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.createTime,
    this.content,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      "store_name": storeName,
      "category": category,
      "start_time": startTime,
      "end_time": endTime,
      "content": content,
      "image_path": imagePath,
      "create_time": createTime,
    };
  }

  factory CouponModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      CouponModel(
          storeName: map["store_name"],
          category: map["category"],
          startTime: map["start_time"],
          endTime: map["end_time"],
          content: map["content"],
          imagePath: map["image_path"],
          createTime: map["create_time"]);
}
