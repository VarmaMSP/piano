import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class QueueHeaderDelegate implements SliverPersistentHeaderDelegate {
  QueueHeaderDelegate({
    @required this.forceElevated,
    this.scrollToTop,
  });

  final bool forceElevated;
  final void Function() scrollToTop;

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return Container(
      height: maxExtent,
      padding: EdgeInsets.only(left: 14, right: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(-14, 0),
            child: Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: TWColors.gray.shade700,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: scrollToTop,
              child: Transform.translate(
                offset: Offset(-10, 0),
                child: Text(
                  'Queue',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: TWColors.gray.shade800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => audioPlayerBloc.transistionQueue(
              QueueTransistion.clearQueue(askUser: false),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
