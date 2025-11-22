import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grambix/core/languages/strings.dart';
import 'package:grambix/core/themes/token.dart';
import 'package:grambix/core/utils/dimensions.dart';
import 'package:grambix/core/utils/space.dart';
import 'package:grambix/widgets/text_widget.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyData = [
      {'day': 'Mon', 'audioBook': 20.0, 'eBook': 30.0},
      {'day': 'Tue', 'audioBook': 40.0, 'eBook': 10.0},
      {'day': 'Wed', 'audioBook': 20.0, 'eBook': 50.0},
      {'day': 'Thu', 'audioBook': 40.0, 'eBook': 10.0},
      {'day': 'Fri', 'audioBook': 60.0, 'eBook': 30.0},
      {'day': 'Sat', 'audioBook': 30.0, 'eBook': 20.0},
      {'day': 'Sun', 'audioBook': 40.0, 'eBook': 10.0},
    ];

    // Progress percentage for the circular indicator
    const progressPercentage = 75.0;

    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: Dimensions.defaultHorizontalSize * 1.5,
        vertical: Dimensions.verticalSize * 0.5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.secondary),
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            Strings.myActivity,
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.bold,
          ),
          Space.height.v15,
          // Weekly activity bars
          SizedBox(
            height: 150.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData
                  .map((data) => _buildDayColumn(data))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Last 7 days', const Color(0xFFFFC107)),
              const SizedBox(width: 15),
              _buildLegendItem('E-Book', const Color(0xFFFFC107)),
              const SizedBox(width: 15),
              _buildLegendItem('Audio Book', const Color(0xFF4169E1)),
            ],
          ),
          const SizedBox(height: 30),
          // Circular progress indicator
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: CircularProgressPainter(progressPercentage),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '75%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayColumn(Map<String, dynamic> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20.w,
          height: 120.h,
          child: Stack(
            children: [
              Container(
                width: 20,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 20,
                  height: data['eBook'],
                  decoration: BoxDecoration(
                    color: CustomColor.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius * 0.5),
                      bottomRight: Radius.circular(Dimensions.radius * 0.5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: data['eBook'],
                child: Container(
                  width: 20,
                  height: data['audioBook'],
                  decoration: BoxDecoration(
                    color: CustomColor.blueColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radius * 0.5),
                      bottom: data['eBook'] == 0
                          ? Radius.circular(Dimensions.radius * 0.5)
                          : Radius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data['day'],
          style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;

  CircularProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = CustomColor.blueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawCircle(center, radius - 7.5, backgroundPaint);

    // Progress arc - Blue part (Audio Book)
    final blueArcPaint = Paint()
      ..color = const Color(0xFF4169E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 7.5),
      -90 * (3.14159 / 180), // Start from top (negative 90 degrees in radians)
      (percentage / 100 * 360) * (3.14159 / 180),
      // Convert percentage to radians
      false,
      blueArcPaint,
    );

    // Progress arc - Yellow part (E-Book)
    final yellowArcPaint = Paint()
      ..color = const Color(0xFFFFC107)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 7.5),
      ((percentage / 100 * 360) - 90) * (3.14159 / 180),
      // Start from where blue ended
      (25 / 100 * 360) * (3.14159 / 180), // 25% of the circle in radians
      false,
      yellowArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
