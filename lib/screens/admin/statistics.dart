import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../app_Colors.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final Color doctorColor = Color(0xff4385f6), // Dark green
    //     doctor_btn_color = Color.fromARGB(255, 1, 50, 135),
    //     mentorColor = Color(0xff32a94f), // Dark blue
    //     mentor_btn_color = Color.fromARGB(255, 0, 89, 22),
    //     counsellorColor = const Color(0xffd41d10), // Dark purple
    //     counsellor_btn_color = Color.fromARGB(255, 119, 9, 1),
    //     adminColors = Color(0xfffcbb07), // Dark purple
    //     admin_btn_colors = Color.fromARGB(255, 144, 106, 1); // Dark purple
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
                      color: Color.fromARGB(255, 37, 37, 37),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.046),
                Container(
                  height: size.height * 0.30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCard(context, 'Total\nDoctors', doctorColor, 47,
                          doctorBtnColor),
                      SizedBox(width: 6),
                      _buildCard(context, 'Total\nMentors', mentorColor, 24,
                          mentorBtnColor),
                      SizedBox(width: 6),
                      _buildCard(context, 'Total\nCounsellors', counsellorColor,
                          38, counsellorBtnColor),
                      SizedBox(width: 6),
                      _buildCard(context, 'Total\nAdministrators', adminColors,
                          5, adminBtnColors)
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
                                child:
                                    Icon(Icons.person_2, color: Colors.white),
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
                                child: Icon(IconlyBroken.profile,
                                    color: Colors.white),
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
                                child: Icon(IconlyBroken.user3,
                                    color: Colors.white),
                              ),
                              Text(
                                'Counsellors',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: adminColors,
                                child: Icon(IconlyBroken.user2,
                                    color: Colors.white),
                              ),
                              Text(
                                'Adminstrators',
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
                  child: _buildBarGraph(
                      doctorColor, mentorColor, counsellorColor, adminColors),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Color color, int number,
      Color btn_color) {
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
            SizedBox(height: 0),
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
                  color: btn_color,
                ),
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

  Widget _buildBarGraph(Color doctorColor, Color mentorColor,
      Color counsellorColor, Color adminColor) {
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
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                );
                switch (value.toInt()) {
                  case 0:
                    return Text('Doc.', style: style);
                  case 1:
                    return Text('Men.', style: style);
                  case 2:
                    return Text('Coun.', style: style);
                  case 3:
                    return Text('Admin.', style: style);

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
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(
              toY: 5, // Value for Counsellors
              color: adminColor,
              width: 22,
            ),
          ]),
        ],
      ),
    );
  }
}
