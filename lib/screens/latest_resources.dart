import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/data/resources.dart';
import '../widgets/custom_searchbar.dart';
import '../widgets/latest_resource_card.dart';

class LatestResourcesScreen extends StatefulWidget {
  const LatestResourcesScreen({super.key});

  @override
  State<LatestResourcesScreen> createState() => _TodaysResourcesScreenState();
}

class _TodaysResourcesScreenState extends State<LatestResourcesScreen> {
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
              const Gap(18),
              _buildPageHeading(),
              const Gap(12),
              _buildSearchBar(context),
              const Gap(12),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: latestResources.length,
                  itemBuilder: (context, index) {
                    final resource = latestResources[index];
                    return GestureDetector(
                      onTap: () {
                        // Add your onTap functionality here
                      },
                      child: LatestResourceCard(
                        type: resource['type'],
                        title: resource['title'],
                        subTitle: resource['subtitle'],
                        image: resource['image'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Text(
      'Latest Resources',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchBar(context) {
    final TextEditingController searchController = TextEditingController();
    return CustomSearchBar(controller: searchController);
  }
}
