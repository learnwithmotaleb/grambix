import 'core/utils/basic_import.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Text(
          "Common Home Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
