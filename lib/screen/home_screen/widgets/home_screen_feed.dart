// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/icon.dart';
import 'package:phenopod/widgets/link.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';

class HomeScreenFeed extends StatelessWidget {
  const HomeScreenFeed({
    Key key,
    @required this.trending,
    @required this.categories,
  }) : super(key: key);

  final List<Podcast> trending;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 10.0,
              bottom: 15.0,
            ),
            child: Text(
              'Trending',
              style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
                color: TWColors.gray.shade800,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: _buildTrending()),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 5.0,
              bottom: 10.0,
            ),
            child: Text(
              'Browse by category',
              style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
                color: TWColors.gray.shade800,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildCategory(context, categories[index]);
            },
            childCount: categories.length,
          ),
        ),
        SliverToBoxAdapter(child: Container(height: 20)),
      ],
    );
  }

  Widget _buildTrending() {
    return Container(
      child: Container(
        height: 220,
        padding: const EdgeInsets.only(
          bottom: 25.0,
        ),
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PodcastLink(
                      podcast: trending[index],
                      child: Container(
                        child: PodcastThumbnail(
                          podcast: trending[index],
                          size: PodcastThumbnailSize.sm,
                        ),
                      ),
                    );
                  },
                  childCount: trending.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, Category category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 14),
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: TWColors.gray.shade300, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          Icon(
            getCategoryIcon(category.id),
            size: 22,
            color: TWColors.gray.shade700,
          ),
          Container(width: 14),
          Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontSize: 16, color: TWColors.gray.shade900),
          ),
        ],
      ),
    );
  }
}
