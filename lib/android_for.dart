import 'core/utils/basic_import.dart';

class AndroidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Android Screen")),
      body: Center(
        child: Text(
          "This is Android Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
