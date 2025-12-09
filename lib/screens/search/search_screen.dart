import 'dart:io'; // <--- PASTIKAN IMPORT INI ADA
import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/wisata_model.dart';
import '../../services/database_helper.dart';
import '../detail/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Wisata> _allWisata = [];
  List<Wisata> _foundWisata = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DatabaseHelper().getWisataList();
    setState(() {
      _allWisata = data;
      _foundWisata = data;
    });
  }

  void _runFilter(String keyword) {
    List<Wisata> results = [];
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
            TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Cari Wisata...',
                labelStyle: const TextStyle(fontSize: 19),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _runFilter('');
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundWisata.isEmpty
                  ? const Center(
                      child: Text(
                        'Wisata tidak ditemukan',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _foundWisata.length,
                      itemBuilder: (context, index) {
                        final wisata = _foundWisata[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  // PERBAIKAN DI SINI: Gunakan File() langsung
                                  // ...
                                  image:
                                      wisata.imagePaths.isNotEmpty &&
                                          wisata.imagePaths[0].startsWith(
                                            'http',
                                          )
                                      ? NetworkImage(wisata.imagePaths[0])
                                      : FileImage(File(wisata.imagePaths[0]))
                                            as ImageProvider,
                                  // ...
                                  fit: BoxFit.cover,
                                  onError: (_, __) => const Icon(Icons.error),
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
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    wisata.location,
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(wisata: wisata),
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
