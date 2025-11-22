part of 'offline_preview_screen.dart';

class OfflinePreviewScreenMobile extends GetView<OfflinePreviewController> {
  const OfflinePreviewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
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
      body: Stack(
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.defaultHorizontalSize,
                    right: Dimensions.defaultHorizontalSize,
                    top: MediaQuery.of(context).size.height * 0.1,
                    bottom: Dimensions.verticalSize * 1.5,
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        controller.title,
                        fontSize: Dimensions.titleLarge * 0.9,
                        fontWeight: FontWeight.w600,

                        color: Colors.white,
                      ),
                      TextWidget(
                        padding: EdgeInsetsGeometry.only(
                          top: Dimensions.verticalSize * 0.2,
                        ),
                        controller.synopsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        color: CustomColor.secondary,
                      ),
                      Space.height.v5,
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColor.secondary.withAlpha(88),
                          borderRadius: BorderRadiusGeometry.circular(
                            Dimensions.radius * 0.5,
                          ),
                          border: Border.all(
                            color: CustomColor.whiteColor.withAlpha(88),
                            width: 1.2,
                          ),
                        ),

                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: Dimensions.defaultHorizontalSize * 1.8,
                          vertical: Dimensions.verticalSize * 0.15,
                        ),
                        child: TextWidget(
                          Strings.fiction,
                          color: CustomColor.secondary,
                          fontSize: Dimensions.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    ShapeContainer(),
                    Center(
                      child: Container(
                        width: 160.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColor.secondary),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius * 0.85,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius * 0.85,
                          ),
                          child: Image.file(
                            File(controller.image),
                            height: 155.h,
                            width: 180.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
