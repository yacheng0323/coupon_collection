import 'dart:ui';

class CategoryColor {
  static Color getColor(String category) {
    switch (category) {
      case "Electronics":
        return const Color(0xffFFC1F1);
      case "Cosmetics":
        return const Color(0xffC1E1FF);
      case "Supplies":
        return const Color(0xff9CF50B);
      case "Foods":
        return const Color(0xffFFDA17);
      case "Clothes":
        return const Color(0xffFF8C00);
      case "Other":
        return const Color(0xff8A2BE2);
      default:
        return const Color(0xff8A2BE2);
    }
  }
}
