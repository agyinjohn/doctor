import 'package:doctor/utils/healthservicepersonal.dart';
import 'package:doctor/utils/models/usermodel.dart';
import 'package:flutter/material.dart';

// Your UserModel and HealthProfessionalService classes go here

class AddHealthProfessionalPage extends StatefulWidget {
  @override
  _AddHealthProfessionalPageState createState() =>
      _AddHealthProfessionalPageState();
}

class _AddHealthProfessionalPageState extends State<AddHealthProfessionalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _profileUrlController = TextEditingController();
  Role? _selectedRole;

  final HealthProfessionalService _service = HealthProfessionalService();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserModel newUser = UserModel(
          name: _nameController.text,
          email: _emailController.text,
          uid: '',
          profileUrl: _profileUrlController.text,
          speciality: _specialityController.text,
          role: _selectedRole ?? Role.user,
        );

        await _service.addHealthProfessional(newUser);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Health professional added successfully'),
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
                controller: _specialityController,
                decoration: InputDecoration(labelText: 'Speciality'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the speciality';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _profileUrlController,
                decoration: InputDecoration(labelText: 'Profile URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the profile URL';
                  }
                  return null;
                },
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
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
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
