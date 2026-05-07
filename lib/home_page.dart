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

  /// 🎨 WARNA CARD
  final List<Color> colors = [
    const Color(0xFF6C5CE7),
    const Color(0xFF00B894),
    const Color(0xFFFDCB6E),
    const Color(0xFF0984E3),
  ];

  /// 🎨 ICON CARD
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

    if (result != null) {
      setState(() {
        jadwalList.add(Map<String, String>.from(result));
      });
    }
  }

  /// ✏️ EDIT JADWAL
  Future<void> _editJadwal(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahJadwalPage(
          dataAwal: jadwalList[index],
        ),
      ),
    );

    if (result != null) {
      setState(() {
        jadwalList[index] = Map<String, String>.from(result);
      });
    }
  }

  /// 🗑️ HAPUS JADWAL
  void _hapusJadwal(int index) {
    setState(() {
      jadwalList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Jadwal berhasil dihapus"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// 🔥 DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            /// HEADER
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    ),
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
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            /// MENU
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Kalender"),
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Fitur kalender segera hadir"),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifikasi"),
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Belum ada notifikasi"),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
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
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
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

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          )
        ],
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

            /// 📚 LIST JADWAL
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
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),

                          child: Row(
                            children: [

                              /// 🌈 GARIS KIRI
                              Container(
                                width: 5,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    children: [

                                      /// 🎨 ICON
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          icon,
                                          color: color,
                                          size: 28,
                                        ),
                                      ),

                                      const SizedBox(width: 14),

                                      /// 📄 INFO
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              item["title"] ?? "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 8),

                                            Row(
                                              children: [

                                                const Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),

                                                const SizedBox(width: 4),

                                                Text(
                                                  item["time"] ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 4),

                                            Row(
                                              children: [

                                                const Icon(
                                                  Icons.location_on_outlined,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),

                                                const SizedBox(width: 4),

                                                Text(
                                                  item["room"] ?? "-",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// 🔥 MENU TITIK 3
                                      PopupMenuButton<String>(
                                        onSelected: (value) {

                                          if (value == "edit") {
                                            _editJadwal(index);
                                          }

                                          if (value == "hapus") {
                                            _hapusJadwal(index);
                                          }
                                        },
                                        itemBuilder: (context) => const [

                                          PopupMenuItem(
                                            value: "edit",
                                            child: Text("Edit"),
                                          ),

                                          PopupMenuItem(
                                            value: "hapus",
                                            child: Text("Hapus"),
                                          ),
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

      /// ➕ FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),

      /// 🔻 BOTTOM NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Kalender",
          ),
        ],
      ),
    );
  }
}