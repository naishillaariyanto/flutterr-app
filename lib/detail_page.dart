import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 244, 255),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 232, 255),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Smart Class Reminder",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.share, color: Colors.black),
          SizedBox(width: 16)
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 TITLE
            const Text(
              "JADWAL AKADEMIK",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            const Text(
              "Struktur Data Lanjutan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Kode Mata Kuliah: CS-402 • Semester 7",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            /// 🔹 LOCATION CARD
            _buildCard(
              child: Column(
                children: [
                  _buildInfoItem(
                    Icons.location_on,
                    "Lokasi",
                    "Blok C, Ruang 402\nKampus Teknik, Sayap Utara",
                  ),
                  const Divider(),
                  _buildInfoItem(
                    Icons.location_on_outlined,
                    "Lokasi",
                    "Blok C, Ruang 402\nKampus Teknik, Sayap Utara",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 REMINDER CARD
            _buildCard(
              child: Column(
                children: [
                  _buildInfoItem(
                    Icons.notifications_active,
                    "Pengingat",
                    "Aktif\n15 menit sebelum mulai",
                  ),
                  const Divider(),
                  _buildInfoItem(
                    Icons.alarm,
                    "Pengingat",
                    "Aktif\n15 menit sebelum mulai",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 NOTES
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Catatan Kuliah",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mahasiswa diwajibkan membawa laptop pribadi dengan lingkungan C++ yang sudah terkonfigurasi. Semua tugas mingguan harus dikumpulkan melalui portal mahasiswa paling lambat hari Minggu pukul 23:59. Dokumentasi proyek akhir dikumpulkan pada Minggu ke-14.",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 BUTTONS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 96, 181, 250),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: const Text("UBAH JADWAL"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("HAPUS JADWAL"),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 FOOTER
            const Center(
              child: Text(
                "Tampilan Detail • ID Referensi: CS-402-2024",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// =========================
  /// 🔥 COMPONENT
  /// =========================

 Widget _buildCard({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}