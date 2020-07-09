import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nowplaying/models/movie.dart';

class MovieDescriptionScreen extends StatelessWidget {
  final Movie movie;
  final imageUrl;

  const MovieDescriptionScreen({Key key, this.movie, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rating = double.parse(movie.voteAverage);
    rating = rating/2;
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: new Material(
          color: Colors.transparent,
          child: new CustomScrollView(
            slivers: [
              new SliverAppBar(
                centerTitle: true,
                flexibleSpace: new FlexibleSpaceBar(
                  background: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: new Container(
                        child: Image.network(
                            "http://image.tmdb.org/t/p/w500$imageUrl")),
                  ),
                ),
                pinned: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                expandedHeight: MediaQuery.of(context).size.height / 3.0,
                backgroundColor: Colors.black,
              ),
              SliverFillRemaining(
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            RatingBarIndicator(
                              rating: rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              "\Title: ${movie.originalTitle}",
                              style: TextStyle(
                                  fontSize: 28.0, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("\n${movie.overview}",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                            ),
                          ],
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
