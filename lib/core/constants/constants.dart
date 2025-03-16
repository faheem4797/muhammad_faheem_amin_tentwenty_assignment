import 'package:muhammad_faheem_amin_tentwenty_assignment/core/theme/app_pallette.dart';

class Constants {
  static const String apiKey = "5a251e69ce6fa5ec5f2153ebb2b652cb";
  static const String upcomingMoviesBaseUrl =
      "https://api.themoviedb.org/3/movie/upcoming";

  static const String movieVideoUrl = "https://api.themoviedb.org/3/movie/";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/original";
  static const String youtubeBaseUrl = "https://www.youtube.com/watch?v=";

  static const String currency = '\$';

  static const genreId = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };

  static const List<Map<String, String>> genresOnSearchPage = [
    {"name": "Comedies", "image": "assets/comedies.jpeg"},
    {"name": "Crime", "image": "assets/crime.jpeg"},
    {"name": "Family", "image": "assets/family.jpeg"},
    {"name": "Documentaries", "image": "assets/documentaries.jpeg"},
    {"name": "Dramas", "image": "assets/dramas.jpeg"},
    {"name": "Fantasy", "image": "assets/fantasy.jpeg"},
    {"name": "Holidays", "image": "assets/holidays.jpeg"},
    {"name": "Horror", "image": "assets/horror.jpeg"},
    {"name": "Sci-Fi", "image": "assets/scifi.jpeg"},
    {"name": "Thriller", "image": "assets/thriller.jpeg"},
  ];

  static const listOfColors = [
    AppPallete.kDarkYellowColor,
    AppPallete.kPurpleColor,
    AppPallete.kGreenColor,
    AppPallete.kPinkColor,
  ];
  // SUccess Messages

  // Error Messages
  static const String noInternetConnection = "No Internet Connection";
  static const String noMoviesFound = "No Movies Found";

  // Titles
  static const String dashBoardTitle = "Dashboard";
  static const String watchTitle = "Watch";
  static const String mediaLibraryTitle = "Media Library";
  static const String moreTitle = "More";

  // Search Page
  static const String topResults = "Top Results";
  static const String searchHint = "TV shows, movies and more";

  // Movie Details Page
  static const String inTheaters = "In Theaters";
  static const String getTickets = "Get Tickets";
  static const String watchTrailer = "Watch Trailer";
  static const String genres = "Genres";
  static const String overview = "Overview";

  // Get Tickets Page
  static const String date = "Date";
  static const String cinetech = "Cinetech";
  static const String hall1 = "Hall 1";
  static const String hall2 = "Hall 2";
  static const String selectSeatsButtonText = "Select Seats";

  // Select Seats Page
  static const String selected = "Selected";
  static const String notAvailable = "Not Available";
  static const String vip = "VIP";
  static const String regular = "Selected";
  static const int vipPrice = 150;
  static const int regularPrice = 150;
  static const String totalPrice = "Total Price";
  static const String proceedToPayButtonText = "Proceed to pay";
}
