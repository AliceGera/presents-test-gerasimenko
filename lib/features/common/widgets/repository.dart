import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  Future<Uint8List?> getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final uint8List = await pickedFile.readAsBytes();
      return uint8List;
    }
    return null;
  }
}
