// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/download_list_item/download_list_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'widgets/dowloads_header_delegate.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<List<AudioFile>>(
        stream: store.audioFile.watchAll(),
        builder: (context, snapshot) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: DownloadsHeaderDelegate(
                    forceElevated: innerBoxIsScrolled,
                    scrollToTop: () {},
                  ),
                ),
              ];
            },
            body: snapshot.hasData && snapshot.data.isNotEmpty
                ? CustomScrollView(
                    slivers: [_buildList(context, snapshot.data)],
                  )
                : Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(),
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 100),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🗄️',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 48),
                          ),
                          Container(height: 20),
                          Text(
                            'Your download list is empty',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      height: 1.5,
                                      color: TWColors.gray.shade900,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<AudioFile> audioFiles) {
    return SliverImplicitlyAnimatedList<AudioFile>(
      items: audioFiles,
      areItemsTheSame: (a, b) => a.episode.id == b.episode.id,
      itemBuilder: (context, animation, audioFile, index) => SizeFadeTransition(
        sizeFraction: 0.7,
        curve: Curves.easeInOut,
        animation: animation,
        child: DownloadListItem(audioFile: audioFile),
      ),
    );
  }
}
