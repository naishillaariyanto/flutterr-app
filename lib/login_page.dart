import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nama = TextEditingController();

  void lanjut() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            nama: nama.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    nama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Smart Class Reminder",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Masukkan nama kamu untuk memulai",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  TextFormField(
                    controller: nama,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Nama wajib diisi" : null,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: lanjut,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 54, 205, 255),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("LANJUT!"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}