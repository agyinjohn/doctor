import 'package:doctor/screens/admin/create_health_professional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  String _searchTerm = '';

  final List<String> categories = [
    'Doctors',
    'Mentors',
    'Counsellors',
    'Administrators'
  ];

  final List<List<Map<String, String>>> usersList = [
    [
      {'name': 'Banson Eyram', 'profession': 'Pharmacist'},
      {'name': 'Afram Gyebi Visca', 'profession': 'Pharmacist'},
      {'name': 'John Agyin', 'profession': 'Doctor'},
      {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
    ],
    [
      {'name': 'John Doe', 'profession': 'Mentor'},
      {'name': 'Jane Smith', 'profession': 'Mentor'},
    ],
    [
      {'name': 'Alex Johnson', 'profession': 'Counsellor'},
      {'name': 'Emily Davis', 'profession': 'Counsellor'},
    ],
    [
      {'name': 'Admin One', 'profession': 'Administrator'},
      {'name': 'Admin Two', 'profession': 'Administrator'},
    ],
  ];

  List<Map<String, String>> get filteredUsers {
    final categoryUsers = usersList[_selectedCategoryIndex];
    if (_searchTerm.isEmpty) {
      return categoryUsers;
    }
    return categoryUsers
        .where((user) =>
            user['name']!.toLowerCase().contains(_searchTerm.toLowerCase()) ||
            user['profession']!
                .toLowerCase()
                .contains(_searchTerm.toLowerCase()))
        .toList();
  }

  void _editUser(int index, Map<String, String> user) {
    final nameController = TextEditingController(text: user['name']);
    final professionController =
        TextEditingController(text: user['profession']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: professionController,
                decoration: const InputDecoration(labelText: 'Profession'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  usersList[_selectedCategoryIndex][index] = {
                    'name': nameController.text,
                    'profession': professionController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  usersList[_selectedCategoryIndex].removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.024),
          Text(
            'User Management',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.026),

          // Search bar
          SizedBox(
            height: 55,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                prefixIcon: const Icon(IconlyLight.search),
                hintText: 'Search',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.012),

          // Category Buttons
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                      _searchTerm = '';
                      _searchController.clear();
                    });
                  },
                  child: _buildLabel(
                    context,
                    categories[index],
                    _selectedCategoryIndex == index
                        ? Colors.blue[800]!
                        : const Color.fromARGB(255, 191, 189, 189),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.022),

          // User Details List
          Container(
            height: size.height * 0.50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 16.0,
              ),
              child: filteredUsers.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: filteredUsers.asMap().entries.map(
                          (entry) {
                            int index = entry.key;
                            Map<String, String> user = entry.value;
                            return Column(
                              children: [
                                _buildUserDetail(
                                    user['name']!, user['profession']!, index),
                                const SizedBox(height: 5),
                                const Divider(),
                                const SizedBox(height: 5),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 3),

          // Add Button
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddHealthProfessionalPage())),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 42,
              child: const Center(
                child: Text(
                  'ADD HEALTH PROFESSIONALS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetail(String name, String profession, int index) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 34,
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profession,
              style: TextStyle(
                color: Colors.blue[800],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _editUser(
                      index, {'name': name, 'profession': profession}),
                  child: _buildActionButton('Edit', Colors.blue[800]!),
                ),
                const SizedBox(width: 4),
                _buildActionButton('Active', Colors.green[700]!),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => _deleteUser(index),
                  child: _buildActionButton('Delete', Colors.red[700]!),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
 
//import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// class UserManagementPage extends StatefulWidget {
//   const UserManagementPage({super.key});

//   @override
//   _UserManagementPageState createState() => _UserManagementPageState();
// }

// class _UserManagementPageState extends State<UserManagementPage> {
//   final TextEditingController _searchController = TextEditingController();
//   int _selectedCategoryIndex = 0;
//   String _searchTerm = '';

//   final List<String> categories = [
//     'Doctors',
//     'Mentors',
//     'Counsellors',
//     'Administrators'
//   ];

//   final List<List<Map<String, String>>> usersList = [
//     [
//       {'name': 'Banson Eyram', 'profession': 'Pharmacist'},
//       {'name': 'Afram Gyebi Visca', 'profession': 'Pharmacist'},
//       {'name': 'John Agyin', 'profession': 'Doctor'},
//       {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
//       {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
//       {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
//       {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
//       {'name': 'Jessica Tamonah', 'profession': 'Pharmacist'},
//     ],
//     [
//       {'name': 'John Doe', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//       {'name': 'Jane Smith', 'profession': 'Mentor'},
//     ],
//     [
//       {'name': 'Alex Johnson', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//       {'name': 'Emily Davis', 'profession': 'Counsellor'},
//     ],
//     [
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin One', 'profession': 'Administrator'},
//       {'name': 'Admin Two', 'profession': 'Administrator'},
//     ],
//   ];

//   List<Map<String, String>> get filteredUsers {
//     final categoryUsers = usersList[_selectedCategoryIndex];
//     if (_searchTerm.isEmpty) {
//       return categoryUsers;
//     }
//     return categoryUsers
//         .where((user) =>
//             user['name']!.toLowerCase().contains(_searchTerm.toLowerCase()) ||
//             user['profession']!
//                 .toLowerCase()
//                 .contains(_searchTerm.toLowerCase()))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//       child: Column(
//         children: [
//           SizedBox(height: size.height * 0.024),
//           Text(
//             'User Management',
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: size.height * 0.026),

//           // Search bar
//           SizedBox(
//             height: 55,
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 setState(() {
//                   _searchTerm = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(5),
//                 prefixIcon: Icon(IconlyLight.search),
//                 hintText: 'Search',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(100)),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.012),

//           // Category Buttons
//           SizedBox(
//             height: 42,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedCategoryIndex = index;
//                       _searchTerm = '';
//                       _searchController.clear();
//                     });
//                   },
//                   child: _buildLabel(
//                     context,
//                     categories[index],
//                     _selectedCategoryIndex == index
//                         ? Colors.blue[800]!
//                         : Color.fromARGB(255, 191, 189, 189),
//                   ),
//                 );
//               },
//             ),
//           ),

//           SizedBox(height: size.height * 0.022),

//           // User Details List
//           Container(
//             height: size.height * 0.50,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blue[50],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10.0,
//                 vertical: 16.0,
//               ),
//               child: filteredUsers.isNotEmpty
//                   ? SingleChildScrollView(
//                       child: Column(
//                         children: filteredUsers
//                             .map(
//                               (user) => Column(
//                                 children: [
//                                   _buildUserDetail(
//                                       user['name']!, user['profession']!),
//                                   SizedBox(height: 5),
//                                   Divider(),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     )
//                   : Center(
//                       child: Text(
//                         'No users found',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//           SizedBox(height: 3),

//           // Add Button
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               color: Colors.blue,
//             ),
//             width: double.infinity,
//             height: 42,
//             child: Center(
//               child: Text(
//                 'ADD HEALTH PROFESSIONALS',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLabel(BuildContext context, String text, Color color) {
//     return Container(
//       width: 100,
//       height: 40,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: color,
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserDetail(String name, String profession) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 34,
//           backgroundColor: Colors.white,
//         ),
//         SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: TextStyle(
//                 color: Colors.blue[800],
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               profession,
//               style: TextStyle(
//                 color: Colors.blue[800],
//               ),
//             ),
//             Row(
//               children: [
//                 _buildActionButton('Edit', Colors.blue[800]!),
//                 SizedBox(width: 4),
//                 _buildActionButton('Active', Colors.green[700]!),
//                 SizedBox(width: 4),
//                 _buildActionButton('Delete', Colors.red[900]!),
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget _buildActionButton(String label, Color color) {
//     return Container(
//       width: 70,
//       height: 26,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: color,
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 11,
//           ),
//         ),
//       ),
//     );
//   }
// }
