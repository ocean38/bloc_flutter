// staing => dev
// production => user

class ApiEndPoints {
  static const _baseUrl = 'https://reqres.in/';
  static get baseUrl => _baseUrl;

  /// End point
  static String getUser(page) => 'api/users?page=$page';
  static String getUsetList(userId) => 'api/users/$userId';
}

class ApiKeys {
  // HEADER keys
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String accept = 'Accept';

  // request keys
  static const String fields = 'fields';
  static const String files = 'files';
  static const String message = 'message';
  static const String errorNo = 'errorNo';
}
