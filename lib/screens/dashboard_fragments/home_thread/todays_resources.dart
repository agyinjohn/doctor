import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utils/data/resources.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../widgets/latest_resource_card.dart';
import '../../latest_resources.dart';

class TodaysResourcesScreen extends StatefulWidget {
  const TodaysResourcesScreen({super.key});

  @override
  State<TodaysResourcesScreen> createState() => _TodaysResourcesScreenState();
}

class _TodaysResourcesScreenState extends State<TodaysResourcesScreen> {
  bool _isTapped = false;

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
                const Gap(24),
                _buildPageHeading(),
                const Gap(12),
                _buildSearchBar(context),
                const Gap(12),
                const Text(
                  'Featured',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(14),
                SizedBox(
                  height: 200, // Set a fixed height for the GridView
                  child: _buildFeaturedGrid(),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Resources',
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
                                    const LatestResourcesScreen()));
                      },
                      child: const Text(
                        'See More',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(4),
                SizedBox(
                  height: 300,
                  child: _buildLatestResourcesList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Text(
      'Explore today\'s resources',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchBar(context) {
    final TextEditingController searchController = TextEditingController();
    return CustomSearchBar(controller: searchController);
  }

  Widget _buildFeaturedGrid() {
    final List<Map<String, String>> featuredGridData = [
      {
        'title': 'Psychological First Aid',
        'image': 'assets/images/psycho.jpg',
      },
      {
        'title': 'Suicide Helpline',
        'image': 'assets/images/suicide.jpg',
      },
      {
        'title': 'Psychological First Aid',
        'image': 'assets/images/psycho.jpg',
      },
      {
        'title': 'Suicide Helpline',
        'image': 'assets/images/suicide.jpg',
      },
      {
        'title': 'Psychological First Aid',
        'image': 'assets/images/psycho.jpg',
      },
      {
        'title': 'Suicide Helpline',
        'image': 'assets/images/suicide.jpg',
      },
    ];

    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2, // Adjust aspect ratio to match your design
        mainAxisSpacing: 16.0, // Spacing between items
      ),
      itemCount: featuredGridData.length,
      itemBuilder: (context, index) {
        final item = featuredGridData[index];
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(item['image']!),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6.0,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLatestResourcesList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        final resource = latestResources[index];
        return GestureDetector(
          onTap: () {},
          child: LatestResourceCard(
            type: resource['type'],
            title: resource['title'],
            subTitle: resource['subtitle'],
            image: resource['image'],
          ),
        );
      },
    );
  }
}
