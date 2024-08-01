import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/data/service/local/local_service.dart';

GetIt getIt = GetIt.instance;

class Injection {
  static void register() {
    // local service
    getIt.registerFactory<LocalService>(() => LocalServiceImpl());

    // image picker and cropper
    getIt.registerSingleton(ImagePicker());
    getIt.registerSingleton(ImageCropper());
  }
}
