part of 'detail_preview_screen.dart';

class DetailPreviewScreenMobile extends GetView<DetailPreviewController> {
  const DetailPreviewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          highlightColor: CustomColor.background,
          splashColor: CustomColor.background,
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              border: Border.all(color: CustomColor.whiteColor),
            ),
            child: Icon(
              Icons.arrow_back,
              color: CustomColor.whiteColor,
              size: Dimensions.iconSizeDefault,
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        RepaintBoundary(
                          child: Image.asset(Assets.logo.bg, fit: BoxFit.cover),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 20),
                          child: Container(
                            color: CustomColor.background.withOpacity(0.05),
                          ),
                        ),
                      ],
                    ),
                  ),

                  CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(child: TopTextHeading()),
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [ShapeContainer(), ImgPreview()],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
