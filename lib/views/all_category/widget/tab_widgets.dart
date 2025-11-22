part of '../screen/all_category_screen.dart';

class TrendingItems extends GetView<HomeController> {
  const TrendingItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingHomeData.value
          ? LoadingWidget()
          : controller.trendingList.isNotEmpty
          ? CustomGridWidget(
              items: controller.trendingList,
              getTitle: (item) => item.bookName,
              getSubtitle: (item) => item.bookName,
              getImageUrl: (item) => item.bookCover,
              getTrailingIcon: (item) => SvgPicture.asset(Assets.icons.glass),
              argument: (item) => item.id,
            )
          : EmptyDataWidget(),
    );
  }
}

class NewReleaseWidget extends GetView<HomeController> {
  const NewReleaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingHomeData.value
          ? LoadingWidget()
          : controller.newReleaseList.isNotEmpty
          ? CustomGridWidget(
              items: controller.newReleaseList,
              getTitle: (item) => item.bookName,
              getSubtitle: (item) => item.bookName,
              getImageUrl: (item) => item.bookCover,
              getTrailingIcon: (item) => SvgPicture.asset(Assets.icons.glass),
              argument: (item) => item.id,
            )
          : EmptyDataWidget(),
    );
  }
}

class RecommendedWidget extends GetView<HomeController> {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingHomeData.value
          ? LoadingWidget()
          : controller.recommendedList.isNotEmpty
          ? CustomGridWidget(
              items: controller.recommendedList,
              getTitle: (item) => item.bookName,
              getSubtitle: (item) => item.bookName,
              getImageUrl: (item) => item.bookCover,
              getTrailingIcon: (item) => SvgPicture.asset(Assets.icons.glass),
              argument: (item) => item.id,
            )
          : EmptyDataWidget(),
    );
  }
}

class EbooksWidget extends GetView<AllCategoryController> {
  const EbooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingEbook.value
          ? LoadingWidget()
          : controller.ebookList.isNotEmpty
          ? CustomGridWidget(
              items: controller.ebookList,
              getTitle: (item) => item.bookName,
              getSubtitle: (item) => item.synopsis,
              getImageUrl: (item) => item.bookCover,
              getTrailingIcon: (item) => SvgPicture.asset(Assets.icons.glass),
              argument: (item) => item.id,
            )
          : EmptyDataWidget(),
    );
  }
}

class AudioBooksWidget extends GetView<AllCategoryController> {
  const AudioBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingAudioBook.value
          ? LoadingWidget()
          : controller.audioBookList.isNotEmpty
          ? CustomGridWidget(
              items: controller.audioBookList,
              getTitle: (item) => item.bookName,
              getSubtitle: (item) => item.synopsis,
              getImageUrl: (item) => item.bookCover,
              getTrailingIcon: (item) => SvgPicture.asset(Assets.icons.glass),
              argument: (item) => item.id,
            )
          : EmptyDataWidget(),
    );
  }
}
