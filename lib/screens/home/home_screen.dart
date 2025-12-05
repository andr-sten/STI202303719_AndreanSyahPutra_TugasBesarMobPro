import 'package:flutter/material.dart';

// --- SECTION: IMPORTS DARI MODUL LAIN (PENDING) ---
// Note: Bagian ini di-comment karena modul lain belum di-merge atau belum dibuat oleh rekan tim.
// TODO: Uncomment jika file model sudah tersedia di branch main
// import '../../models/wisata_model.dart';
// import '../../services/database_helper.dart';

// TODO: Uncomment jika modul Detail dan Form sudah siap
// import '../detail/detail_screen.dart';
// import '../form/add_edit_screen.dart';

// --- SECTION: MOCK DATA (TEMPORARY) ---
// Gunakan class ini sementara untuk kebutuhan UI Slicing Home
// Nanti hapus class ini jika WisataModel sudah ready.
class MockWisata {
  final String name;
  final String category;
  final String location;
  final double rating;
  final String imageUrl;

  MockWisata(
    this.name,
    this.category,
    this.location,
    this.rating,
    this.imageUrl,
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State untuk Filter Kategori
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "All",
    "Populer",
    "Rekomendasi",
    "Alam",
    "Kuliner",
  ];

  // Dummy Data untuk visualisasi UI (Hardcoded)
  final List<MockWisata> _allWisata = [
    MockWisata(
      "Pantai Kuta",
      "Populer",
      "Bali",
      4.8,
      "https://picsum.photos/id/10/200/300",
    ),
    MockWisata(
      "Borobudur",
      "Rekomendasi",
      "Magelang",
      5.0,
      "https://picsum.photos/id/15/200/300",
    ),
    MockWisata(
      "Bromo",
      "Alam",
      "Jawa Timur",
      4.9,
      "https://picsum.photos/id/28/200/300",
    ),
    MockWisata(
      "Malioboro",
      "Kuliner",
      "Yogyakarta",
      4.7,
      "https://picsum.photos/id/30/200/300",
    ),
  ];

  List<MockWisata> _displayWisata = [];

  @override
  void initState() {
    super.initState();
    // TODO: Ganti dengan fetch data dari DatabaseHelper nanti
    _displayWisata = _allWisata;
  }

  void _filterData(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      if (index == 0) {
        _displayWisata = _allWisata;
      } else {
        String target = _categories[index];
        _displayWisata = _allWisata.where((w) => w.category == target).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil tema dari root (main.dart)
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Travel Wisata",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // TODO: Implementasi logika Theme Switcher global
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("TODO: Integrasi Theme Provider")),
              );
            },
          ),
        ],
      ),

      // Floating Action Button untuk Tambah Data
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigasi ke AddEditScreen saat modul Form ready
          print("Navigasi ke Form Screen...");
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          // 1. KATEGORI FILTER (Horizontal Scroll)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => _filterData(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? theme.primaryColor : Colors.grey,
                      ),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 2. LIST WISATA (Grid View)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _displayWisata.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = _displayWisata[index];
                return _buildCardItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET CARD LOKAL
  // Note: Nanti bisa dipisah ke folder widgets/common_card.dart
  Widget _buildCardItem(MockWisata item) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigasi ke DetailScreen (kirim data item)
        print("Membuka detail: ${item.name}");
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, _, __) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
