part of '../screen/find_screen.dart';

class SerachBoxWidget extends GetView<FindController> {
  const SerachBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: controller.updateSearchQuery,
      style: TextStyle(color: CustomColor.whiteColor),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: CustomColor.whiteColor.withOpacity(0.6)),
        prefixIcon: Icon(Icons.search, color: CustomColor.whiteColor),
        filled: true,
        fillColor: CustomColor.secondary.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
