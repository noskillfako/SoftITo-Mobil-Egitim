class Review {
  final String id;
  final String movieId;
  final String comment;
  final double score;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.movieId,
    required this.comment,
    required this.score,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      movieId: json['movieId'] as String,
      comment: json['comment'] as String,
      score: (json['score'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movieId': movieId,
      'comment': comment,
      'score': score,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}