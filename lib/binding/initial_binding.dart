import 'package:card_swift/controller/onboarding_controller.dart';
import 'package:card_swift/controller/upload_controller.dart';
import 'package:card_swift/repository/cloudinary_uploader_repository.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/splash_controller.dart';
import '../repository/auth_repository.dart';
import '../repository/splash_repository.dart';
import '../service/base_firebase_auth_service.dart';
import '../service/firebase_auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    //
    /// ---------------- Splash ----------------
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthService());

    Get.lazyPut<SplashRepository>(() => SplashRepository());

    Get.lazyPut<CloudinaryUploaderRepository>(() => CloudinaryUploaderRepository());

    Get.lazyPut<SplashController>(
      () => SplashController(repository: Get.find<SplashRepository>()),
    );

    Get.lazyPut<UploadController>(
      () => UploadController(repository: Get.find<CloudinaryUploaderRepository>()),
    );

    Get.lazyPut<OnboardingController>(() => OnboardingController());

    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find()),
      fenix: true,
    );
  }
}

/*

// Why use this why doesn't use normal why


Get.lazyPut<BaseFirebaseAuthService>(
  () => FirebaseAuthService(),
);

Get.lazyPut<SplashRepository>(
  () => SplashRepository(authService: Get.find()),
);

 */
