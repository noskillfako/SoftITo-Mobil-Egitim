class Movie {
  final String id;
  final String title;
  final String genre;
  final double rating;
  final String imageUrl;
  final bool isWatched;
  final String status; // "İzledim", "İzleyeceğim", "Yarıda Bıraktım"
  final DateTime addedDate;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.imageUrl,
    this.isWatched = false,
    this.status = 'İzleyeceğim',
    required this.addedDate,
  });

  // --- JSON'dan Modele Dönüşüm (API kullanırsak gerekli) ---
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      genre: json['genre'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isWatched: json['isWatched'] as bool? ?? false,
      status: json['status'] as String? ?? 'İzleyeceğim',
      addedDate: DateTime.parse(json['addedDate'] as String),
    );
  }

  // --- Modelden JSON'a Dönüşüm (Kaydederken gerekli) ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'rating': rating,
      'imageUrl': imageUrl,
      'isWatched': isWatched,
      'status': status,
      'addedDate': addedDate.toIso8601String(),
    };
  }

  // --- Kopyalama Metodu (Bir özelliği değiştirip yeni nesne oluşturmak için) ---
  Movie copyWith({
    String? id,
    String? title,
    String? genre,
    double? rating,
    String? imageUrl,
    bool? isWatched,
    String? status,
    DateTime? addedDate,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isWatched: isWatched ?? this.isWatched,
      status: status ?? this.status,
      addedDate: addedDate ?? this.addedDate,
    );
  }
}