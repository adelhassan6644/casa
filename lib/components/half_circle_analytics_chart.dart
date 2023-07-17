import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class HalfCircleAnalyticsChart extends StatelessWidget {
  const HalfCircleAnalyticsChart(
      this.chartData, {
        Key? key,
        this.innerRadius = "80%",
      }) : super(key: key);
  final List<ChartData> chartData;
  final String innerRadius;
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: const EdgeInsets.all(0),
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          cornerStyle: CornerStyle.bothCurve,
          animationDuration: 800,
          startAngle: 270,
          endAngle: 90,
          innerRadius: innerRadius,
          radius: "100%",

        )
      ],
    );
  }
}


class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}