// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'room.dart';

class RecommendedRooms extends StatefulWidget {
  const RecommendedRooms({super.key});

  @override
  State<RecommendedRooms> createState() => _RecommendedRoomsState();
}

class _RecommendedRoomsState extends State<RecommendedRooms> {
  bool _isTapped = false;
  bool _showMoreRooms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _isTapped = true;
                    });
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: _isTapped ? Colors.blue : Colors.black,
                  ),
                ),
                const Gap(32),
                _buildPageTitle(context, 'Recommended Rooms'),
                const Gap(12),
                _buildRecommendedRooms(),
                if (_showMoreRooms)
                  _buildAdditionalRooms(), // Conditionally show additional rooms
                _buildToggleRoomsButton(),
                const Gap(30),
                _buildPageTitle(context, 'Listeners'),
                const Gap(12),
                _buildListeners(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //////////

  Widget _buildPageTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecommendedRooms() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Room(
                          title: 'To Be Happy',
                        )));
          },
          child: const RecommendedRoom(
            users: [
              'assets/images/doctor_3.jpg',
              'assets/images/doctor_4.jpg',
            ],
            title: 'To Be Happy',
            count: '91+',
          ),
        ),
        const Gap(4),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Room(
                          title: 'Anxiety Stage',
                        )));
          },
          child: const RecommendedRoom(
            users: [
              'assets/images/doctor_4.jpg',
              'assets/images/doctor_3.jpg',
            ],
            title: 'The Anxiety Stage',
            count: '74+',
          ),
        ),
        const Gap(4),
        // Card(
        //   color: Colors.blue[800],
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   child: const Padding(
        //     padding: EdgeInsets.symmetric(vertical: 8.0),
        //     child: Center(
        //       child: Icon(
        //         Icons.keyboard_double_arrow_down_sharp,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildAdditionalRooms() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Room(
                          title: 'Academic Tutors',
                        )));
          },
          child: const RecommendedRoom(
            users: [
              'assets/images/doctor_3.jpg',
              'assets/images/doctor_4.jpg',
            ],
            title: 'Academic Tutors',
            count: '45+',
          ),
        ),
        const Gap(4),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Room(
                          title: 'Health Issues',
                        )));
          },
          child: const RecommendedRoom(
            users: [
              'assets/images/doctor_4.jpg',
              'assets/images/doctor_3.jpg',
            ],
            title: 'Health Issues',
            count: '30+',
          ),
        ),
        const Gap(4),
      ],
    );
  }

  Widget _buildToggleRoomsButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showMoreRooms = !_showMoreRooms;
        });
      },
      child: Card(
        color: Colors.blue[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Icon(
              _showMoreRooms
                  ? Icons.keyboard_double_arrow_up_sharp
                  : Icons.keyboard_double_arrow_down_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListeners() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.blue[50]),
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Listener(
                  imageUrl: 'assets/images/counselor_1.jpeg',
                  name: 'Runo',
                ),
                Listener(
                  imageUrl: 'assets/images/joseph.png',
                  name: 'Damilola',
                ),
                Listener(
                  imageUrl: 'assets/images/visca.jpg',
                  name: 'Ben',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Listener(
                  imageUrl: 'assets/images/imran.png',
                  name: 'Faridat',
                ),
                Listener(
                  imageUrl: 'assets/images/george.jpg',
                  name: 'Oluwa',
                ),
                Listener(
                  imageUrl: 'assets/images/bessie.png',
                  name: 'Goddy',
                )
              ],
            )
          ],
        )));
  }
}

class Listener extends StatelessWidget {
  final String imageUrl;
  final String name;
  const Listener({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(imageUrl),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(2),
          Text(name),
        ],
      ),
    );
  }
}

class RecommendedRoom extends StatelessWidget {
  final List<String> users;
  final String title;
  final String count;

  const RecommendedRoom({
    super.key,
    required this.users,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: SizedBox(
            height: 40,
            width: 80,
            child: Stack(
              children: List.generate(3, (index) {
                return Positioned(
                  left: index * 20.0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        index == 2 ? null : AssetImage(users[index]),
                    child: index == 2
                        ? Text(
                            count,
                            style: TextStyle(
                                fontSize: 12, color: Colors.blue[800]),
                          )
                        : null,
                  ),
                );
              }),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: const Icon(Icons.logout_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
