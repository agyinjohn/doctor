import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Text(
              'John Agyin',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Administrator',
              style: TextStyle(
                fontSize: 12,
              ),
            ),

            //Search bar
            SizedBox(height: size.height * 0.034),
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
            SizedBox(height: size.height * 0.034),
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff4894FE), width: 2.6),
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage\nProfessionals',
                      style: TextStyle(
                          color: Color(0xff4894FE),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'and administrators with ease',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff4894FE),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
