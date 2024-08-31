// import 'package:doctor/screens/dashboard_fragments/home_fragment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/data/doctors_list.dart';
// import '../../../utils/models/doctor_model.dart';

import 'package:doctor/widgets/custom_searchbar.dart';

import '../../../utils/data/get_professionals.dart';
import '../../../utils/models/doctor_model.dart';
import '../../../widgets/counselling_professionals_card.dart';
import '../../chat_screen.dart';
import 'all_professionals_screen.dart';

class ConnectToTherapistPage extends StatefulWidget {
  const ConnectToTherapistPage({super.key});

  @override
  State<ConnectToTherapistPage> createState() => _ConnectToTherapistPageState();
}

class _ConnectToTherapistPageState extends State<ConnectToTherapistPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> userDetails = {};
  bool isLoading = true;
  late List<Map<String, dynamic>> specialUsers;
  @override
  void initState() {
    super.initState();
    getUserDetails();
    getSpecialUsers();
  }

  void getSpecialUsers() async {
    UserRepository userRepository = UserRepository();

    specialUsers = await userRepository.fetchSpecialtyUsers();
    setState(() {});
    specialUsers.forEach((user) {
      print('User: ${user['name']}, Specialty: ${user['speciality']}');
    });
  }

  getUserDetails() async {
    try {
      DocumentSnapshot doc = await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data);
      setState(() {
        userDetails = data;
        isLoading = false;
      });
      print(userDetails);
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _isTapped = false;
  int selectedIndex = 0; // Initializing selectedIndex to 0

  // Define a map from category index to a list of related specialties
  final Map<int, List<String>> categorySpecialties = {
    0: ['Counselor', 'Psychotherapist'], // Counseling
    1: ['Cognitive Behavioral Therapist'], // Behavioral
    2: ['Psychotic'], // Psychotic
  };

  void onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<DoctorModel> getFilteredDoctors() {
    List<String> selectedSpecialties = categorySpecialties[selectedIndex] ?? [];
    return doctors
        .where((doctor) => selectedSpecialties.contains(doctor.specialty))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardPage()));
                        setState(() {
                          _isTapped = true;
                        });
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: _isTapped ? Colors.blue : Colors.black,
                      ),
                    ),
                    const Gap(24),
                    _buildPageHeading(),
                    const Gap(12),
                    _buildSearchBar(context),
                    const Gap(16),
                    const Text(
                      'Categories',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(14),
                    _buildCategories(),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Professionals',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllProfessionalsScreen()));
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    doctor: DoctorModel(
                                        name: specialUsers[index]['name'],
                                        id: specialUsers[index]['uid'],
                                        specialty: specialUsers[index]
                                            ['speciality'],
                                        imageUrl:
                                            'assets/images/counselor_1.jpeg')),
                              ),
                            );
                          },
                          child: CounsellingProfessionalsCard(
                              doctor: DoctorModel(
                                  name: specialUsers[index]['name'],
                                  id: specialUsers[index]['uid'],
                                  specialty: specialUsers[index]['speciality'],
                                  imageUrl: 'assets/images/counselor_1.jpeg')),
                        ),
                        itemCount: 4,
                      ),
                    ),
                    Expanded(
                      child:
                          _buildTopProfessionalsList(), // List of professionals
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildPageHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, ${userDetails['name']}',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Look for doctors and therapists very easily',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(context) {
    final TextEditingController searchController = TextEditingController();
    return CustomSearchBar(controller: searchController);
  }

  Widget _buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CategoryItem(
          image: 'assets/images/counseling.jpg',
          title: 'Counselling',
          isSelected: selectedIndex == 0,
          onTap: () => onCategorySelected(0),
        ),
        CategoryItem(
          image: 'assets/images/behaviorial.jpg',
          title: 'Behavioral',
          isSelected: selectedIndex == 1,
          onTap: () => onCategorySelected(1),
        ),
        CategoryItem(
          image: 'assets/images/psychotic.jpg',
          title: 'Psychotic',
          isSelected: selectedIndex == 2,
          onTap: () => onCategorySelected(2),
        ),
      ],
    );
  }

  Widget _buildTopProfessionalsList() {
    List<DoctorModel> filteredDoctors = getFilteredDoctors();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(doctor: filteredDoctors[index]),
              ),
            );
          },
          child: CounsellingProfessionalsCard(
            doctor: filteredDoctors[index],
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : const Color.fromARGB(255, 202, 214, 240),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  image,
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: isSelected ? Colors.white : Colors.blue,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
