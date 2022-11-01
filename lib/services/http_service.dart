import 'package:basalt/basalt.dart';
import 'package:http/http.dart' as http;

class HttpService {

  static Future<dynamic> postAPICall(
      String path, Function(dynamic response, String? error) onComplete,
      {Map<String, dynamic>? data}) async {
    Uri uri = HttpUtils.getUrl(path);
    String payload = HttpUtils.encodePayload(data);
    PrintUtils.printOut("Requesting: ${uri.toString()} $payload");

    try {
      http.Response response = await http.post(
        uri,
        body: payload,
        headers: HttpUtils.getHeader(),
      );

      PrintUtils.printOut("response>>: ${response.body} <<");

      Map responseBody = jsonDecode(response.body);
      bool success = responseBody["error"] == null;

      if (!success) {
        String errorMessage = responseBody["error"]["message"];
        onComplete(null, errorMessage);
        return Future.error(errorMessage);
      } else {
        var result = responseBody;
        onComplete(result, null);
        return Future.value(responseBody);
      }
    } catch (e) {
      String error = "Error occurred, ${e.toString()}";
      onComplete(null, error);
      return Future.error(error);
    }
  }

  static Future<dynamic> getAPICall(
      String path, Function(dynamic response, String? error) onComplete,
      {Map<String, dynamic>? data}) async {

    Uri uri = HttpUtils.getUrlWithPayload(path, data);
    PrintUtils.printOut("Requesting: ${uri.toString()}");

    try {
      var response = await http.get(uri, headers: HttpUtils.getHeader());

      PrintUtils.printOut("response>>: ${response.body} <<");

      Map responseBody = jsonDecode(response.body);
      bool success = responseBody["error"] == null;

      if (!success) {
        String errorMessage = responseBody["error"]["message"];
        onComplete(null, errorMessage);
        return Future.error(errorMessage);
      } else {
        var result = responseBody;
        onComplete(result, null);
        return Future.value(responseBody);
      }
    } catch (e) {
      String error = "Error occurred, ${e.toString()}";
      onComplete(null, error);
      return Future.error(error);
    }
  }

}
