import 'package:get/get.dart';
import 'package:grambix/res/assets.dart';

import '../model/serch_item_model.dart';

class FindController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    debounce(searchQuery, (_) {
      if (searchQuery.isNotEmpty) {
        performSearch();
      } else {
        searchResults.clear();
      }
    }, time: Duration(milliseconds: 300));
  }

  var searchQuery = ''.obs;
  final RxList<SearchItem> searchResults = <SearchItem>[].obs;
  var isLoading = false.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      performSearch();
    } else {
      searchResults.clear();
    }
  }

  final List<SearchItem> myDataList = [
    SearchItem(
      id: '1',
      title: 'Imagined By you',
      subtitle: 'Built By AI',
      imageUrl: Assets.logo.cardIMG,
    ),
    SearchItem(
      id: '2',
      title: 'By',
      subtitle: 'Built By AI',
      imageUrl: Assets.logo.cardIMG,
    ),
    SearchItem(
      id: '3',
      title: 'you are The',
      subtitle: 'Built By AI',
      imageUrl: Assets.logo.cardIMG,
    ),
    SearchItem(
      id: '4',
      title: 'magined By you',
      subtitle: 'Built By AI',
      imageUrl: Assets.logo.cardIMG,
    ),
    // more items...
  ];

  void performSearch() {
    final query = searchQuery.value.toLowerCase();

    searchResults.value = myDataList
        .where((item) => item.title.toLowerCase().contains(query))
        .toList();
  }
}
