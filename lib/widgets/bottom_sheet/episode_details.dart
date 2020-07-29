// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/html.dart';

void showEpisodeDetailsBottomSheet({
  BuildContext context,
  Episode episode,
  Podcast podcast,
}) {
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
    ),
    elevation: 10,
    useRootNavigator: true,
    isDismissible: true,
    animationCurve: Curves.ease,
    duration: Duration(milliseconds: 250),
    builder: (context, scrollController) => EpisodeDetailsBottomSheet(
      episode: episode,
      podcast: podcast,
      scrollController: scrollController,
    ),
  );
}

class EpisodeDetailsBottomSheet extends StatelessWidget {
  const EpisodeDetailsBottomSheet({
    Key key,
    @required this.episode,
    @required this.podcast,
    @required this.scrollController,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight() * 0.6,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 14,
                right: 14,
              ),
              child: HTML(
                id: episode.id,
                document: episode.description,
              ),
            ),
          ),
          Container(
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            child: Text(
              'Show Notes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Container(
            height: 42,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: TWColors.gray.shade400,
                ),
              ),
            ),
          )
        ],
      ),
    );

    // DraggableScrollableSheet(
    //   initialChildSize: 1.0,
    //   builder: (BuildContext context, ScrollController scrollController) {
    //     return SingleChildScrollView(
    //       controller: scrollController,
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 16),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: const Radius.circular(15),
    //             topRight: const Radius.circular(15),
    //           ),
    //         ),
    //         child: HTML(id: episode.id, document: episode.description),
    //       ),
    //     );
    //   },
    // );
  }

  // Widget _buildDetails() {
  //   final episodeTitle = Container(
  //     padding: EdgeInsets.only(bottom: 16),
  //     transform: Matrix4.translationValues(0, 0, 0),
  //     alignment: Alignment.topCenter,
  //     child: Text(
  //       episode.title,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontSize: 17,
  //         height: 1.4,
  //         fontWeight: FontWeight.w500,
  //         letterSpacing: 0.15,
  //         color: TWColors.gray.shade800,
  //       ),
  //       maxLines: 2,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );

  //   final artWork = ClipRRect(
  //     borderRadius: BorderRadius.circular(4.0),
  //     child: CachedNetworkImage(
  //       imageUrl: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
  //       fit: BoxFit.fill,
  //       height: 105,
  //       width: 105,
  //       placeholder: (BuildContext context, String url) => Container(
  //         height: 105,
  //         width: 105,
  //         color: TWColors.gray.shade300,
  //       ),
  //     ),
  //   );

  //   final publishDate = Text(
  //     'Published on 24 May, 2020',
  //     style: TextStyle(
  //       fontSize: 13.5,
  //       letterSpacing: 0.25,
  //       color: TWColors.gray.shade800,
  //     ),
  //   );

  //   final podcastTitle = RichText(
  //     overflow: TextOverflow.ellipsis,
  //     maxLines: 1,
  //     text: TextSpan(
  //       children: <TextSpan>[
  //         TextSpan(
  //           text: 'by ',
  //           style: TextStyle(
  //             fontSize: 13,
  //             letterSpacing: 0.25,
  //             color: TWColors.gray.shade700,
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //         TextSpan(
  //           text: podcast.title,
  //           style: TextStyle(
  //             fontSize: 14,
  //             letterSpacing: 0.25,
  //             color: TWColors.gray.shade700,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   final actions = Padding(
  //     padding: EdgeInsets.only(left: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         IconButton(
  //           icon: Icon(
  //             Icons.play_arrow,
  //             size: 22,
  //             color: TWColors.gray.shade700,
  //           ),
  //           onPressed: null,
  //         ),
  //         IconButton(
  //           icon: Icon(
  //             Icons.playlist_add,
  //             size: 26,
  //             color: TWColors.gray.shade700,
  //           ),
  //           onPressed: null,
  //         ),
  //         Container(width: 6),
  //         IconButton(
  //           icon: Icon(
  //             Icons.save_alt,
  //             size: 24,
  //             color: TWColors.gray.shade700,
  //           ),
  //           onPressed: null,
  //         ),
  //         Container(width: 6),
  //         IconButton(
  //           icon: Icon(
  //             Icons.share,
  //             size: 20,
  //             color: TWColors.gray.shade700,
  //           ),
  //           onPressed: null,
  //         ),
  //       ],
  //     ),
  //   );

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         episodeTitle,
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             artWork,
  //             Expanded(
  //               child: Container(
  //                 height: 115,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.max,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 16),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           publishDate,
  //                           Container(height: 6),
  //                           podcastTitle,
  //                         ],
  //                       ),
  //                     ),
  //                     actions,
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
