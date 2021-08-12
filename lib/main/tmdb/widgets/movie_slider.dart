import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/tmdb/models/movie.dart';


class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;
  final int randomNumber;

  const MovieSlider({ required this.movies, this.title, required this.onNextPage, required this.randomNumber });

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() { 

    scrollController.addListener(() {

      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }

    });
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 262,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ( widget.title != null ) 
            ? Container(
              padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
              child: Text( 
                widget.title!, 
                style: TextStyle( fontSize: 20, color: Theme.of(context).textTheme.caption!.color ) 
              ),
            )
            : Container(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: ( _, int i) => _MoviePoster( widget.movies[i], widget.randomNumber ),
            ),
          )

        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final int randomNumber;

  const _MoviePoster( this.movie, this.randomNumber );

  @override
  Widget build(BuildContext context) {
    movie.heroId = "slider-${ movie.id }-$randomNumber";

    return Container(
      // color: Colors.blueGrey[700],
      width: 130,
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(  context, '/tmdb_details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage( "assets/no-image.jpg" ),
                  image: NetworkImage( movie.fullPosterImg )
                ),
              ),
            ),
          ),
          Text( movie.title, 
            style: TextStyle( color: Theme.of(context).textTheme.caption!.color ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, 
          ),
          
        ],
      ),
    );
  }
}