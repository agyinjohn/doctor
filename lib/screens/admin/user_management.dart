import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool _isLoading = false;

  final List<String> categories = ['Doctor', 'Mentor', 'Counsellor', 'Admin'];

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> fetchedUsers =
          await fetchUsersFromFirestore(
              categories[_selectedCategoryIndex].toLowerCase());

      setState(() {
        _users = fetchedUsers;
      });
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsersFromFirestore(
      String role) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    final users = querySnapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'profession': doc['speciality'],
      };
    }).toList();

    return users;
  }

  List<Map<String, dynamic>> get filteredUsers {
    if (_searchTerm.isEmpty) {
      return _users;
    }
    return _users
        .where((user) =>
            user['name']!.toLowerCase().contains(_searchTerm.toLowerCase()) ||
            user['profession']!
                .toLowerCase()
                .contains(_searchTerm.toLowerCase()))
        .toList();
  }

  void _editUser(int index, Map<String, String> user) {
    // Implement your _editUser logic
  }

  void _deleteUser(int index) {
    // Implement your _deleteUser logic
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
                    _fetchUsers(); // Fetch users when category changes
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredUsers.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: filteredUsers.asMap().entries.map(
                              (entry) {
                                int index = entry.key;
                                Map<String, dynamic> user = entry.value;
                                return Column(
                                  children: [
                                    _buildUserDetail(user['name']!,
                                        user['profession']!, index),
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
          // const SizedBox(height: 40),

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
