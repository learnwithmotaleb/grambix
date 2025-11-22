import 'package:get/get.dart';
import '../views/top_books/controller/top_books_controller.dart';

class TopBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopBooksController>(() => TopBooksController());
  }
}
