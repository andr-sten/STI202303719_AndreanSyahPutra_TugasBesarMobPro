import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisikan data anggota kelompok di sini (Hardcoded)
    final List<Map<String, String>> members = [
      {"name": "Andrean Syah Putra", "nim": "STI202303719"},
      {"name": "Inez Dea Ariska", "nim": "STI202303642"},
      {"name": "Fani Amalia", "nim": "STI202303653"},
      {"name": "Sriyati", "nim": "STI202303700"},
      {"name": "Ari Nur Anita", "nim": "STI202303626"},
    ];

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tentang Kami"), centerTitle: true),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          const SizedBox(height: 20),
          Icon(Icons.diversity_3, size: 80, color: theme.primaryColor),
          const SizedBox(height: 10),
          const Text(
            "Travel Wisata Lokal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Tim Pengembang Aplikasi",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),

          // --- LIST ANGGOTA ---
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              separatorBuilder: (c, i) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final m = members[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 24, // Sedikit diperbesar
                    backgroundColor: theme.primaryColor,
                    child: Text(
                      m["name"] != null && m["name"]!.isNotEmpty
                          ? m["name"]![0].toUpperCase()
                          : "?",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    m["name"] ?? "Tanpa Nama",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Chip(
                    label: Text(
                      m["nim"] ?? "-",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
