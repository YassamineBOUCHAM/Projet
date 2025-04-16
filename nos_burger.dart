import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// POINT D’ENTRÉE
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burger App',
      debugShowCheckedModeBanner: false,
      home: const BurgerListScreen(),
    );
  }
}

// MODÈLE DE DONNÉES
class Burger {
  final String name;
  final String description;
  final String imageUrl;
  final double rating;

  Burger({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });
}

// ÉCRAN PRINCIPAL : LISTE DES BURGERS
class BurgerListScreen extends StatelessWidget {
  const BurgerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Burger> burgers = [
      Burger(
        name: "Dirty Burger",
        rating: 3.9,
        imageUrl: 'assets/images/dirty.png',
        description:
            "Bun boulanger, bœuf haché façon bouchère, cheddar affiné, salade, frites, sauce moutarde miel-relish, ketchup.",
      ),
      Burger(
        name: "Chicken Burger",
        rating: 3.9,
        imageUrl: 'assets/images/chiken.png',
        description:
            "Poulet pané, cheddar, mayonnaise au poivre, tomate et salade.",
      ),
      Burger(
        name: "Stracciatella Burger",
        rating: 4.6,
        imageUrl: 'assets/images/stracia.png',
        description:
            "Steak haché, stracciatella (coeur de burrata), tomate cerise confite, roquette et pesto.",
      ),
      Burger(
        name: "Fish Burger",
        rating: 4.8,
        imageUrl: 'assets/images/fish.png',
        description:
            "Cabillaud pané, cheddar, tomate, salade et sauce tartare.",
      ),
      Burger(
        name: "Green Fish",
        rating: 4.0,
        imageUrl: 'assets/images/greenf.png',
        description:
            "100% Vegan : Pain Buns, Filet de Poisson Vegan, Cheddar, Pickles, Oignons Rouges, Laitue et Sauce Tartare Vegan.",
      ),
      Burger(
        name: "Freech",
        rating: 4.8,
        imageUrl: 'assets/images/freec.png',
        description:
            "Bœuf haché maison, bun noir, sauce au poivre, notre super sauce aux 3 fromages, salade, tomate, oignons rouges et cornichons.",
      ),
      Burger(
        name: "Double cheese Naan",
        rating: 4.8,
        imageUrl: 'assets/images/doubelnan.png',
        description: "Bun's briochés avec 2 steaks maison 130 g et cheddar",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Burgers'),
        backgroundColor: const Color(0xFFFFDD3C),
      ),
      body: ListView.builder(
        itemCount: burgers.length,
        itemBuilder: (context, index) {
          final burger = burgers[index];
          final isLocal = !burger.imageUrl.startsWith('http');
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BurgerDetailScreen(burger: burger),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: isLocal
                      ? Image.asset(
                          burger.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          burger.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                ),
                title: Text(burger.name),
                subtitle: Text("⭐ ${burger.rating}"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ÉCRAN DE DÉTAIL
class BurgerDetailScreen extends StatelessWidget {
  final Burger burger;

  const BurgerDetailScreen({super.key, required this.burger});

  @override
  Widget build(BuildContext context) {
    final isLocal = !burger.imageUrl.startsWith('http');

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3A5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFDD3C),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  isLocal
                      ? Image.asset(
                          burger.imageUrl,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          burger.imageUrl,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(height: 10),
                  Text(
                    burger.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Icon(Icons.fiber_manual_record,
                      size: 8, color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDD3C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          burger.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Description :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFDD3C),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                burger.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFFFDD3C),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Burger commandé !')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFDD3C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Commander'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}