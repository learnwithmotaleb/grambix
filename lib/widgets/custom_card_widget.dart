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
      height: 210.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 500,
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
              margin: EdgeInsets.only(right: Dimensions.widthSize * 1.2),
              width: 135.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 0.85,
                    child: Container(
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
                        child: CachedNetworkImage(
                          imageUrl: getImagePath(item),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(color: Colors.grey),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported,
                            color: CustomColor.secondary,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space.height.v5,
                  TextWidget(
                    padding: Dimensions.horizontalSize.edgeHorizontal * 0.1,
                    getTitle(item),
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whiteColor,
                    maxLines: 1,
                    fontSize: Dimensions.titleSmall,
                  ),
                  Padding(
                    padding: Dimensions.horizontalSize.edgeHorizontal * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextWidget(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.verticalSize * 0.1,
                            ),
                            getSubtitle(item),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.titleSmall * 0.9,
                            color: CustomColor.secondary,
                          ),
                        ),
                        getTrailingIcon?.call(item) ??
                            SvgPicture.asset(Assets.icons.headphone),
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