import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _imagePicker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    return await _imagePicker.pickImage(source: source);
  }
}
