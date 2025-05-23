import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Partie supérieure (fond jaune pâle)
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF9C4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Partie inférieure (fond jaune vif + champs)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFEB3B), Color(0xFFFFFF8D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  _buildTextField('Nom d’utilisateur'),
                  const SizedBox(height: 16),
                  _buildTextField('Entrer votre email'),
                  const SizedBox(height: 16),
                  _buildTextField('Mot de passe', obscureText: true),
                  const SizedBox(height: 16),
                  _buildTextField('Confirmer mot de passe', obscureText: true),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Action du bouton
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF9C4),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'sign in',
                      style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFF9C4),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
          letterSpacing: 1,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
