part of '../screen/all_category_screen.dart';


class CustomGridWidget<T> extends StatelessWidget {
  final List<T> items;
  final void Function(T item)? onTap;
  final String Function(T item) getTitle;
  final String Function(T item) getSubtitle;
  final String Function(T item) getImageUrl;
  final String Function(T item)? argument;
  final Widget Function(T item)? getTrailingIcon;

  const CustomGridWidget({
    super.key,
    required this.items,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImageUrl,
    this.onTap,
    this.argument,
    this.getTrailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        Dimensions.defaultHorizontalSize,
        Dimensions.heightSize,
        Dimensions.defaultHorizontalSize,
        Dimensions.heightSize * 3,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Dimensions.widthSize * 1,
        mainAxisSpacing: Dimensions.heightSize * 1.5,
        childAspectRatio: 0.58,
      ),
      itemCount: items.length,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Container
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.7,
                    ),
                    border: Border.all(
                      color: CustomColor.secondary.withOpacity(0.3),
                      width: 0.8,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.7,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: getImageUrl(item),
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
                          size: 30.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space.height.add(3.h),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * 0.2,
                ),
                child: TextWidget(
                  getTitle(item),
                  fontWeight: FontWeight.w600,
                  color: CustomColor.whiteColor,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: Dimensions.titleSmall * 0.8,
                ),
              ),

              // Subtitle & Icon Row
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * 0.2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        getSubtitle(item),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: Dimensions.titleSmall * 0.7,
                        color: CustomColor.secondary,
                      ),
                    ),
                    if (getTrailingIcon != null) ...[
                      Space.width.add(3.w),
                      SizedBox(
                        height: 14.h,
                        width: 14.w,
                        child: getTrailingIcon!(item),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}