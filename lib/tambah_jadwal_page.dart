import 'package:flutter/material.dart';

class TambahJadwalPage extends StatefulWidget {
  final Map<String, String>? dataAwal;

  const TambahJadwalPage({
    super.key,
    this.dataAwal, // ✅ TAMBAH INI
  });
  
  @override
  State<TambahJadwalPage> createState() => _TambahJadwalPageState();
}

class _TambahJadwalPageState extends State<TambahJadwalPage> {
  String selectedDay = "Senin";
  String selectedReminder = "10 menit sebelum";
  TimeOfDay? selectedTime;

  final TextEditingController courseController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController lecturerController = TextEditingController();

  void _save() {
    if (courseController.text.isEmpty ||
        roomController.text.isEmpty ||
        lecturerController.text.isEmpty ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data")),
      );
      return;
    }

    final data = {
      "title": courseController.text,
      "time": "$selectedDay • ${selectedTime!.format(context)}",
      "reminder": selectedReminder,
    };

    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color.fromARGB(255, 58, 212, 255)),
        title: const Text(
          "Tambah Jadwal",
          style: TextStyle(color: Color.fromARGB(255, 30, 214, 255)),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _label("Nama Mata Kuliah"),
            _input(
              controller: courseController,
              hint: "Masukkan nama mata kuliah",
              icon: Icons.book_outlined,
            ),

            const SizedBox(height: 16),

            _label("Hari"),
            _dropdown(),

            const SizedBox(height: 16),

            _label("Jam Mulai"),
            _timePicker(),

            const SizedBox(height: 16),

            _label("Ruang"),
            _input(
              controller: roomController,
              hint: "Masukkan ruang",
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 16),

            _label("Dosen"),
            _input(
              controller: lecturerController,
              hint: "Masukkan nama dosen",
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 20),

            /// 🔥 PENGINGAT (FIX TANPA RADIO DEPRECATED)
            const Text(
              "Pengingat (Alarm)",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _radioCustom("10 menit sebelum"),
                  _radioCustom("15 menit sebelum"),
                  _radioCustom("30 menit sebelum"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ================= WIDGET =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButton<String>(
        value: selectedDay,
        isExpanded: true,
        underline: const SizedBox(),
        items: ["Senin","Selasa","Rabu","Kamis","Jumat"]
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {
          setState(() {
            selectedDay = val!;
          });
        },
      ),
    );
  }

  Widget _timePicker() {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          setState(() {
            selectedTime = time;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 10),
            Text(
              selectedTime == null
                  ? "Pilih jam mulai"
                  : selectedTime!.format(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 RADIO CUSTOM (NO DEPRECATED)
  Widget _radioCustom(String text) {
    final isSelected = selectedReminder == text;

    return InkWell(
      onTap: () {
        setState(() {
          selectedReminder = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2C3E50).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2C3E50)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected
                  ? const Color(0xFF2C3E50)
                  : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}