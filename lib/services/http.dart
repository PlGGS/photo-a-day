import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:photoaday/services/services.dart';

class DioClientService {
  static final userID = AuthService().user!.uid;
  static const baseURL = 'https://ny.storage.bunnycdn.com';
  static final userEndpoint = '$baseURL/photoaday/users/$userID/';
  static final bunnyAPIKey = dotenv.env['BUNNY_API_KEY'];

  Future<void> uploadImage(String imagePath) async {
    await dotenv.load();

    if (imagePath == '' || imagePath[imagePath.length - 1] == '/') {
      throw Exception('Invalid image name');
    }

    String imagePathWithoutFileName =
        imagePath.substring(0, imagePath.lastIndexOf('/'));
    String fileName = imagePath.substring(imagePath.lastIndexOf('/') + 1);

    String fileType = imagePath.substring(imagePath.lastIndexOf('.') + 1);
    if (fileType == 'jpg') fileType = 'jpeg';

    if (kDebugMode) {
      print(imagePathWithoutFileName);
      print(fileName);
      print(fileType);
    }

    var request = MultipartRequest(
      'PUT',
      Uri.parse(userEndpoint + fileName),
    );
    Map<String, String> headers = {
      'AccessKey': bunnyAPIKey!,
      'Accept': '*/*',
      "Authorization": "Bearer accessToken",
      "Content-Type": MediaType.parse('image/$fileType').toString(),
    };
    request.files.add(await MultipartFile.fromPath('file', imagePath));
    request.headers.addAll(headers);
    // request.fields.addAll({
    //   "name": "test",
    //   "email": "test@gmail.com",
    //   "id": "12345",
    // });
    print("Sending request: " + request.toString());
    var res = await request.send().catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });

    if (kDebugMode) {
      if (res.statusCode != 201) {
        print(res.headers);
        print(res.request);
      }

      print("This is response: ${res.reasonPhrase} ${res.statusCode}");
    }
    // return res.statusCode;
  }
}
