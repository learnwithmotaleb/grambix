import 'package:get/get.dart';
import 'global/arabic.dart';
import 'global/english.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    'ar_SA': arabic,
  };
}
