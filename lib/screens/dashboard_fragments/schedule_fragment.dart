import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduleFragment extends StatefulWidget {
  const ScheduleFragment({super.key});

  @override
  State<ScheduleFragment> createState() => _ScheduleFragmentState();
}

class _ScheduleFragmentState extends State<ScheduleFragment> {
  String statusActive = 'Upcoming Schedule';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(64),
        buildListStatus(),
        const Gap(20),
        Expanded(
          child: buildListDoctor(),
        ),
      ],
    );
  }

  ListView buildListDoctor() {
    final listDoctor = [
      {
        'image': 'assets/images/joseph.png',
        'name': 'Dr. Joseph Brostito',
        'specialist': 'Dental Specialist',
        'date': DateTime(2024, 06, 12),
        'range': '11:00 - 12:00 AM',
      },
      {
        'image': 'assets/images/bessie.png',
        'name': 'Dr. Bessie Coleman',
        'specialist': 'Dental Specialist',
        'date': DateTime(2024, 06, 12),
        'range': '11:00 - 12:00 AM',
      },
      {
        'image': 'assets/images/babe.png',
        'name': 'Dr. Babe Didrikson',
        'specialist': 'Dental Specialist',
        'date': DateTime(2024, 07, 20),
        'range': '09:00 - 10:00 AM',
      },
    ];
    return ListView.builder(
      itemCount: listDoctor.length,
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        Map item = listDoctor[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          margin: EdgeInsets.fromLTRB(
            24,
            index == 0 ? 0 : 8,
            24,
            index == listDoctor.length - 1 ? 24 : 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(2, 12),
                color: const Color(0xff5A75A7).withOpacity(0.1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      item['image'],
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xff0D1B34),
                            height: 1,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          item['specialist'],
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: const Color(0xff8696BB),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const Divider(
                color: Color(0xffF5F5F5),
                height: 1,
                thickness: 1,
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/images/ic_calendar.png',
                          ),
                          size: 16,
                          color: Color(0xff8696BB),
                        ),
                        const Gap(8),
                        Text(
                          DateFormat('EEEE, d MMMM').format(item['date']),
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: const Color(0xff8696BB),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            'assets/images/ic_clock.png',
                          ),
                          size: 16,
                          color: Color(0xff8696BB),
                        ),
                        const Gap(8),
                        Text(
                          item['range'],
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: const Color(0xff8696BB),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      const Color(0xff63B4FF).withOpacity(0.1),
                    ),
                  ),
                  child: Text(
                    'Detail',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xff4894FE),
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildListStatus() {
    final list = [
      'Canceled Schedule',
      'Upcoming Schedule',
      'Completed Schedule',
    ];

    return Container(
      height: 50,
      child: PageView.builder(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.5, // Adjust the viewportFraction for closer items
        ),
        onPageChanged: (currentIndex) {
          setState(() {
            statusActive = list[currentIndex];
          });
        },
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          bool isActive = statusActive == list[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4), // Adjusted padding
            child: Container(
              decoration: BoxDecoration(
                color:
                    isActive ? const Color(0xff63B4FF).withOpacity(0.1) : null,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(isActive ? 0xff4894FE : 0xff8696BB),
                  height: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
