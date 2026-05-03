import 'package:image_picker/image_picker.dart';

abstract class BaseUploadDocument {
  Future<String?> uploadImage(String path);
}
