class Api {
  static const server = "api.itbook.store";

  /// [User]

  static const news = "/1.0/new";

  static String Function(String) get search =>
      (String query) => "/1.0/search/$query";
}
