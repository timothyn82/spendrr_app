import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/expense_controller.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final ExpenseController controller = Get.find<ExpenseController>();

  final List<Color> chartColors = [
    Color(0xFF2E5EAA),
    Color(0xFFE74C3C),
    Color(0xFF27AE60),
    Color(0xFFF39C12),
    Color(0xFF9B59B6),
    Color(0xFF1ABC9C),
    Color(0xFFE67E22),
    Color(0xFF3498DB),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        Map<String, double> totals = controller.categoryTotals;
        double totalExp = controller.totalExpenses.value;
        double savingsRate = controller.savingsRate;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analytics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your spending breakdown',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Savings rate card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Savings Rate',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: textDark),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: incomeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${savingsRate.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                  color: incomeColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: savingsRate.clamp(0, 100) / 100,
                          backgroundColor: Colors.grey.shade100,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(incomeColor),
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        savingsRate >= 20
                            ? '🎉 Great job saving!'
                            : savingsRate >= 0
                                ? '📊 Keep tracking your expenses'
                                : '⚠️ Spending exceeds income',
                        style:
                            TextStyle(fontSize: 12, color: subtitleColor),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Pie chart (custom painter)
              totals.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.pie_chart_outline,
                                size: 60, color: Colors.grey.shade300),
                            const SizedBox(height: 12),
                            Text('No expense data yet',
                                style: TextStyle(color: subtitleColor)),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pie chart
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Expenses by Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: textDark),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 200,
                                  child: CustomPaint(
                                    painter: PieChartPainter(
                                      data: totals,
                                      colors: chartColors,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Legend
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 8,
                                  children: totals.keys.toList().asMap().entries.map((entry) {
                                    int i = entry.key;
                                    String cat = entry.value;
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: chartColors[i % chartColors.length],
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(cat,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: subtitleColor)),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Category breakdown with progress bars
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Category Breakdown',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: textDark),
                                ),
                                const SizedBox(height: 16),
                                ...totals.entries.toList().asMap().entries.map((entry) {
                                  int i = entry.key;
                                  String cat = entry.value.key;
                                  double amt = entry.value.value;
                                  double pct = totalExp == 0 ? 0 : amt / totalExp;
                                  Color color = chartColors[i % chartColors.length];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cat,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: textDark)),
                                            Text(
                                              'KES ${amt.toStringAsFixed(2)} (${(pct * 100).toStringAsFixed(1)}%)',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: subtitleColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: LinearProgressIndicator(
                                            value: pct,
                                            backgroundColor: Colors.grey.shade100,
                                            valueColor: AlwaysStoppedAnimation<Color>(color),
                                            minHeight: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 80),
            ],
          ),
        );
      }),
    );
  }
}

// ── Custom Pie Chart Painter ────────────────────────────────────────────────
class PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final List<Color> colors;

  PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.values.fold(0, (a, b) => a + b);
    double startAngle = -3.14159 / 2;
    double cx = size.width / 2;
    double cy = size.height / 2;
    double radius = size.height / 2 - 10;

    int i = 0;
    for (var entry in data.entries) {
      double sweep = (entry.value / total) * 2 * 3.14159;
      Paint paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        startAngle,
        sweep,
        true,
        paint,
      );

      // White divider
      Paint divider = Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        startAngle,
        sweep,
        true,
        divider,
      );

      startAngle += sweep;
      i++;
    }

    // Center hole
    Paint hole = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), radius * 0.52, hole);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}