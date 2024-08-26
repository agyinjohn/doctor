import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color doctorColor = const Color(0xFF0A5D32), // Dark green
        mentorColor = const Color(0xFF0A3E77), // Dark blue
        counsellorColor = const Color(0xFF4B0082); // Dark purple
    final TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.024),
          Center(
            child: Column(
              children: [
                Text(
                  'User Management',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.026),

                //Search bar
                // SizedBox(height: size.height * 0.034),
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      prefixIcon: Icon(IconlyLight.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    // maxLines: 1,
                  ),
                ),
                SizedBox(height: size.height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLabel(context, 'Doctors', doctorColor),
                    _buildLabel(context, 'Counsellors', counsellorColor),
                    _buildLabel(context, 'Mentors', mentorColor),
                  ],
                ),

                SizedBox(height: size.height * 0.022),
                Container(
                  height: size.height * 0.52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildUserDetail('Banson Eyram', 'Pharmacist'),
                          SizedBox(height: 5),
                          Divider(),
                          SizedBox(height: 5),
                          _buildUserDetail('Afram Gyebi Visca', 'Pharmacist'),
                          SizedBox(height: 5),
                          Divider(),
                          _buildUserDetail('John Agyin', 'Doctors'),
                          SizedBox(height: 5),
                          Divider(),
                          _buildUserDetail('Jessica Tamonah', 'Pharmacist'),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue,
                  ),
                  width: double.infinity,
                  height: 42,
                  child: Center(
                    child: Text(
                      'ADD HEALTH PROFESSIONALS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // child:
                  // ElevatedButton(
                  //   style: ButtonStyle(

                  //     backgroundColor: WidgetStateProperty.all(
                  //         Colors.blue), // Set the background color to blue
                  //   ),
                  //   onPressed: () {
                  //     // Add your onPressed logic here
                  //   },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text, Color color) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetail(String name, String profession) {
    return Row(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              profession,
              style: TextStyle(
                color: Colors.blue[800],
                // fontSize: 22,
                // fontWeight: FontWeight.bold
              ),
            ),
            Row(
              children: [
                Container(
                  width: 70,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  width: 70,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.green[700],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Active',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  width: 70,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.red[900],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
