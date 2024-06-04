List<String> get categoryList => [
      "All",
      "Electronics",
      "Cosmetics",
      "Supplies",
      "Foods",
      "Clothes",
      "Other",
    ];

List<String> get validityList => [
      "All",
      "Available", // 可使用
      "Expired" // 已過期
    ];

List<String> get sortOptionsList => [
      "default",
      "Started AtZ", // 起始日從小到大
      "Started ZtA", // 起始日從大到小
      "Expired AtZ", // 到期日從小到大
      "Expired ZtA", // 到期日從大到小
    ];
