import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/main/tmdb/models/movie.dart';
import 'package:portfolio_flutter/main/tmdb/widgets/tmdb_widgets.dart';


class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [

          _CustomAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([

              _PosterAndTitle( movie ),
              SizedBox( height: 10 ),
              _Overview( movie ),
              SizedBox( height: 10 ),
              CastingCards( movie.id ),

            ])
          )

        ],
      )
   );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar( this.movie );

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          color: Colors.black26,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only( bottom: 18 ),
          child: Text( movie.title, style: GoogleFonts.raleway(), textAlign: TextAlign.center )
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"), 
          image: NetworkImage( movie.fullBackdropPath ), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle( this.movie );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [

          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"), 
                image: NetworkImage( movie.fullPosterImg ), 
                width: 120,
              ),
            ),
          ),

          SizedBox( width: 20 ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ConstrainedBox(
                constraints: BoxConstraints( maxWidth: size.width - 120 - 40 - 20 ),
                child: Text( 
                  movie.title, 
                  style: TextStyle( color: Theme.of(context).textTheme.caption!.color, fontSize: 22 ), 
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2 
                )
              ),
              SizedBox( height: 7 ),
              ConstrainedBox(
                constraints: BoxConstraints( maxWidth: size.width - 120 - 40 - 20 ),
                child: Text( 
                  movie.originalTitle, 
                  style: TextStyle( color: Theme.of(context).textTheme.caption!.color, fontSize: 18 ), 
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2 
                )
              ),
              SizedBox( height: 7 ),
              Row(
                children: [

                  Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                  SizedBox( width: 5 ),
                  Text( "${ movie.voteAverage }", style: Theme.of(context).textTheme.caption ),
                  
                ]
              )

            ]
          )

        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview( this.movie );

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 30, vertical: 10 ),
      child: Text( movie.overview, 
        style: TextStyle( color: Theme.of(context).textTheme.caption!.color, fontSize: 15 ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}