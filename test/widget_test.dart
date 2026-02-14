import 'package:grambix/main.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('Splash screen loads', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Wait for all frames to settle
    await tester.pumpAndSettle();

    // Check if the splash screen is shown by looking for a widget from it
    // Example: if SplashController shows a logo or text
    expect(find.text('Grambix'), findsOneWidget); // Replace 'Grambix' with actual splash text/logo
  });
}
