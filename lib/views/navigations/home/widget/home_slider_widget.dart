part of '../screen/home_screen.dart';

class HomeSliderWidget extends GetView<HomeController> {
  const HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CarouselSlider(
        items: controller.bannerList.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: url.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          height: 125.h,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: (index, reason) {},
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
