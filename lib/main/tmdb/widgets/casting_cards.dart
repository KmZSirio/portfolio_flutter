import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portfolio_flutter/main/tmdb/models/credits_response.dart';
import 'package:portfolio_flutter/main/tmdb/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  final String? title;

  const CastingCards({ required this.movieId, this.title });

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>( context, listen: false );

    return FutureBuilder(
      future: moviesProvider.getMovieCast( movieId ),
      builder: ( _, AsyncSnapshot<List<Cast>> snapshot ) {

        if ( !snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only( bottom: 30 ),
            width: double.infinity,
            height: 180,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff801434),
              ),
            ),
          );
        }

        final List<Cast> cast = snapshot.data!;
        
        return Container(
          margin: EdgeInsets.only( bottom: 30 ),
          width: double.infinity,
          height: 241,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ( title != null ) 
                ? Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                  child: Text( 
                    title!, 
                    style: TextStyle( fontSize: 20, color: Theme.of(context).textTheme.caption!.color ) 
                  ),
                )
                : Container(),
              Expanded(
                child: ListView.builder(
                  itemCount: cast.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ( _, int index ) => _CastCard( cast[index] ),
                ),
              ),
            ],
          ),
        );
      },
    );    
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;

  const _CastCard( this.cast );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      width: 110,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular( 20 ),
            child: FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"), 
              image: NetworkImage( cast.fullProfilePath ),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox( height: 4 ),
          Text( cast.name,
            style: TextStyle( color: Theme.of(context).textTheme.caption!.color ),
            maxLines: 2, 
            overflow: TextOverflow.ellipsis, 
            textAlign: TextAlign.center,
          ),
          Text( "\"${ cast.character }\"", 
            overflow: TextOverflow.ellipsis,
            maxLines: 2, 
            textAlign: TextAlign.center,
            style: TextStyle( color: Theme.of(context).primaryColor ),
          )
          
        ]
      ),
    );
  }
}