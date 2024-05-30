extension DateTimeExtensions on DateTime {
  bool isExpired() {
    DateTime now = DateTime.now();

    return now.isAfter(this);
  }
}
