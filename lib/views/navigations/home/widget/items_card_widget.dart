part of '../screen/home_screen.dart';

class ItemsCardWidget extends GetView<HomeController> {
  const ItemsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        HeaderLine(
          header: Strings.trending,
          onTap: () => Get.toNamed(Routes.allCategoryScreen, arguments: 4),
        ),
        CustomItemsCardWidget(
          items: controller.trendingList,
          getImagePath: (item) => item.bookCover,
          getTitle: (item) => item.bookName,
          getSubtitle: (item) => item.synopsis,
          argument: (item) => item.id,
          getTrailingIcon: (item) => item.isBook == true
              ? SvgPicture.asset(Assets.icons.music)
              : item.isEbook == true
              ? SvgPicture.asset(Assets.icons.glass)
              : SvgPicture.asset(Assets.icons.headphone),
        ),
        HeaderLine(
          header: Strings.newReleases,
          onTap: () => Get.toNamed(Routes.allCategoryScreen, arguments: 5),
        ),
        CustomItemsCardWidget(
          items: controller.newReleaseList,
          getImagePath: (item) => item.bookCover,
          getTitle: (item) => item.bookName,
          getSubtitle: (item) => item.synopsis,
          argument: (item) => item.id,
          getTrailingIcon: (item) => item.isBook == true
              ? SvgPicture.asset(Assets.icons.music)
              : item.isEbook == true
              ? SvgPicture.asset(Assets.icons.glass)
              : SvgPicture.asset(Assets.icons.headphone),
        ),
        if (controller.recommendedList.isNotEmpty) ...[
          HeaderLine(
            header: Strings.recommended,
            onTap: () => Get.toNamed(Routes.allCategoryScreen, arguments: 6),
          ),
          CustomItemsCardWidget(
            items: controller.recommendedList,
            getImagePath: (item) => item.bookCover,
            getTitle: (item) => item.bookName,
            getSubtitle: (item) => item.synopsis,
            argument: (item) => item.id,
            getTrailingIcon: (item) => item.isBook == true
                ? SvgPicture.asset(Assets.icons.music)
                : item.isEbook == true
                ? SvgPicture.asset(Assets.icons.glass)
                : SvgPicture.asset(Assets.icons.headphone),
          ),
        ],
        Space.height.v40,
        Space.height.v40,
        Space.height.v10,
      ],
    );
  }
}
