import 'dart:convert';

import 'package:card_swift/common/style/apps_constant.dart';
import 'package:card_swift/service/base_upload_document.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class UploadDocument implements BaseUploadDocument {
  @override
  Future<String?> uploadImage(String path) async {
    try {
      final mineType = lookupMimeType(path)?.split('/'); //file.path

      final uploadUrl = Uri.parse(AppsConstant.cloudinaryBaseUrl);

      var request = http.MultipartRequest("POST", uploadUrl)
        ..fields[AppsConstant.uploadPreset] = AppsConstant.uploadTest
        ..files.add(
          await http.MultipartFile.fromPath(
            "file",
            path, // file.path
            contentType: mineType != null
                ? http.MediaType(mineType[0], mineType[1])
                : null,
          ),
        );

      final response = await request.send();
      final result = await http.Response.fromStream(response);

      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);
        return data[AppsConstant.secureUrl];
      } else {
        if (kDebugMode) {
          print("Fail: ${result.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Upload Error $e");
      }
    }

    return null;
  }
}
