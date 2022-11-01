import 'package:basalt/basalt.dart';

class HttpUtils {

  static Uri getUrl(String path) {
    return Uri.parse("${HttpConstants.baseUrl}$path");
  }

  static String encodePayload(Map? data) {
    data = data ?? {};
    data["access_key"] = HttpConstants.accessToken;
    String payload = jsonEncode(data);
    return payload;
  }

  static Uri getUrlWithPayload(String path, Map? data) {
    String url = "${HttpConstants.baseUrl}$path";
    data = data ?? {};
    data["access_key"] = HttpConstants.accessToken;
    url = "$url?";
    data.forEach((key, value) {
      url = "$url$key=$value&";
    });
    if (url.endsWith("&")) {
      url = url.substring(0, url.length - 1);
    }
    return Uri.parse(url);
  }

  static Map<String, String> getHeader() {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    return header;
  }

}
