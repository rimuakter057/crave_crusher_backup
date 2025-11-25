import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  String imagePath = ''; // normal string, not Rx

  Future<void> getImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final image = await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath = image.path; // update value
      update(); // trigger UI rebuild in GetBuilder
    }
  }
}
