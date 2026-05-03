import 'package:card_swift/service/upload_document.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentRepository {
  UploadDocument uploadDocument = UploadDocument();

  Future<String?> uploadImage(String path) async {
    var uploadImageUrl = uploadDocument.uploadImage(path);
    return uploadImageUrl;
  }
}
