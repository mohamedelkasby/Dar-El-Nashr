import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchFilterPage(),
    );
  }
}

class SearchFilterPage extends StatefulWidget {
  @override
  _SearchFilterPageState createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  final List<Map<String, String>> items = [
    {'name': 'Apple', 'category': 'Fruit'},
    {'name': 'Banana', 'category': 'Fruit'},
    {'name': 'Carrot', 'category': 'Vegetable'},
    {'name': 'Broccoli', 'category': 'Vegetable'},
    {'name': 'Chicken', 'category': 'Meat'},
  ];

  String searchQuery = '';
  String selectedCategory = 'All';
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    categories =
        ['All'] + items.map((item) => item['category']!).toSet().toList();
  }

  List<Map<String, String>> get filteredItems {
    return items
        .where((item) =>
            item['name']!.toLowerCase().contains(searchQuery.toLowerCase()) &&
            (selectedCategory == 'All' || item['category'] == selectedCategory))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Dropdown Filter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedCategory,
              items: categories
                  .map((category) => DropdownMenuItem(
                        child: Text(category),
                        value: category,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]['name']!),
                    subtitle: Text(filteredItems[index]['category']!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
