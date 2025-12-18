import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final authService = AuthService();

  void register() async {
  if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez remplir tous les champs")),
    );
    return;
  }

  final user = User(
    email: emailCtrl.text.trim(),
    password: passCtrl.text.trim(),
  );

  bool success = await authService.register(user);

  if (!mounted) return; // CRITIQUE POUR FLUTTER WEB

  if (success) {
    // SnackBar SÉCURISÉ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Compte créé avec succès. Veuillez vous connecter.",
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Navigation APRÈS SnackBar
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Un compte avec cet email existe déjà"),
        backgroundColor: Colors.red,
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Bouton S'inscrire cliqué"); //
                  register();
                },
                child: Text("S'inscrire"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
