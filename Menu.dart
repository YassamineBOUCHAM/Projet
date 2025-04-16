import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MenuScreen(),
  ));
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  DateTime _selectedDate = DateTime.now();

  String _getFormattedDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  List<Widget> _buildDaysOfMonth() {
    DateTime firstDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
    int daysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    return List.generate(daysInMonth, (index) {
      final day = index + 1;
      final isToday = day == DateTime.now().day &&
          _selectedDate.month == DateTime.now().month &&
          _selectedDate.year == DateTime.now().year;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate =
                DateTime(_selectedDate.year, _selectedDate.month, day);
          });
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isToday ? Colors.amber : Colors.yellow.shade100,
            borderRadius: BorderRadius.circular(10),
            border: _selectedDate.day == day
                ? Border.all(color: Colors.orange, width: 2)
                : null,
          ),
          child: Text(
            '$day',
            style: TextStyle(
              color: isToday ? Colors.white : Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.yellow.shade700,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Recherche',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategory('Entrées',
                      'https://images.unsplash.com/photo-1604908812011-731b25a0c07f'),
                  _buildCategory('Plats',
                      'https://images.unsplash.com/photo-1550547660-d9450f859349'),
                  _buildCategory('Desserts',
                      'https://images.unsplash.com/photo-1589302168068-964664d93dc0'),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Aujourd’hui : ${_getFormattedDate(DateTime.now())}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sélectionné : ${_getFormattedDate(_selectedDate)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Wrap(
                  children: _buildDaysOfMonth(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title, String imageUrl) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
