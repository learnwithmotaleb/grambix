import 'core/utils/basic_import.dart';

class IOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("iOS Screen")),
      body: Center(
        child: Text(
          "This is iOS Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
