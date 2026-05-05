import '../service/cloudinary_uploader.dart';

class CloudinaryUploaderRepository {
  CloudinaryUploader uploadDocument = CloudinaryUploader();

  Future<String?> uploadImage(String path) async {
    var uploadImageUrl = uploadDocument.uploadImage(path);
    return uploadImageUrl;
  }
}
