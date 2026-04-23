import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 207),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔲 2 BOX SILANG
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boxSilang(),
                boxSilang(),
              ],
            ),

            const SizedBox(height: 20),

            // 🟧 3 BOX KECIL + TEXT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [
                    boxKecil(),
                    const SizedBox(height: 8),
                    const Text("Menu 1"),
                  ],
                ),

                Column(
                  children: [
                    boxKecil(),
                    const SizedBox(height: 8),
                    const Text("Menu 2"),
                  ],
                ),

                Column(
                  children: [
                    boxKecil(),
                    const SizedBox(height: 8),
                    const Text("Menu 3"),
                  ],
                ),

              ],
            ),

            const SizedBox(height: 20),

            // 📝 TEKS BAWAH

            const SizedBox(height: 8),

            const Text("Ini adalah deskripsi singkat dari widget."),
            const Text("Menjelaskan keunggulan dari fitur tersebut sesuai dengan pilihan widget."),

          ],
        ),
      ),
    );
  }

  // 🔲 BOX SILANG (pakai placeholder)
  Widget boxSilang() {
    return Container(
      width: 140,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: const Placeholder(),
    );
  }

  // 🟧 BOX KECIL
  Widget boxKecil() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
    );
  }
}