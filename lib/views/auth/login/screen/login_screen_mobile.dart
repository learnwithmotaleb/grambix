part of 'login_screen.dart';

class LoginScreenMobile extends GetView<LoginController> {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: TextWidget(
          Strings.logIn,
          color: CustomColor.whiteColor,
          fontSize: Dimensions.titleMedium * 1.2,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsGeometry.only(
            top: MediaQuery.of(context).size.height * 0.08,
            left: Dimensions.defaultHorizontalSize,
            right: Dimensions.defaultHorizontalSize,
          ),
          children: [AppLogoWidget(),
            FieldsSection(),
            Button()],
        ),
      ),
    );
  }
}
