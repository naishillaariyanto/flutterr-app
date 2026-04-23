import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nimCtrl = TextEditingController();

  void masuk() {
    if (nimCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("NIM wajib diisi")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void autoLogin(String value) {
    // 👉 ubah sesuai panjang NIM kamu
    if (value.length >= 10) {
      masuk();
    }
  }

  @override
  void dispose() {
    nimCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Login Mahasiswa",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 INPUT NIM
            TextField(
              controller: nimCtrl,
              keyboardType: TextInputType.number,
              onChanged: autoLogin, // 🔥 AUTO LOGIN
              decoration: const InputDecoration(
                labelText: 'NIM',
                hintText: 'Masukkan NIM',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 BUTTON LOGIN (TETAP ADA)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: masuk,
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}