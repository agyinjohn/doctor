import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color doctorColor = const Color(0xFF0A5D32), // Dark green
        mentorColor = const Color(0xFF0A3E77), // Dark blue
        counsellorColor = const Color(0xFF4B0082); // Dark purple
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.024),
          Center(
            child: Column(
              children: [
                Text(
                  'Statistics',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.046),
                Container(
                  height: size.height * 0.30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCard(context, 'Total\nDoctors', doctorColor, 47),
                      SizedBox(width: 6),
                      _buildCard(context, 'Total\nMentors', mentorColor, 24),
                      SizedBox(width: 6),
                      _buildCard(
                          context, 'Total\nCounsellors', counsellorColor, 38),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  height: 82,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: doctorColor,
                              ),
                              Text(
                                'Doctors',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: mentorColor,
                              ),
                              Text(
                                'Mentors',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: counsellorColor,
                              ),
                              Text(
                                'Counsellors',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  height:
                      size.height * 0.22, // Adjust the height of the bar graph
                  child:
                      _buildBarGraph(doctorColor, mentorColor, counsellorColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, Color color, int number) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                    fontSize: 68,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
            Center(
              child: Text(
                'registered',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.purple),
                height: 22,
                width: 100,
                child: Center(
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarGraph(
      Color doctorColor, Color mentorColor, Color counsellorColor) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 50, // Adjust maxY according to your needs
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                switch (value.toInt()) {
                  case 0:
                    return Text('Doc.', style: style);
                  case 1:
                    return Text('Men.', style: style);
                  case 2:
                    return Text('Coun.', style: style);

                  default:
                    return Text('', style: style);
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: false), // Hide left titles (y-axis labels)
          ),
        ),
        gridData: FlGridData(show: false), // Hide grid lines
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
              toY: 47, // Value for Doctors
              color: doctorColor,
              width: 22,
            ),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              toY: 24, // Value for Mentors
              color: mentorColor,
              width: 22,
            ),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
              toY: 38, // Value for Counsellors
              color: counsellorColor,
              width: 22,
            ),
          ]),
        ],
      ),
    );
  }
}
