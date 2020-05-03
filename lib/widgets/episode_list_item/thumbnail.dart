import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:transparent_image/transparent_image.dart';

class Thumbnail extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const Thumbnail({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl =
        'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg';
    var width = 90.0;

    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            height: width,
            width: width,
          ),
        ),
        Container(
          height: width,
          width: width,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(600.0),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.45),
              height: 45.0,
              width: 45.0,
            ),
          ),
        ),
        Container(
          height: width,
          width: width,
          alignment: Alignment.center,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 32,
          ),
        ),
        Container(
          height: width,
          width: width,
          alignment: Alignment(0.89, 0.92),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.75),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '04:78',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.3,
                    letterSpacing: 0.3,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
