import 'dart:ui';

class CategoryColor {
  static Color getColor(String category) {
    switch (category) {
      case "Electronics":
        return Color(0xffFFC1F1);
      case "Cosmetics":
        return Color(0xffC1E1FF);
      case "Supplies":
        return Color(0xff9CF50B);
      case "Foods":
        return Color(0xffFFDA17);
      case "Clothes":
        return Color(0xffFF8C00);
      case "Other":
        return Color(0xff8A2BE2);
      default:
        return Color(0xff8A2BE2);
    }
  }
}
