import 'package:flutter/material.dart';

class TambahJadwalPage extends StatefulWidget {
  final Map<String, String>? dataAwal;

  const TambahJadwalPage({
    super.key,
    this.dataAwal,
  });

  @override
  State<TambahJadwalPage> createState() => _TambahJadwalPageState();
}

class _TambahJadwalPageState extends State<TambahJadwalPage> {
  DateTime? selectedDate; // 🔥 GANTI INI
  String selectedReminder = "10 menit sebelum";
  TimeOfDay? selectedTime;

  final TextEditingController courseController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController lecturerController = TextEditingController();

  /// 🔥 FORMAT JAM 24
  String formatTime24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  /// 🔥 FORMAT TANGGAL
  String formatDate(DateTime date) {
    final days = [
      "Senin","Selasa","Rabu","Kamis","Jumat","Sabtu","Minggu"
    ];

    final months = [
      "Januari","Februari","Maret","April","Mei","Juni",
      "Juli","Agustus","September","Oktober","November","Desember"
    ];

    return "${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}";
  }

  void _save() {
    if (courseController.text.isEmpty ||
        roomController.text.isEmpty ||
        lecturerController.text.isEmpty ||
        selectedTime == null ||
        selectedDate == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data")),
      );
      return;
    }

    final data = {
      "title": courseController.text,
      "time":
          "${formatDate(selectedDate!)} • ${formatTime24(selectedTime!)}",
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
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Tambah Jadwal",
          style: TextStyle(color: Colors.black),
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

            /// 🔥 GANTI JADI DATE PICKER
            _label("Hari"),
            _datePicker(),

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
              child: InkWell(
                onTap: _save,
                borderRadius: BorderRadius.circular(14),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF7F7FD5),
                        Color(0xFF86A8E7),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ================= DATE PICKER =================
  Widget _datePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );

        if (picked != null) {
          setState(() {
            selectedDate = picked;
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
            const Icon(Icons.calendar_today_outlined),
            const SizedBox(width: 10),
            Text(
              selectedDate == null
                  ? "Pilih hari"
                  : formatDate(selectedDate!),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= WIDGET LAIN =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w500)),
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

  Widget _timePicker() {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
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
                  : formatTime24(selectedTime!),
            ),
          ],
        ),
      ),
    );
  }

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
              ? const Color(0xFF7F7FD5).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7F7FD5)
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
                  ? const Color(0xFF7F7FD5)
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