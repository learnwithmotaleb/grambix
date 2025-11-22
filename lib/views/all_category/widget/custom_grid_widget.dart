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
        0,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      cacheExtent: 500,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.widthSize * 0.8,
        childAspectRatio: 0.66,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return RepaintBoundary(
          child: GestureDetector(
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
            },            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        imageUrl:
                            getImageUrl(item),
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
                      getTrailingIcon?.call(item) ?? const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
