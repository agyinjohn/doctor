import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  Future<int> _getUserCountByRole(String role) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();
    return querySnapshot.size;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                FutureBuilder(
                  future: Future.wait([
                    _getUserCountByRole('doctor'),
                    _getUserCountByRole('mentor'),
                    _getUserCountByRole('counsellor'),
                    _getUserCountByRole('admin')
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    List<int> counts = snapshot.data as List<int>;
                    int doctorCount = counts[0];
                    int mentorCount = counts[1];
                    int counsellorCount = counts[2];
                    int adminCount = counts[3];

                    return Column(
                      children: [
                        Container(
                          height: size.height * 0.30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildCard(context, 'Total\nDoctors', doctorColor,
                                  doctorCount, doctorBtnColor),
                              SizedBox(width: 6),
                              _buildCard(context, 'Total\nMentors', mentorColor,
                                  mentorCount, mentorBtnColor),
                              SizedBox(width: 6),
                              _buildCard(
                                  context,
                                  'Total\nCounsellors',
                                  counsellorColor,
                                  counsellorCount,
                                  counsellorBtnColor),
                              SizedBox(width: 6),
                              _buildCard(context, 'Total\nAdministrators',
                                  adminColors, adminCount, adminBtnColors)
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        _buildCircleAvatars(doctorCount, mentorCount,
                            counsellorCount, adminCount),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          height: size.height * 0.22,
                          child: _buildBarGraph(
                            doctorColor,
                            mentorColor,
                            counsellorColor,
                            adminColors,
                            doctorCount,
                            mentorCount,
                            counsellorCount,
                            adminCount,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Color color, int number,
      Color btnColor) {
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
                  color: btnColor,
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

  Widget _buildCircleAvatars(
      int doctorCount, int mentorCount, int counsellorCount, int adminCount) {
    return Container(
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
              _buildCircleAvatar(doctorColor, 'Doctors',
                  Icon(Icons.person_2, color: Colors.white)),
              _buildCircleAvatar(mentorColor, 'Mentors',
                  Icon(IconlyBroken.profile, color: Colors.white)),
              _buildCircleAvatar(counsellorColor, 'Counsellors',
                  Icon(IconlyBroken.user3, color: Colors.white)),
              _buildCircleAvatar(adminColors, 'Adminstrators',
                  Icon(IconlyBroken.user2, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(Color backgroundColor, String label, Icon icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: backgroundColor,
          child: icon,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildBarGraph(
      Color doctorColor,
      Color mentorColor,
      Color counsellorColor,
      Color adminColor,
      int doctorCount,
      int mentorCount,
      int counsellorCount,
      int adminCount) {
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
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
              toY: doctorCount.toDouble(), // Value for Doctors
              color: doctorColor,
              width: 22,
            ),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              toY: mentorCount.toDouble(), // Value for Mentors
              color: mentorColor,
              width: 22,
            ),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
              toY: counsellorCount.toDouble(), // Value for Counsellors
              color: counsellorColor,
              width: 22,
            ),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(
              toY: adminCount.toDouble(), // Value for Administrators
              color: adminColor,
              width: 22,
            ),
          ]),
        ],
      ),
    );
  }
}
