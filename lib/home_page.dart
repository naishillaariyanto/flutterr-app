import 'package:flutter/material.dart';
import 'tambah_jadwal_page.dart';

class HomePage extends StatefulWidget {
  final String nama;

  const HomePage({
    super.key,
    required this.nama,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> jadwalList = [];

  final List<Color> colors = [
    const Color(0xFF6C5CE7),
    const Color(0xFF00B894),
    const Color(0xFFFDCB6E),
    const Color(0xFF0984E3),
  ];

  final List<IconData> icons = [
    Icons.code_rounded,
    Icons.storage_rounded,
    Icons.account_tree_rounded,
    Icons.language_rounded,
  ];

  /// ➕ TAMBAH JADWAL
  Future<void> _tambahJadwal() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahJadwalPage(),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        jadwalList.add(Map<String, String>.from(result));
      });
    }
  }

  /// ✏️ EDIT
  Future<void> _editJadwal(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahJadwalPage(
          dataAwal: jadwalList[index],
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        jadwalList[index] = Map<String, String>.from(result);
      });
    }
  }

  /// 🗑️ HAPUS
  void _hapusJadwal(int index) {
    setState(() {
      jadwalList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Jadwal berhasil dihapus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// 🔥 DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Mahasiswa",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      /// 🔥 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        title: const Text(
          "Smart Class Reminder",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      /// 🔥 BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 👋 GREETING
            Text(
              "Halo, ${widget.nama}! 👋",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Ini jadwal kuliahmu hari ini",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            /// 📚 LIST
            Expanded(
              child: jadwalList.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada jadwal",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: jadwalList.length,
                      itemBuilder: (context, index) {
                        final item = jadwalList[index];
                        final color = colors[index % colors.length];
                        final icon = icons[index % icons.length];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              /// GARIS WARNA
                              Container(
                                width: 5,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [
                                      /// ICON
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color:
                                              color.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          icon,
                                          color: color,
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      /// TEXT
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["title"] ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              item["time"] ?? "",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// MENU
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == "edit") {
                                            _editJadwal(index);
                                          } else if (value == "hapus") {
                                            _hapusJadwal(index);
                                          }
                                        },
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                              value: "edit",
                                              child: Text("Edit")),
                                          PopupMenuItem(
                                              value: "hapus",
                                              child: Text("Hapus")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      /// ➕ BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}