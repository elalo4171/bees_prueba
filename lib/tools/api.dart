class Api {
  static const server = "api.itbook.store";

  /// [User]

  static const news = "/1.0/new";

  static String Function(String) get search =>
      (String query) => "/1.0/search/$query";

  static String Function(String, int) get searchPagnitation =>
      (String query, int page) => "/1.0/search/$query/$page";

  static String Function(String) get book =>
      (String isbn13) => "/1.0/books/$isbn13";
}
