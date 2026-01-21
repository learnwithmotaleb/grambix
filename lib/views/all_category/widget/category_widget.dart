import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/space.dart';
import '../../../routes/routes.dart';
import '../../../widgets/text_widget.dart';
import '../controller/all_category_controller.dart';

class CategoryWidget extends GetView<AllCategoryController> {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.bookCategoryList.length,
        physics: ClampingScrollPhysics(),
        cacheExtent: 500,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: Dimensions.verticalSize * 0.8,
          left: Dimensions.defaultHorizontalSize,
          right: Dimensions.defaultHorizontalSize,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(color: CustomColor.secondary.withAlpha(88)),

              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                // যেখান থেকে পাঠাবে
                onTap: () => Get.toNamed(
                  Routes.categoryPreviewScreen,
                  arguments: {
                    'categoryId': controller.bookCategoryList[index].id,
                    'categoryName': controller.bookCategoryList[index].name, // অথবা যেকোনো data
                  },
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: Dimensions.verticalSize * 0.2,
                  ),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(
                              Dimensions.radius * 0.5,
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  controller.bookCategoryList[index].image,
                              fit: BoxFit.cover,
                              height: 55.h,
                              width: 55.w,
                              errorWidget: (context, error, stackTrace) => Icon(
                                Icons.image_not_supported,
                                color: CustomColor.secondary,
                                size: 50,
                              ),
                            ),
                          ),
                          TextWidget(
                            controller.bookCategoryList[index].name,
                            color: CustomColor.whiteColor,
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal:
                                  Dimensions.defaultHorizontalSize * 0.6,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: Dimensions.iconSizeDefault,
                        color: CustomColor.secondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
