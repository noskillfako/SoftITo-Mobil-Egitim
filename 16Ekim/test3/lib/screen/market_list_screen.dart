import 'package:flutter/material.dart';
import '../models/asset_model.dart'; // Movie modelini import ettik

class MarketListScreen extends StatefulWidget {
  const MarketListScreen({super.key});

  @override
  State<MarketListScreen> createState() => _MarketListScreenState();
}

class _MarketListScreenState extends State<MarketListScreen> {
  // Artık Map değil, Movie nesneleri kullanıyoruz
  final List<Movie> _movies = [
    Movie(
      id: '1',
      title: 'Inception',
      genre: 'Bilim Kurgu / Gerilim',
      rating: 8.8,
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg',
      isWatched: true,
      status: 'İzledim',
      addedDate: DateTime(2024, 1, 15),
    ),
    Movie(
      id: '2',
      title: 'The Dark Knight',
      genre: 'Aksiyon / Suç',
      rating: 9.0,
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg',
      isWatched: false,
      status: 'İzleyeceğim',
      addedDate: DateTime(2024, 2, 20),
    ),
    Movie(
      id: '3',
      title: 'Interstellar',
      genre: 'Bilim Kurgu / Dram',
      rating: 8.7,
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
      isWatched: true,
      status: 'İzledim',
      addedDate: DateTime(2024, 3, 10),
    ),
    Movie(
      id: '4',
      title: 'Pulp Fiction',
      genre: 'Suç / Dram',
      rating: 8.9,
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
      isWatched: false,
      status: 'İzleyeceğim',
      addedDate: DateTime(2024, 4, 5),
    ),
    Movie(
      id: '5',
      title: 'The Matrix',
      genre: 'Aksiyon / Bilim Kurgu',
      rating: 8.7,
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      isWatched: true,
      status: 'İzledim',
      addedDate: DateTime(2024, 5, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Film Arşivim',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Arama butonuna basıldı");
            },
          ),
        ],
      ),
      body: _movies.isEmpty
          ? const Center(
              child: Text(
                'Henüz film eklenmedi',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final Movie movie = _movies[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Film Posteri
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            movie.imageUrl,
                            width: 80,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 110,
                                color: const Color(0xFFE2E8F0),
                                child: const Icon(
                                  Icons.movie,
                                  color: Color(0xFF64748B),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Film Bilgileri
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Film Adı
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),

                              // Tür
                              Text(
                                movie.genre,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Puan ve İzlenme Durumu
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.rating.toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF334155),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),

                                  // İzlendi/İzlenmedi Etiketi
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: movie.isWatched
                                          ? const Color(0xFFDCFCE7)
                                          : const Color(0xFFFFEDD5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      movie.isWatched
                                          ? 'İzledim'
                                          : 'İzleyeceğim',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: movie.isWatched
                                            ? const Color(0xFF15803D)
                                            : const Color(0xFFC2410C),
                                      ),
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
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Film ekleme butonuna basıldı");
        },
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
