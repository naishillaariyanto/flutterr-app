import 'package:flutter/material.dart';
import 'tambah_jadwal_page.dart';

class HomePage extends StatefulWidget {
  final String nama;

  const HomePage({super.key, required this.nama});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, String>> jadwalList = [];

  void _tambahJadwal() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Smart Class",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Belum ada notifikasi")),
              );
            },
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Text(
                "Halo, ${widget.nama}",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            /// 🔥 HEADER MODERN
            Text(
              "Hi, ${widget.nama} 👋",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Let’s make today productive 🚀",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// 🔥 LIST
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

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: Row(
                            children: [

                              /// ICON BULAT
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  icons[index % icons.length],
                                  color: color,
                                ),
                              ),

                              const SizedBox(width: 14),

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
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(item["time"] ?? ""),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(item["room"] ?? "-"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(Icons.more_vert, color: Colors.grey)
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),

      /// 🔥 FAB MODERN
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}