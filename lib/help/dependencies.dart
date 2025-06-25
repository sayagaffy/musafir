import 'package:get/get.dart';
import 'package:musafir/controllers/report_controller.dart';
import 'package:musafir/data/firestore/firestore_helper.dart';

class Dependencies {
  static final FirestoreHelper firestoreHelper = FirestoreHelper();

  static void init() {
    // Lazy put ReportController with FirestoreHelper dependency
    Get.lazyPut(() => ReportController(firestoreHelper: firestoreHelper));
  }
}
