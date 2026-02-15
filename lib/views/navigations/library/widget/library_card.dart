part of '../screen/library_screen.dart';

class LibrrayCard extends GetView<LibraryController> {
  const LibrrayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      // ← important
      cacheExtent: 500,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.51,
        crossAxisSpacing: Dimensions.widthSize,
      ),
      itemCount: controller.downloadedItems.length,
      itemBuilder: (context, index) {
        final item = controller.downloadedItems[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.offlinePreviewScreen, arguments: item);
                // if (item["pdf"] != null && item["pdf"].isNotEmpty) {
                //   Get.toNamed(
                //     Routes.readingScreen,
                //     arguments: {
                //       'saveImage': item['image'],
                //       'savePdf': item['pdf'],
                //       'Title': item['title'],
                //     },
                //   );
                // } else if (item["audio"] != null && item["audio"].isNotEmpty) {
                //   Get.toNamed(
                //     Routes.offlineScreen,
                //     arguments: {
                //       'saveImage': item['image'],
                //       'savePdf': item['audio'],
                //       'Title': item['title'],
                //     },
                //   );
                // }
              },
              child: Stack(
                children: [
                  Container(
                    height: 170.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.secondary),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.85,
                      ),
                    ),
                    child: item["image"] != null && item["image"].isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadiusGeometry.only(
                              topLeft: Radius.circular(Dimensions.radius * 0.8),
                              topRight: Radius.circular(
                                Dimensions.radius * 0.8,
                              ),
                            ),
                            child: Image.file(
                              File(item["image"]),
                              height: 155.h,
                              width: 180.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.book, size: 50, color: Colors.grey),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        color: Color(0xff21DCDC),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize * 0.6,
                        vertical: Dimensions.verticalSize * 0.1,
                      ),
                      child: TextWidget(
                        "Downloaded",
                        color: CustomColor.background,
                        fontSize: Dimensions.titleSmall * 0.85,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Space.height.v5,
            SizedBox(
              width: 130.w, // ← Image এর সমান width
              child: Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      item["title"] ?? "No Title",
                      fontWeight: FontWeight.bold,
                      color: CustomColor.whiteColor,
                      fontSize: Dimensions.titleSmall * 0.9,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final confirmed = await Get.dialog<bool>(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius,
                            ),
                          ),
                          elevation: 5,
                          backgroundColor: CustomColor.background,
                          child: Padding(
                            padding: EdgeInsets.all(
                              Dimensions.defaultHorizontalSize,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.redAccent,
                                  size: 50,
                                ),
                                SizedBox(height: Dimensions.verticalSize * 0.5),
                                Text(
                                  "Delete Item?",
                                  style: TextStyle(
                                    fontSize: Dimensions.titleLarge,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                                SizedBox(height: Dimensions.verticalSize * 0.3),
                                Text(
                                  "Are you sure you want to delete this item from your library?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Dimensions.titleSmall * 0.9,
                                    color: CustomColor.secondary,
                                  ),
                                ),
                                SizedBox(height: Dimensions.verticalSize * 0.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius * 0.5,
                                            ),
                                          ),
                                        ),
                                        onPressed: () => Get.back(result: true),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: CustomColor.whiteColor,
                                            fontSize: Dimensions.titleSmall,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.widthSize),
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: CustomColor.primary,
                                            width: 1.5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius * 0.5,
                                            ),
                                          ),
                                        ),
                                        onPressed: () => Get.back(result: false),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: Dimensions.titleSmall,
                                            color: CustomColor.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        barrierDismissible: true,
                      );

                      if (confirmed == true) {
                        Get.find<LibraryController>().deleteDownload(item);
                      }
                    },
                    child: SvgPicture.asset(
                      Assets.icons.delete,
                      height: Dimensions.iconSizeDefault * 0.9,
                    ),
                  ),
                ],
              ),
            ),
            Space.height.v5,
            SizedBox(
              width: 130.w, // ← Subtitle Row এও same width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextWidget(
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      item["synopsis"] ?? "",
                      fontSize: Dimensions.titleSmall * 0.85,
                      color: CustomColor.secondary,
                    ),
                  ),
                  item['pdf'] != null && item['audio'] != null
                      ? SvgPicture.asset(Assets.icons.music)
                      : item['pdf'] != null
                      ? SvgPicture.asset(Assets.icons.glass)
                      : item['audio'] != null
                      ? SvgPicture.asset(Assets.icons.headphone)
                      : SvgPicture.asset(Assets.icons.headphone),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
