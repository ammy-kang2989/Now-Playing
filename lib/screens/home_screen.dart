import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nowplaying/bloc/movies_bloc.dart';
import 'package:nowplaying/tiles/movie_list_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child:  AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: null,
        actions: <Widget>[

          new Flexible(
            child: Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                // onChanged: (a) async {
                // },
                autofocus: false,
                decoration: InputDecoration(
                  suffixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Search movies..",

                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.blue)),
                  contentPadding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                // onChanged: _updateSearchQuery,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.black,
      )
      ),

      body: StreamBuilder(
          stream: bloc.movieListControllerOut,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  color: Colors.grey,
                  child: new Text(
                    snapshot.error.toString().substring(10),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
              );
            }
            if (snapshot.hasData)
              return ListView.builder(
                physics: ScrollPhysics(),
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return MovieListViewTile(snapshot.data[index]);
                  } else if (index > 1) {
                    bloc.fetchListMovie();
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.yellow),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            else
              return Container();
          }),
    );
  }
}

