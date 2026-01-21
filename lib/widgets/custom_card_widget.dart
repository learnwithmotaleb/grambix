import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grambix/core/api/end_point/api_end_points.dart';
import 'package:grambix/core/utils/extensions.dart';
import 'package:grambix/res/assets.dart' hide Icons;
import 'package:grambix/widgets/text_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../core/utils/basic_import.dart';
import '../core/utils/space.dart';
import '../routes/routes.dart';
import '../views/navigations/home/screen/home_screen.dart';

class CustomItemsCardWidget<R> extends StatelessWidget {
  final List<R> items;
  final void Function(R item)? onTap;
  final String Function(R item) getImagePath;
  final String Function(R item) getTitle;
  final String Function(R item)? argument;
  final String Function(R item) getSubtitle;
  final bool Function(R item)? isBookItem;
  final Widget Function(R item)? getTrailingIcon;

  const CustomItemsCardWidget({
    super.key,
    required this.items,
    required this.getImagePath,
    required this.getTitle,
    required this.getSubtitle,
    this.onTap,
    this.isBookItem,
    this.getTrailingIcon,
    this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: min(items.length, 5),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(item);
              } else {
                if (argument != null) {
                  Get.toNamed(
                    Routes.detailPreviewScreen,
                    arguments: argument!(item),
                  );
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.widthSize * 1.5),
              width: 130.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image Container
                  Container(
                    height: 170.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.8,
                      ),
                      border: Border.all(
                        color: CustomColor.secondary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.8,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: getImagePath(item),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade700,
                          child: Container(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: CustomColor.secondary.withOpacity(0.1),
                          child: Icon(
                            Icons.image_not_supported,
                            color: CustomColor.secondary,
                            size: 40.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space.height.v5,

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widthSize * 0.3,
                    ),
                    child: TextWidget(
                      getTitle(item),
                      fontWeight: FontWeight.w600,
                      color: CustomColor.whiteColor,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: Dimensions.titleSmall * 0.95,
                    ),
                  ),

                  // Subtitle & Icon Row
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widthSize * 0.3,
                      vertical: Dimensions.heightSize * 0.2,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            getSubtitle(item),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.titleSmall * 0.85,
                            color: CustomColor.secondary,
                          ),
                        ),
                        Space.width.v5,
                        SizedBox(
                          height: 18.h,
                          width: 18.w,
                          child: getTrailingIcon?.call(item) ??
                              SvgPicture.asset(
                                Assets.icons.headphone,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  CustomColor.secondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}