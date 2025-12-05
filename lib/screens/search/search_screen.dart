import 'package:flutter/material.dart';

// --- IMPORTS DARI MODUL LAIN (PENDING) ---
// TODO: Uncomment import ini jika modul model, database, dan detail sudah ready di branch main
// import 'dart:io';
// import '../../models/wisata_model.dart';
// import '../../services/database_helper.dart';
// import '../detail/detail_screen.dart';

// --- MOCK DATA (TEMPORARY) ---
// Class sederhana untuk simulasi data pencarian
class MockWisataSearch {
  final String name;
  final String location;
  final String imageUrl;

  MockWisataSearch(this.name, this.location, this.imageUrl);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Data Dummy untuk simulasi pencarian
  final List<MockWisataSearch> _allWisata = [
    MockWisataSearch(
      "Pantai Kuta",
      "Bali",
      "https://picsum.photos/id/10/200/300",
    ),
    MockWisataSearch(
      "Candi Borobudur",
      "Magelang",
      "https://picsum.photos/id/15/200/300",
    ),
    MockWisataSearch(
      "Gunung Bromo",
      "Jawa Timur",
      "https://picsum.photos/id/28/200/300",
    ),
    MockWisataSearch(
      "Danau Toba",
      "Sumatera Utara",
      "https://picsum.photos/id/29/200/300",
    ),
    MockWisataSearch(
      "Malioboro",
      "Yogyakarta",
      "https://picsum.photos/id/30/200/300",
    ),
    MockWisataSearch(
      "Raja Ampat",
      "Papua",
      "https://picsum.photos/id/40/200/300",
    ),
  ];

  List<MockWisataSearch> _foundWisata = [];

  @override
  void initState() {
    super.initState();
    // Inisialisasi awal menampilkan semua data mock
    _foundWisata = _allWisata;
  }

  // Logika Filter UI (Berjalan di memori lokal)
  void _runFilter(String keyword) {
    List<MockWisataSearch> results = [];
    if (keyword.isEmpty) {
      results = _allWisata;
    } else {
      results = _allWisata
          .where(
            (item) =>
        item.name.toLowerCase().contains(keyword.toLowerCase()) ||
            item.location.toLowerCase().contains(keyword.toLowerCase()),
      )
          .toList();
    }
    setState(() {
      _foundWisata = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pencarian")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // SEARCH BAR UI
            TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Cari Wisata...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _runFilter(''); // Reset list
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // HASIL PENCARIAN
            Expanded(
              child: _foundWisata.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'Wisata tidak ditemukan',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _foundWisata.length,
                itemBuilder: (context, index) {
                  final wisata = _foundWisata[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                          image: DecorationImage(
                            // Menggunakan NetworkImage langsung untuk Mock UI
                            image: NetworkImage(wisata.imageUrl),
                            fit: BoxFit.cover,
                            onError: (_, __) =>
                            const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      title: Text(
                        wisata.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              wisata.location,
                              style: const TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navigasi ke DetailScreen saat modul Detail ready
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Membuka detail: ${wisata.name}",
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
