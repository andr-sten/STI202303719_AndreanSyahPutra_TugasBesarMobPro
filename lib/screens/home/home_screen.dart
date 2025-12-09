import 'package:flutter/material.dart';
import '../../models/wisata_model.dart';
import '../../services/database_helper.dart';
import '../../widgets/common_card.dart';
import '../detail/detail_screen.dart';
import '../form/add_edit_screen.dart';
import '../../main.dart'; // Import main untuk toggle theme

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ["All", "Populer", "Rekomendasi"];

  List<Wisata> _allWisata = [];
  List<Wisata> _displayWisata = []; // Data yang ditampilkan setelah filter

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await DatabaseHelper().getWisataList();
    setState(() {
      _allWisata = data;
      _filterData(); // Jalankan filter saat data baru masuk
    });
  }

  // LOGIKA FILTER KATEGORI
  void _filterData() {
    setState(() {
      if (_selectedCategoryIndex == 0) {
        _displayWisata = _allWisata; // Tampilkan Semua
      } else {
        String targetCategory = _categories[_selectedCategoryIndex];
        _displayWisata = _allWisata
            .where((w) => w.category == targetCategory)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Travel Wisata Lokal",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => MyApp.toggleTheme(context),
          ),
        ],
      ),
      // Tombol Tambah Data
      // Tombol Tambah Data
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Buka halaman tambah data dan tunggu hasilnya
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditScreen()),
          );

          // Jika result bernilai true (artinya data berhasil disimpan)
          if (result == true) {
            // Refresh data di halaman Home
            _refreshData();

            // Tampilkan pesan sukses
            if (context.mounted) {
              // Cek apakah widget masih aktif
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Berhasil menambahkan wisata baru!"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Catatan: Search bar dihapus dari Home karena sudah ada tab Search sendiri
          const SizedBox(height: 10),

          // 1. KATEGORI CHIPS
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                      _filterData(); // Panggil fungsi filter saat diklik
                    });
                  },
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
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 2. GRID WISATA
          Expanded(
            child: _displayWisata.isEmpty
                ? const Center(
                    child: Text(
                      "Silahkan Tambah Data Wisata",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _displayWisata.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemBuilder: (context, index) {
                      final wisata = _displayWisata[index];
                      return DestinationCard(
                        wisata: wisata,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(wisata: wisata),
                            ),
                          );
                          _refreshData();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
