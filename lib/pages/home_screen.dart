import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'details_screen.dart'; // Import for details screen navigation
import 'package:quadb_tech/pages/movie_entity.dart' as movie_entity; // Alias added

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<movie_entity.Movie> movies = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);
        setState(() {
          movies = jsonResponse
              .map((movie) => movie_entity.Movie.fromJson(movie['show']))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load movies. Status Code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred while fetching movies: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return  Padding(
            padding: const EdgeInsets.all(12.0), // Adjust padding for better spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display image or placeholder with improved visuals
                (movie.image?.original != null)
                    ? Material(
                  elevation: 6.0, // Increased elevation for better shadow effect
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  shadowColor: Colors.grey.withOpacity(0.5), // Soft shadow
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), // Ensure rounded corners
                    child: Image.network(
                      movie.image!.original,
                      width: double.infinity, // Full available width
                      height: MediaQuery.of(context).size.height * 0.3, // 30% height
                      fit: BoxFit.cover, // Ensure the image covers the area
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                )
                    : Material(
                  elevation: 6.0,
                  borderRadius: BorderRadius.circular(12.0),
                  shadowColor: Colors.grey.withOpacity(0.5), // Soft shadow for placeholder
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                        colors: [Colors.grey[300]!, Colors.grey[100]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ), // Gradient for placeholder
                    ),
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  ),
                ),

                SizedBox(height: 16.0),

                // Star rating with better spacing and alignment
                StarRating(
                  mainAxisAlignment: MainAxisAlignment.start,
                  size: 18,
                  rating: movie.rating?.average ?? 0.0, // Default to 0.0
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  halfFilledIcon: Icons.star_half, // Add half-filled icon
                  color: Colors.amber, // Filled icon color
                  borderColor: Colors.grey, // Empty icon color
                ),

                SizedBox(height: 12.0),

                // Movie details with improved typography and alignment
                Row(
                  children: [
                    // Movie name and metadata
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name ?? "Unknown Name",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Richer text color
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Runtime: ${movie.runtime ?? 'N/A'} mins',
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                'Type: ${movie.type ?? 'N/A'}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // "Show Details" button with an elevated style
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 4.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        backgroundColor: Colors.redAccent, // Updated button color
                        foregroundColor: Colors.white, // Text and icon color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Rounded button
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(movie: movie)));
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text(
                        'Show Details',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );


        },
      ),



      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/search'); // Assuming route is set up for SearchScreen
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
