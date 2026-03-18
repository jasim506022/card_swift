import 'package:card_swift/common/style/app_assets.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/model/onboarding_model.dart';

class OnboardingListData {
  static List<OnboardingModel> getOnboardingData() => [
    OnboardingModel(
      title: AppString.scanCardsTitle,
      image: AppAssets.scanCard,
      description: AppString.scanCardsDescription,
    ),
    OnboardingModel(
      title: AppString.expertDataTitle,
      image: AppAssets.exportData,
      description: AppString.exportDataDescription,
    ),
    OnboardingModel(
      title: AppString.crmIntegrationTitle,
      image: AppAssets.integration,
      description: AppString.crmIntegrationDescription,
    ),
    OnboardingModel(
      title: AppString.workTeamTitle,
      image: AppAssets.workTeam,
      description: AppString.workTeamDescription,
    ),
  ];
}
