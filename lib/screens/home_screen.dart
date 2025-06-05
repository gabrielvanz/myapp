import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/product_card.dart';
import '../widgets/popular_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> dataMostPopular = [];
  List<Map<String, dynamic>> dataItems = [];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://8jcox47hg2.execute-api.us-east-2.amazonaws.com/dev/'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final data = responseData['body']['data'];
        
        setState(() {
          dataMostPopular = List<Map<String, dynamic>>.from(data['mostPopular']);
          dataItems = List<Map<String, dynamic>>.from(data['items']);
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, John',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Most popular',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_image.png'),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dataMostPopular.length,
                itemBuilder: (context, index) {
                  final item = dataMostPopular[index];
                  return PopularCard(
                    product: item,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: item,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildCategoryButton('All'),
                  const SizedBox(width: 8),
                  _buildCategoryButton('Indoor'),
                  const SizedBox(width: 8),
                  _buildCategoryButton('Outdoor'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final filteredItems = dataItems.where((item) =>
                    selectedCategory == 'All' || item['category'] == selectedCategory
                  ).toList();
                  
                  if (index >= filteredItems.length) return null;
                  
                  return ProductCard(
                    product: filteredItems[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    final isSelected = selectedCategory == category;
    return ElevatedButton(
      onPressed: () => setState(() => selectedCategory = category),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 0,
        side: BorderSide(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(category),
    );
  }
} 