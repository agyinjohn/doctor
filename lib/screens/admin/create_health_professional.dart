import 'package:doctor/utils/healthservicepersonal.dart';
import 'package:doctor/utils/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddHealthProfessionalPage extends StatefulWidget {
  @override
  _AddHealthProfessionalPageState createState() =>
      _AddHealthProfessionalPageState();
}

class _AddHealthProfessionalPageState extends State<AddHealthProfessionalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profileUrlController = TextEditingController();
  Role? _selectedRole;
  String? _selectedSpeciality;

  final HealthProfessionalService _service = HealthProfessionalService();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserModel newUser = UserModel(
          name: _nameController.text,
          email: _emailController.text,
          uid: '',
          profileUrl: _profileUrlController.text.isEmpty
              ? ''
              : _profileUrlController.text, // Profile URL is optional
          speciality: _selectedRole == Role.admin || _selectedRole == Role.user
              ? ''
              : _selectedSpeciality ?? '',
          role: _selectedRole ?? Role.user,
        );

        await _service.addHealthProfessional(newUser);

        // Send password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Health professional added successfully. A password reset email has been sent.'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add health professional: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Health Professional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _profileUrlController,
                decoration: InputDecoration(labelText: 'Profile URL (optional)'),
                // No validation required for an optional field
              ),
              DropdownButtonFormField<Role>(
                value: _selectedRole,
                decoration: InputDecoration(labelText: 'Role'),
                items: Role.values.map((Role role) {
                  return DropdownMenuItem<Role>(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Role? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                    _selectedSpeciality = null; // Reset speciality when role changes
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
              ),
              if (_selectedRole != Role.admin && _selectedRole != Role.user)
                DropdownButtonFormField<String>(
                  value: _selectedSpeciality,
                  decoration: InputDecoration(labelText: 'Speciality'),
                  items: ['Counselor', 'Doctor', 'Mentor']
                      .map((String speciality) {
                    return DropdownMenuItem<String>(
                      value: speciality,
                      child: Text(speciality),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSpeciality = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null &&
                              _selectedRole != Role.admin &&
                              _selectedRole != Role.user
                          ? 'Please select a speciality'
                          : null,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Health Professional'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
