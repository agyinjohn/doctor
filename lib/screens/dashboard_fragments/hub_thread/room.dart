import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class Room extends StatefulWidget {
  final String title;

  const Room({super.key, required this.title});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
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
              const Gap(20),
              _buildPageTitle(context, widget.title),
              const Gap(8),
              _buildListeners(),
              const Gap(10),
              _buildButton1(),
              const Gap(10),
              _buildButton2(),
            ],
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
          fontSize: 26,
          fontWeight: FontWeight.bold,
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
                  isMuted: false,
                ),
                Listener(
                  imageUrl: 'assets/images/joseph.png',
                  name: 'Damilola',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/visca.jpg',
                  name: 'Ben',
                  isMuted: true,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Listener(
                  imageUrl: 'assets/images/imran.png',
                  name: 'Faridat',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/george.jpg',
                  name: 'Oluwa',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/bessie.png',
                  name: 'Goddy',
                  isMuted: true,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Listener(
                  imageUrl: 'assets/images/imran.png',
                  name: 'Faridat',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/george.jpg',
                  name: 'Oluwa',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/bessie.png',
                  name: 'Goddy',
                  isMuted: true,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Listener(
                  imageUrl: 'assets/images/imran.png',
                  name: 'Faridat',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/george.jpg',
                  name: 'Oluwa',
                  isMuted: true,
                ),
                Listener(
                  imageUrl: 'assets/images/bessie.png',
                  name: 'Goddy',
                  isMuted: true,
                )
              ],
            ),
          ],
        )));
  }

  Widget _buildButton1() {
    // bool muteUser = true;

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.blue])),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Leave Room"),
                content: const Text("Are you sure you want to leave the room?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                        ..pop() // Close the dialog
                        ..pop(); // Navigate back to the previous screen
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            fixedSize: const Size(395, 55)),
        child: Row(
          children: [
            const Icon(Icons.logout_outlined, color: Colors.white),
            const Gap(8),
            const Text(
              'Leave Room',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                icon: Icon(Icons.mic, color: Colors.white), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildButton2() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              // elevation: 3,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              fixedSize: const Size(395, 55)),
          child: const Center(
            child: Text(
              'Invite Someone',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          )),
    );
  }
}

class Listener extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isMuted;

  const Listener(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.isMuted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              isMuted
                  ? CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(imageUrl),
                    )
                  : CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.lightGreen,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(imageUrl),
                      ),
                    ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: isMuted
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: isMuted
                                ? const Icon(
                                    Icons.mic_off_outlined,
                                    color: Colors.red,
                                    size: 14,
                                  )
                                : const Icon(
                                    Icons.mic_outlined,
                                    color: Colors.green,
                                    size: 14,
                                  ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: isMuted
                                ? const Icon(
                                    Icons.mic_off_outlined,
                                    color: Colors.red,
                                    size: 14,
                                  )
                                : const Icon(
                                    Icons.mic_outlined,
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
  final List<String> avatars;
  final String title;
  final String count;

  const RecommendedRoom({
    super.key,
    required this.avatars,
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
                        index == 2 ? null : AssetImage(avatars[index]),
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
