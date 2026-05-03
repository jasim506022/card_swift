import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class CloudinaryService {
  static const String cloudName = "dhugcawup";
  static const String uploadPreset = "upload-test";

  static Future<String?> uploadImage(XFile file) async {
    try {
      final mineType = lookupMimeType(file.path)?.split('/');

      final uploadUrl = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/auto/upload",
      );

      var request = http.MultipartRequest("POST", uploadUrl)
        ..fields["upload_preset"] = uploadPreset
        ..files.add(
          await http.MultipartFile.fromPath(
            "file",
            file.path,
            contentType: mineType != null
                ? http.MediaType(mineType[0], mineType[1])
                : null,
          ),
        );

      final response = await request.send();
      final result = await http.Response.fromStream(response);

      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);
        return data["secure_url"];
      } else {
        print("Fail: ${result.body}");
        return null;
      }
    } catch (e) {
      print("Upload Error $e");
    }

    return null;
  }
}
