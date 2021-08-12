import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:sirio_portfolio/main/tmdb/models/movie.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({ required this.movies });

  @override
  Widget build(BuildContext context) {
  
    final size = MediaQuery.of(context).size;

    if ( movies.length == 0 ) {

      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xff801434),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric( vertical: 35 ),
      width: double.infinity,
      height: size.height * 0.5,
      color: Colors.transparent,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.5,
        itemHeight: size.height * 0.7,
        itemBuilder: ( _, int i ) {

          final movie = movies[i];
          movie.heroId = "swiper-${ movie.id }";

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/tmdb_details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular( 20 ),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage( "assets/no-image.jpg" ),
                  image: NetworkImage( movie.fullPosterImg )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}