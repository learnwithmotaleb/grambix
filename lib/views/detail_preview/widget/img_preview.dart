part of '../screen/detail_preview_screen.dart';

class ImgPreview extends GetView<DetailPreviewController> {
  const ImgPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160.w,
        height: 180.h,
        decoration: BoxDecoration(
          border: Border.all(color: CustomColor.secondary),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.85),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.85),
          child: CachedNetworkImage(
            imageUrl: controller.singleData.first.bookCover,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
