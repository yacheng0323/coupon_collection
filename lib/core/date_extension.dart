extension DateTimeExtensions on DateTime {
  bool isExpired() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime targetDate = DateTime(year, month, day);

    return targetDate.isBefore(today);
  }

  bool isNotExpired() {
    return !isExpired();
  }
}
