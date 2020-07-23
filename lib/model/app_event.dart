// Package imports:
import 'package:phenopod/model/podcast.dart';
import 'package:super_enum/super_enum.dart';

part 'app_event.g.dart';

@superEnum
enum _AppEvent {
  @Data(fields: [DataField<Podcast>('podcast'), DataField<bool>('synced')])
  Subscribe,
  @Data(fields: [DataField<Podcast>('podcast'), DataField<bool>('synced')])
  Unsubscribe,
}
