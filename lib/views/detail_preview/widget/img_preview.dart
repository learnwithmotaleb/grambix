part of '../screen/detail_preview_screen.dart';

class ImgPreview extends GetView<DetailPreviewController> {
  const ImgPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 180.w,
          maxHeight: 220.h,
        ),
        child: AspectRatio(
          aspectRatio: 0.85,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColor.secondary),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.85),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.85),
              child: CachedNetworkImage(
                imageUrl: controller.singleData.first.bookCover,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(
                  Icons.image_not_supported,
                  color: CustomColor.secondary,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}