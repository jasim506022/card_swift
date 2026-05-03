
import 'package:get/get.dart';
import '../pages/contacts_page.dart';
import '../pages/scan_page.dart';
import '../pages/review_page.dart';
import '../pages/contact_form_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: Routes.contacts, page: () => const ContactsPage()),
    GetPage(name: Routes.scan, page: () => const ScanPage()),
    GetPage(name: Routes.review, page: () => const ReviewPage()),
    GetPage(name: Routes.contactForm, page: () => const ContactFormPage()),
  ];
}
