import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search',
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a keyword to search";
          }
          return null;
        },
      ),
    );
  }
}
