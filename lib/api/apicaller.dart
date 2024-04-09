import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCaller {
//   Get Api Calling
  static Future<dynamic> getApi(
      String sitename, String path, Map<String, String> map) async {
    final url = Uri.http(sitename, path, map);
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) throw Exception("Status Code is Not 200");
      print(response.statusCode);

      dynamic data = response.body.toString();
      return jsonDecode(data);
      // return response;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<dynamic> callTheUploadApi(
      String sitename, String path, Map<String, String> map,String imagepath) async {

    final url = Uri.http(sitename, path, map);
    print(url);
    print(imagepath);

    final request = http.MultipartRequest('POST', url);
    http.MultipartFile multipartFile =
    await http.MultipartFile.fromPath('filecontents', imagepath);
    request.files.add(multipartFile);

    final response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) print("Uploaded");

    return response.stream.bytesToString();
  }
}
