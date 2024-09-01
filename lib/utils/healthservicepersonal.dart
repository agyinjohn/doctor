import 'package:doctor/utils/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'dart:math';

class HealthProfessionalService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to auto-generate a password
  String _generatePassword({int length = 12}) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';
    Random random = Random.secure();
    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join('');
  }

  // Method to add a health professional
  Future<void> addHealthProfessional(UserModel user) async {
    try {
      // Generate a random password
      String password = _generatePassword();

      // Create the user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Update the UID in the user model
      user = UserModel(
        name: user.name,
        email: user.email,
        uid: userCredential.user!.uid,
        profileUrl: user.profileUrl,
        speciality: user.speciality,
        role: user.role,
      );

      // Save the user data to Firestore
      await _firestore.collection('users').doc(user.uid).set(user.toMap());

      // Send the password via EmailJS
      // await _sendPasswordEmail(user.email, password);
      await _auth.sendPasswordResetEmail(email: user.email);
      
    } catch (e) {
      // Handle errors (e.g., email already in use, network issues)
      print('Error adding health professional: $e');
      throw e;
    }
  }

  // Method to send the generated password via EmailJS
  Future<void> _sendPasswordEmail(String email, String password) async {
    try {
      var publicKey =
          'bsZQwCp82Z5gQ9NkU'; // Replace with your actual public key
      var serviceId = 'service_gy0qanm';
      var templateId = 'template_4t6apfx';

      var templateParams = {
        'to_email': email,
        'password': password,
      };

      await emailjs.send(
          serviceId,
          templateId,
          templateParams,
          emailjs.Options(
              publicKey: publicKey,
              privateKey: 'A8LkFi2CgUOccFJkD6Tz_',
              limitRate: const emailjs.LimitRate(
                id: 'app',
                throttle: 10000,
              )));
    } catch (e) {
      print('Error sending email: $e');
      throw e;
    }
  }
}
