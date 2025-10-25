class Coffee {
  Coffee({required this.imageUrl, this.isFavorite = false});
  final String imageUrl;
  final bool isFavorite;

  @override
  bool operator ==(covariant Coffee other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl && other.isFavorite == isFavorite;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ isFavorite.hashCode;

  Coffee copyWith({String? imageUrl, bool? isFavorite}) {
    return Coffee(imageUrl: imageUrl ?? this.imageUrl, isFavorite: isFavorite ?? this.isFavorite);
  }
}
