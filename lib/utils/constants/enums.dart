// 1. Movie Genres Enum
enum MovieGenre {
  action,
  comedy,
  drama,
  horror,
  romance,
  thriller,
  sciFi,
  animation,
  documentary,
  fantasy,
  adventure,
  mystery
}

// 2. User Rating Enum
enum UserRating {
  oneStar,
  twoStars,
  threeStars,
  fourStars,
  fiveStars
}

// 3. Movie Status Enum
enum MovieStatus {
  nowPlaying,
  upcoming,
  released,
  comingSoon,
  archived
}

// 4. Review Type Enum
enum ReviewType {
  spoiler,
  nonSpoiler
}

// 5. Sort Options Enum
enum SortOption {
  byReleaseDate,
  byRating,
  byPopularity,
  byTitle
}

// 6. Content Rating Enum
enum ContentRating {
  g, // General audience
  pg, // Parental guidance
  pg13, // Parents strongly cautioned
  r, // Restricted
  nc17 // No one 17 and under admitted
}

// 7. Recommendation Method Enum
enum RecommendationMethod {
  collaborativeFiltering,
  contentBasedFiltering,
  hybridFiltering
}

// 8. User Action Enum
enum UserAction {
  addFavorite,
  removeFavorite,
  addWatchLater,
  removeWatchLater,
  like,
  dislike
}

// 9. Language Enum
enum Language {
  english,
  arabic,
  spanish,
  french,
  german,
  italian,
  japanese,
  chinese
}

// 10. Movie Format Enum
enum MovieFormat {
  standard,
  hd,
  ultraHd,
  dolbyAtmos
}
