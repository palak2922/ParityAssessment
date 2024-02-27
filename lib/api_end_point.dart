class ApiEndPoint {

  static const API_END_POINT = "http://stagingauth.desidime.com";

  Uri getHTTPUri(String url) {
    // return Uri.http(API_END_POINT, url);
    return Uri.parse(API_END_POINT+url);
  }

  String getUriParts(String uriParts) {
    return '/v4/$uriParts';
  }
}
