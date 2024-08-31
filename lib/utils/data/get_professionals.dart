import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch users and filter by specialty
  Future<List<Map<String, dynamic>>> fetchSpecialtyUsers() async {
    try {
      // Query the Firestore collection for all users
      QuerySnapshot snapshot = await _firestore.collection('users').get();

      // Filter users that do not have 'user' or 'admin' as their specialty
      List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).where((user) {
        return user['speciality'] != 'user' && user['speciality'] != 'admin';
      }).toList();

      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
