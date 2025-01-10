import 'package:flutter/material.dart';
import 'package:quadb_tech/pages/movie_entity.dart' as movie_entity;
class DetailsScreen extends StatelessWidget {
  final movie_entity.Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Image
            movie.image?.original != null
                ? Image.network(
              movie.image!.original,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: Icon(
                Icons.image_not_supported,
                size: 100,
                color: Colors.grey,
              ),
            ),

            // Movie Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Movie Genres
            if (movie.genres.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Genres: ${movie.genres.join(', ')}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),

            // Movie Summary
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.summary.replaceAll(RegExp(r'<[^>]*>'), ''), // Clean HTML tags
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Additional Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie.language.isNotEmpty)
                    Text(
                      'Language: ${movie.language}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (movie.rating?.average != null)
                    Text(
                      'Rating: ${movie.rating!.average}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (movie.premiered != null)
                    Text(
                      'Premiered: ${movie.premiered}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (movie.ended != null)
                    Text(
                      'Ended: ${movie.ended}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (movie.officialSite != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => _openOfficialSite(movie.officialSite!, context),
                        child: Text(
                          'Official Site: ${movie.officialSite}',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 // Import the url_launcher package


  void _openOfficialSite(String url, BuildContext context) async {


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch the official site: $url')));



  }


}
