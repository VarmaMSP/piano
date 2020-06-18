// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqldb.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PodcastRow extends DataClass implements Insertable<PodcastRow> {
  final String id;
  final String urlParam;
  final String title;
  final String description;
  final String language;
  final int explicit;
  final String author;
  final String type;
  final int complete;
  final String link;
  final String copyright;
  final int totalEpisodes;
  final int totalSeasons;
  final String feedUrl;
  PodcastRow(
      {@required this.id,
      @required this.urlParam,
      @required this.title,
      @required this.description,
      @required this.language,
      @required this.explicit,
      @required this.author,
      @required this.type,
      @required this.complete,
      @required this.link,
      @required this.copyright,
      @required this.totalEpisodes,
      @required this.totalSeasons,
      @required this.feedUrl});
  factory PodcastRow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return PodcastRow(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      urlParam: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}url_param']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
      explicit:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}explicit']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      complete:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}complete']),
      link: stringType.mapFromDatabaseResponse(data['${effectivePrefix}link']),
      copyright: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}copyright']),
      totalEpisodes: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_episodes']),
      totalSeasons: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_seasons']),
      feedUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}feed_url']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || urlParam != null) {
      map['url_param'] = Variable<String>(urlParam);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || explicit != null) {
      map['explicit'] = Variable<int>(explicit);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || complete != null) {
      map['complete'] = Variable<int>(complete);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || copyright != null) {
      map['copyright'] = Variable<String>(copyright);
    }
    if (!nullToAbsent || totalEpisodes != null) {
      map['total_episodes'] = Variable<int>(totalEpisodes);
    }
    if (!nullToAbsent || totalSeasons != null) {
      map['total_seasons'] = Variable<int>(totalSeasons);
    }
    if (!nullToAbsent || feedUrl != null) {
      map['feed_url'] = Variable<String>(feedUrl);
    }
    return map;
  }

  PodcastsCompanion toCompanion(bool nullToAbsent) {
    return PodcastsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      urlParam: urlParam == null && nullToAbsent
          ? const Value.absent()
          : Value(urlParam),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      explicit: explicit == null && nullToAbsent
          ? const Value.absent()
          : Value(explicit),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      complete: complete == null && nullToAbsent
          ? const Value.absent()
          : Value(complete),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      copyright: copyright == null && nullToAbsent
          ? const Value.absent()
          : Value(copyright),
      totalEpisodes: totalEpisodes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalEpisodes),
      totalSeasons: totalSeasons == null && nullToAbsent
          ? const Value.absent()
          : Value(totalSeasons),
      feedUrl: feedUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(feedUrl),
    );
  }

  factory PodcastRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PodcastRow(
      id: serializer.fromJson<String>(json['id']),
      urlParam: serializer.fromJson<String>(json['urlParam']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      language: serializer.fromJson<String>(json['language']),
      explicit: serializer.fromJson<int>(json['explicit']),
      author: serializer.fromJson<String>(json['author']),
      type: serializer.fromJson<String>(json['type']),
      complete: serializer.fromJson<int>(json['complete']),
      link: serializer.fromJson<String>(json['link']),
      copyright: serializer.fromJson<String>(json['copyright']),
      totalEpisodes: serializer.fromJson<int>(json['totalEpisodes']),
      totalSeasons: serializer.fromJson<int>(json['totalSeasons']),
      feedUrl: serializer.fromJson<String>(json['feedUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'urlParam': serializer.toJson<String>(urlParam),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'language': serializer.toJson<String>(language),
      'explicit': serializer.toJson<int>(explicit),
      'author': serializer.toJson<String>(author),
      'type': serializer.toJson<String>(type),
      'complete': serializer.toJson<int>(complete),
      'link': serializer.toJson<String>(link),
      'copyright': serializer.toJson<String>(copyright),
      'totalEpisodes': serializer.toJson<int>(totalEpisodes),
      'totalSeasons': serializer.toJson<int>(totalSeasons),
      'feedUrl': serializer.toJson<String>(feedUrl),
    };
  }

  PodcastRow copyWith(
          {String id,
          String urlParam,
          String title,
          String description,
          String language,
          int explicit,
          String author,
          String type,
          int complete,
          String link,
          String copyright,
          int totalEpisodes,
          int totalSeasons,
          String feedUrl}) =>
      PodcastRow(
        id: id ?? this.id,
        urlParam: urlParam ?? this.urlParam,
        title: title ?? this.title,
        description: description ?? this.description,
        language: language ?? this.language,
        explicit: explicit ?? this.explicit,
        author: author ?? this.author,
        type: type ?? this.type,
        complete: complete ?? this.complete,
        link: link ?? this.link,
        copyright: copyright ?? this.copyright,
        totalEpisodes: totalEpisodes ?? this.totalEpisodes,
        totalSeasons: totalSeasons ?? this.totalSeasons,
        feedUrl: feedUrl ?? this.feedUrl,
      );
  @override
  String toString() {
    return (StringBuffer('PodcastRow(')
          ..write('id: $id, ')
          ..write('urlParam: $urlParam, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('language: $language, ')
          ..write('explicit: $explicit, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('complete: $complete, ')
          ..write('link: $link, ')
          ..write('copyright: $copyright, ')
          ..write('totalEpisodes: $totalEpisodes, ')
          ..write('totalSeasons: $totalSeasons, ')
          ..write('feedUrl: $feedUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          urlParam.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      language.hashCode,
                      $mrjc(
                          explicit.hashCode,
                          $mrjc(
                              author.hashCode,
                              $mrjc(
                                  type.hashCode,
                                  $mrjc(
                                      complete.hashCode,
                                      $mrjc(
                                          link.hashCode,
                                          $mrjc(
                                              copyright.hashCode,
                                              $mrjc(
                                                  totalEpisodes.hashCode,
                                                  $mrjc(
                                                      totalSeasons.hashCode,
                                                      feedUrl
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PodcastRow &&
          other.id == this.id &&
          other.urlParam == this.urlParam &&
          other.title == this.title &&
          other.description == this.description &&
          other.language == this.language &&
          other.explicit == this.explicit &&
          other.author == this.author &&
          other.type == this.type &&
          other.complete == this.complete &&
          other.link == this.link &&
          other.copyright == this.copyright &&
          other.totalEpisodes == this.totalEpisodes &&
          other.totalSeasons == this.totalSeasons &&
          other.feedUrl == this.feedUrl);
}

class PodcastsCompanion extends UpdateCompanion<PodcastRow> {
  final Value<String> id;
  final Value<String> urlParam;
  final Value<String> title;
  final Value<String> description;
  final Value<String> language;
  final Value<int> explicit;
  final Value<String> author;
  final Value<String> type;
  final Value<int> complete;
  final Value<String> link;
  final Value<String> copyright;
  final Value<int> totalEpisodes;
  final Value<int> totalSeasons;
  final Value<String> feedUrl;
  const PodcastsCompanion({
    this.id = const Value.absent(),
    this.urlParam = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.language = const Value.absent(),
    this.explicit = const Value.absent(),
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.complete = const Value.absent(),
    this.link = const Value.absent(),
    this.copyright = const Value.absent(),
    this.totalEpisodes = const Value.absent(),
    this.totalSeasons = const Value.absent(),
    this.feedUrl = const Value.absent(),
  });
  PodcastsCompanion.insert({
    @required String id,
    @required String urlParam,
    @required String title,
    @required String description,
    @required String language,
    @required int explicit,
    @required String author,
    @required String type,
    @required int complete,
    @required String link,
    @required String copyright,
    @required int totalEpisodes,
    @required int totalSeasons,
    @required String feedUrl,
  })  : id = Value(id),
        urlParam = Value(urlParam),
        title = Value(title),
        description = Value(description),
        language = Value(language),
        explicit = Value(explicit),
        author = Value(author),
        type = Value(type),
        complete = Value(complete),
        link = Value(link),
        copyright = Value(copyright),
        totalEpisodes = Value(totalEpisodes),
        totalSeasons = Value(totalSeasons),
        feedUrl = Value(feedUrl);
  static Insertable<PodcastRow> custom({
    Expression<String> id,
    Expression<String> urlParam,
    Expression<String> title,
    Expression<String> description,
    Expression<String> language,
    Expression<int> explicit,
    Expression<String> author,
    Expression<String> type,
    Expression<int> complete,
    Expression<String> link,
    Expression<String> copyright,
    Expression<int> totalEpisodes,
    Expression<int> totalSeasons,
    Expression<String> feedUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (urlParam != null) 'url_param': urlParam,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (language != null) 'language': language,
      if (explicit != null) 'explicit': explicit,
      if (author != null) 'author': author,
      if (type != null) 'type': type,
      if (complete != null) 'complete': complete,
      if (link != null) 'link': link,
      if (copyright != null) 'copyright': copyright,
      if (totalEpisodes != null) 'total_episodes': totalEpisodes,
      if (totalSeasons != null) 'total_seasons': totalSeasons,
      if (feedUrl != null) 'feed_url': feedUrl,
    });
  }

  PodcastsCompanion copyWith(
      {Value<String> id,
      Value<String> urlParam,
      Value<String> title,
      Value<String> description,
      Value<String> language,
      Value<int> explicit,
      Value<String> author,
      Value<String> type,
      Value<int> complete,
      Value<String> link,
      Value<String> copyright,
      Value<int> totalEpisodes,
      Value<int> totalSeasons,
      Value<String> feedUrl}) {
    return PodcastsCompanion(
      id: id ?? this.id,
      urlParam: urlParam ?? this.urlParam,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      explicit: explicit ?? this.explicit,
      author: author ?? this.author,
      type: type ?? this.type,
      complete: complete ?? this.complete,
      link: link ?? this.link,
      copyright: copyright ?? this.copyright,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      totalSeasons: totalSeasons ?? this.totalSeasons,
      feedUrl: feedUrl ?? this.feedUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (urlParam.present) {
      map['url_param'] = Variable<String>(urlParam.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (explicit.present) {
      map['explicit'] = Variable<int>(explicit.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (complete.present) {
      map['complete'] = Variable<int>(complete.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (copyright.present) {
      map['copyright'] = Variable<String>(copyright.value);
    }
    if (totalEpisodes.present) {
      map['total_episodes'] = Variable<int>(totalEpisodes.value);
    }
    if (totalSeasons.present) {
      map['total_seasons'] = Variable<int>(totalSeasons.value);
    }
    if (feedUrl.present) {
      map['feed_url'] = Variable<String>(feedUrl.value);
    }
    return map;
  }
}

class $PodcastsTable extends Podcasts
    with TableInfo<$PodcastsTable, PodcastRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $PodcastsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _urlParamMeta = const VerificationMeta('urlParam');
  GeneratedTextColumn _urlParam;
  @override
  GeneratedTextColumn get urlParam => _urlParam ??= _constructUrlParam();
  GeneratedTextColumn _constructUrlParam() {
    return GeneratedTextColumn('url_param', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      false,
    );
  }

  final VerificationMeta _explicitMeta = const VerificationMeta('explicit');
  GeneratedIntColumn _explicit;
  @override
  GeneratedIntColumn get explicit => _explicit ??= _constructExplicit();
  GeneratedIntColumn _constructExplicit() {
    return GeneratedIntColumn(
      'explicit',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completeMeta = const VerificationMeta('complete');
  GeneratedIntColumn _complete;
  @override
  GeneratedIntColumn get complete => _complete ??= _constructComplete();
  GeneratedIntColumn _constructComplete() {
    return GeneratedIntColumn(
      'complete',
      $tableName,
      false,
    );
  }

  final VerificationMeta _linkMeta = const VerificationMeta('link');
  GeneratedTextColumn _link;
  @override
  GeneratedTextColumn get link => _link ??= _constructLink();
  GeneratedTextColumn _constructLink() {
    return GeneratedTextColumn(
      'link',
      $tableName,
      false,
    );
  }

  final VerificationMeta _copyrightMeta = const VerificationMeta('copyright');
  GeneratedTextColumn _copyright;
  @override
  GeneratedTextColumn get copyright => _copyright ??= _constructCopyright();
  GeneratedTextColumn _constructCopyright() {
    return GeneratedTextColumn(
      'copyright',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalEpisodesMeta =
      const VerificationMeta('totalEpisodes');
  GeneratedIntColumn _totalEpisodes;
  @override
  GeneratedIntColumn get totalEpisodes =>
      _totalEpisodes ??= _constructTotalEpisodes();
  GeneratedIntColumn _constructTotalEpisodes() {
    return GeneratedIntColumn(
      'total_episodes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalSeasonsMeta =
      const VerificationMeta('totalSeasons');
  GeneratedIntColumn _totalSeasons;
  @override
  GeneratedIntColumn get totalSeasons =>
      _totalSeasons ??= _constructTotalSeasons();
  GeneratedIntColumn _constructTotalSeasons() {
    return GeneratedIntColumn(
      'total_seasons',
      $tableName,
      false,
    );
  }

  final VerificationMeta _feedUrlMeta = const VerificationMeta('feedUrl');
  GeneratedTextColumn _feedUrl;
  @override
  GeneratedTextColumn get feedUrl => _feedUrl ??= _constructFeedUrl();
  GeneratedTextColumn _constructFeedUrl() {
    return GeneratedTextColumn(
      'feed_url',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        urlParam,
        title,
        description,
        language,
        explicit,
        author,
        type,
        complete,
        link,
        copyright,
        totalEpisodes,
        totalSeasons,
        feedUrl
      ];
  @override
  $PodcastsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'podcasts';
  @override
  final String actualTableName = 'podcasts';
  @override
  VerificationContext validateIntegrity(Insertable<PodcastRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url_param')) {
      context.handle(_urlParamMeta,
          urlParam.isAcceptableOrUnknown(data['url_param'], _urlParamMeta));
    } else if (isInserting) {
      context.missing(_urlParamMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language'], _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('explicit')) {
      context.handle(_explicitMeta,
          explicit.isAcceptableOrUnknown(data['explicit'], _explicitMeta));
    } else if (isInserting) {
      context.missing(_explicitMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete'], _completeMeta));
    } else if (isInserting) {
      context.missing(_completeMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link'], _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('copyright')) {
      context.handle(_copyrightMeta,
          copyright.isAcceptableOrUnknown(data['copyright'], _copyrightMeta));
    } else if (isInserting) {
      context.missing(_copyrightMeta);
    }
    if (data.containsKey('total_episodes')) {
      context.handle(
          _totalEpisodesMeta,
          totalEpisodes.isAcceptableOrUnknown(
              data['total_episodes'], _totalEpisodesMeta));
    } else if (isInserting) {
      context.missing(_totalEpisodesMeta);
    }
    if (data.containsKey('total_seasons')) {
      context.handle(
          _totalSeasonsMeta,
          totalSeasons.isAcceptableOrUnknown(
              data['total_seasons'], _totalSeasonsMeta));
    } else if (isInserting) {
      context.missing(_totalSeasonsMeta);
    }
    if (data.containsKey('feed_url')) {
      context.handle(_feedUrlMeta,
          feedUrl.isAcceptableOrUnknown(data['feed_url'], _feedUrlMeta));
    } else if (isInserting) {
      context.missing(_feedUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PodcastRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PodcastRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PodcastsTable createAlias(String alias) {
    return $PodcastsTable(_db, alias);
  }
}

class EpisodeRow extends DataClass implements Insertable<EpisodeRow> {
  final String id;
  final String podcastId;
  final String urlParam;
  final String title;
  final String mediaUrl;
  final String pubDate;
  final String summary;
  final String description;
  final int duration;
  final int explicit;
  final int episode;
  final int season;
  final String type;
  EpisodeRow(
      {@required this.id,
      @required this.podcastId,
      @required this.urlParam,
      @required this.title,
      @required this.mediaUrl,
      @required this.pubDate,
      @required this.summary,
      @required this.description,
      @required this.duration,
      @required this.explicit,
      @required this.episode,
      @required this.season,
      @required this.type});
  factory EpisodeRow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return EpisodeRow(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      podcastId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}podcast_id']),
      urlParam: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}url_param']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      mediaUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}media_url']),
      pubDate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pub_date']),
      summary:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}summary']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      duration:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      explicit:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}explicit']),
      episode:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}episode']),
      season: intType.mapFromDatabaseResponse(data['${effectivePrefix}season']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || podcastId != null) {
      map['podcast_id'] = Variable<String>(podcastId);
    }
    if (!nullToAbsent || urlParam != null) {
      map['url_param'] = Variable<String>(urlParam);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || mediaUrl != null) {
      map['media_url'] = Variable<String>(mediaUrl);
    }
    if (!nullToAbsent || pubDate != null) {
      map['pub_date'] = Variable<String>(pubDate);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || explicit != null) {
      map['explicit'] = Variable<int>(explicit);
    }
    if (!nullToAbsent || episode != null) {
      map['episode'] = Variable<int>(episode);
    }
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<int>(season);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  EpisodesCompanion toCompanion(bool nullToAbsent) {
    return EpisodesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      podcastId: podcastId == null && nullToAbsent
          ? const Value.absent()
          : Value(podcastId),
      urlParam: urlParam == null && nullToAbsent
          ? const Value.absent()
          : Value(urlParam),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      mediaUrl: mediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaUrl),
      pubDate: pubDate == null && nullToAbsent
          ? const Value.absent()
          : Value(pubDate),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      explicit: explicit == null && nullToAbsent
          ? const Value.absent()
          : Value(explicit),
      episode: episode == null && nullToAbsent
          ? const Value.absent()
          : Value(episode),
      season:
          season == null && nullToAbsent ? const Value.absent() : Value(season),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory EpisodeRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EpisodeRow(
      id: serializer.fromJson<String>(json['id']),
      podcastId: serializer.fromJson<String>(json['podcastId']),
      urlParam: serializer.fromJson<String>(json['urlParam']),
      title: serializer.fromJson<String>(json['title']),
      mediaUrl: serializer.fromJson<String>(json['mediaUrl']),
      pubDate: serializer.fromJson<String>(json['pubDate']),
      summary: serializer.fromJson<String>(json['summary']),
      description: serializer.fromJson<String>(json['description']),
      duration: serializer.fromJson<int>(json['duration']),
      explicit: serializer.fromJson<int>(json['explicit']),
      episode: serializer.fromJson<int>(json['episode']),
      season: serializer.fromJson<int>(json['season']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'podcastId': serializer.toJson<String>(podcastId),
      'urlParam': serializer.toJson<String>(urlParam),
      'title': serializer.toJson<String>(title),
      'mediaUrl': serializer.toJson<String>(mediaUrl),
      'pubDate': serializer.toJson<String>(pubDate),
      'summary': serializer.toJson<String>(summary),
      'description': serializer.toJson<String>(description),
      'duration': serializer.toJson<int>(duration),
      'explicit': serializer.toJson<int>(explicit),
      'episode': serializer.toJson<int>(episode),
      'season': serializer.toJson<int>(season),
      'type': serializer.toJson<String>(type),
    };
  }

  EpisodeRow copyWith(
          {String id,
          String podcastId,
          String urlParam,
          String title,
          String mediaUrl,
          String pubDate,
          String summary,
          String description,
          int duration,
          int explicit,
          int episode,
          int season,
          String type}) =>
      EpisodeRow(
        id: id ?? this.id,
        podcastId: podcastId ?? this.podcastId,
        urlParam: urlParam ?? this.urlParam,
        title: title ?? this.title,
        mediaUrl: mediaUrl ?? this.mediaUrl,
        pubDate: pubDate ?? this.pubDate,
        summary: summary ?? this.summary,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        explicit: explicit ?? this.explicit,
        episode: episode ?? this.episode,
        season: season ?? this.season,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('EpisodeRow(')
          ..write('id: $id, ')
          ..write('podcastId: $podcastId, ')
          ..write('urlParam: $urlParam, ')
          ..write('title: $title, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('pubDate: $pubDate, ')
          ..write('summary: $summary, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('explicit: $explicit, ')
          ..write('episode: $episode, ')
          ..write('season: $season, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          podcastId.hashCode,
          $mrjc(
              urlParam.hashCode,
              $mrjc(
                  title.hashCode,
                  $mrjc(
                      mediaUrl.hashCode,
                      $mrjc(
                          pubDate.hashCode,
                          $mrjc(
                              summary.hashCode,
                              $mrjc(
                                  description.hashCode,
                                  $mrjc(
                                      duration.hashCode,
                                      $mrjc(
                                          explicit.hashCode,
                                          $mrjc(
                                              episode.hashCode,
                                              $mrjc(season.hashCode,
                                                  type.hashCode)))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EpisodeRow &&
          other.id == this.id &&
          other.podcastId == this.podcastId &&
          other.urlParam == this.urlParam &&
          other.title == this.title &&
          other.mediaUrl == this.mediaUrl &&
          other.pubDate == this.pubDate &&
          other.summary == this.summary &&
          other.description == this.description &&
          other.duration == this.duration &&
          other.explicit == this.explicit &&
          other.episode == this.episode &&
          other.season == this.season &&
          other.type == this.type);
}

class EpisodesCompanion extends UpdateCompanion<EpisodeRow> {
  final Value<String> id;
  final Value<String> podcastId;
  final Value<String> urlParam;
  final Value<String> title;
  final Value<String> mediaUrl;
  final Value<String> pubDate;
  final Value<String> summary;
  final Value<String> description;
  final Value<int> duration;
  final Value<int> explicit;
  final Value<int> episode;
  final Value<int> season;
  final Value<String> type;
  const EpisodesCompanion({
    this.id = const Value.absent(),
    this.podcastId = const Value.absent(),
    this.urlParam = const Value.absent(),
    this.title = const Value.absent(),
    this.mediaUrl = const Value.absent(),
    this.pubDate = const Value.absent(),
    this.summary = const Value.absent(),
    this.description = const Value.absent(),
    this.duration = const Value.absent(),
    this.explicit = const Value.absent(),
    this.episode = const Value.absent(),
    this.season = const Value.absent(),
    this.type = const Value.absent(),
  });
  EpisodesCompanion.insert({
    @required String id,
    @required String podcastId,
    @required String urlParam,
    @required String title,
    @required String mediaUrl,
    @required String pubDate,
    @required String summary,
    @required String description,
    @required int duration,
    @required int explicit,
    @required int episode,
    @required int season,
    @required String type,
  })  : id = Value(id),
        podcastId = Value(podcastId),
        urlParam = Value(urlParam),
        title = Value(title),
        mediaUrl = Value(mediaUrl),
        pubDate = Value(pubDate),
        summary = Value(summary),
        description = Value(description),
        duration = Value(duration),
        explicit = Value(explicit),
        episode = Value(episode),
        season = Value(season),
        type = Value(type);
  static Insertable<EpisodeRow> custom({
    Expression<String> id,
    Expression<String> podcastId,
    Expression<String> urlParam,
    Expression<String> title,
    Expression<String> mediaUrl,
    Expression<String> pubDate,
    Expression<String> summary,
    Expression<String> description,
    Expression<int> duration,
    Expression<int> explicit,
    Expression<int> episode,
    Expression<int> season,
    Expression<String> type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (podcastId != null) 'podcast_id': podcastId,
      if (urlParam != null) 'url_param': urlParam,
      if (title != null) 'title': title,
      if (mediaUrl != null) 'media_url': mediaUrl,
      if (pubDate != null) 'pub_date': pubDate,
      if (summary != null) 'summary': summary,
      if (description != null) 'description': description,
      if (duration != null) 'duration': duration,
      if (explicit != null) 'explicit': explicit,
      if (episode != null) 'episode': episode,
      if (season != null) 'season': season,
      if (type != null) 'type': type,
    });
  }

  EpisodesCompanion copyWith(
      {Value<String> id,
      Value<String> podcastId,
      Value<String> urlParam,
      Value<String> title,
      Value<String> mediaUrl,
      Value<String> pubDate,
      Value<String> summary,
      Value<String> description,
      Value<int> duration,
      Value<int> explicit,
      Value<int> episode,
      Value<int> season,
      Value<String> type}) {
    return EpisodesCompanion(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      urlParam: urlParam ?? this.urlParam,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      pubDate: pubDate ?? this.pubDate,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      explicit: explicit ?? this.explicit,
      episode: episode ?? this.episode,
      season: season ?? this.season,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (urlParam.present) {
      map['url_param'] = Variable<String>(urlParam.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mediaUrl.present) {
      map['media_url'] = Variable<String>(mediaUrl.value);
    }
    if (pubDate.present) {
      map['pub_date'] = Variable<String>(pubDate.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (explicit.present) {
      map['explicit'] = Variable<int>(explicit.value);
    }
    if (episode.present) {
      map['episode'] = Variable<int>(episode.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }
}

class $EpisodesTable extends Episodes
    with TableInfo<$EpisodesTable, EpisodeRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $EpisodesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _podcastIdMeta = const VerificationMeta('podcastId');
  GeneratedTextColumn _podcastId;
  @override
  GeneratedTextColumn get podcastId => _podcastId ??= _constructPodcastId();
  GeneratedTextColumn _constructPodcastId() {
    return GeneratedTextColumn('podcast_id', $tableName, false,
        $customConstraints: 'REFERENCES podcasts(id)');
  }

  final VerificationMeta _urlParamMeta = const VerificationMeta('urlParam');
  GeneratedTextColumn _urlParam;
  @override
  GeneratedTextColumn get urlParam => _urlParam ??= _constructUrlParam();
  GeneratedTextColumn _constructUrlParam() {
    return GeneratedTextColumn('url_param', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mediaUrlMeta = const VerificationMeta('mediaUrl');
  GeneratedTextColumn _mediaUrl;
  @override
  GeneratedTextColumn get mediaUrl => _mediaUrl ??= _constructMediaUrl();
  GeneratedTextColumn _constructMediaUrl() {
    return GeneratedTextColumn(
      'media_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pubDateMeta = const VerificationMeta('pubDate');
  GeneratedTextColumn _pubDate;
  @override
  GeneratedTextColumn get pubDate => _pubDate ??= _constructPubDate();
  GeneratedTextColumn _constructPubDate() {
    return GeneratedTextColumn(
      'pub_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _summaryMeta = const VerificationMeta('summary');
  GeneratedTextColumn _summary;
  @override
  GeneratedTextColumn get summary => _summary ??= _constructSummary();
  GeneratedTextColumn _constructSummary() {
    return GeneratedTextColumn(
      'summary',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedIntColumn _duration;
  @override
  GeneratedIntColumn get duration => _duration ??= _constructDuration();
  GeneratedIntColumn _constructDuration() {
    return GeneratedIntColumn(
      'duration',
      $tableName,
      false,
    );
  }

  final VerificationMeta _explicitMeta = const VerificationMeta('explicit');
  GeneratedIntColumn _explicit;
  @override
  GeneratedIntColumn get explicit => _explicit ??= _constructExplicit();
  GeneratedIntColumn _constructExplicit() {
    return GeneratedIntColumn(
      'explicit',
      $tableName,
      false,
    );
  }

  final VerificationMeta _episodeMeta = const VerificationMeta('episode');
  GeneratedIntColumn _episode;
  @override
  GeneratedIntColumn get episode => _episode ??= _constructEpisode();
  GeneratedIntColumn _constructEpisode() {
    return GeneratedIntColumn(
      'episode',
      $tableName,
      false,
    );
  }

  final VerificationMeta _seasonMeta = const VerificationMeta('season');
  GeneratedIntColumn _season;
  @override
  GeneratedIntColumn get season => _season ??= _constructSeason();
  GeneratedIntColumn _constructSeason() {
    return GeneratedIntColumn(
      'season',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        podcastId,
        urlParam,
        title,
        mediaUrl,
        pubDate,
        summary,
        description,
        duration,
        explicit,
        episode,
        season,
        type
      ];
  @override
  $EpisodesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'episodes';
  @override
  final String actualTableName = 'episodes';
  @override
  VerificationContext validateIntegrity(Insertable<EpisodeRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('podcast_id')) {
      context.handle(_podcastIdMeta,
          podcastId.isAcceptableOrUnknown(data['podcast_id'], _podcastIdMeta));
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('url_param')) {
      context.handle(_urlParamMeta,
          urlParam.isAcceptableOrUnknown(data['url_param'], _urlParamMeta));
    } else if (isInserting) {
      context.missing(_urlParamMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('media_url')) {
      context.handle(_mediaUrlMeta,
          mediaUrl.isAcceptableOrUnknown(data['media_url'], _mediaUrlMeta));
    } else if (isInserting) {
      context.missing(_mediaUrlMeta);
    }
    if (data.containsKey('pub_date')) {
      context.handle(_pubDateMeta,
          pubDate.isAcceptableOrUnknown(data['pub_date'], _pubDateMeta));
    } else if (isInserting) {
      context.missing(_pubDateMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary'], _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('explicit')) {
      context.handle(_explicitMeta,
          explicit.isAcceptableOrUnknown(data['explicit'], _explicitMeta));
    } else if (isInserting) {
      context.missing(_explicitMeta);
    }
    if (data.containsKey('episode')) {
      context.handle(_episodeMeta,
          episode.isAcceptableOrUnknown(data['episode'], _episodeMeta));
    } else if (isInserting) {
      context.missing(_episodeMeta);
    }
    if (data.containsKey('season')) {
      context.handle(_seasonMeta,
          season.isAcceptableOrUnknown(data['season'], _seasonMeta));
    } else if (isInserting) {
      context.missing(_seasonMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EpisodeRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EpisodeRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EpisodesTable createAlias(String alias) {
    return $EpisodesTable(_db, alias);
  }
}

class AudioTrackRow extends DataClass implements Insertable<AudioTrackRow> {
  final int position;
  final String episodeId;
  AudioTrackRow({@required this.position, @required this.episodeId});
  factory AudioTrackRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AudioTrackRow(
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      episodeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}episode_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<int>(position);
    }
    if (!nullToAbsent || episodeId != null) {
      map['episode_id'] = Variable<String>(episodeId);
    }
    return map;
  }

  AudioTracksCompanion toCompanion(bool nullToAbsent) {
    return AudioTracksCompanion(
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      episodeId: episodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeId),
    );
  }

  factory AudioTrackRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudioTrackRow(
      position: serializer.fromJson<int>(json['position']),
      episodeId: serializer.fromJson<String>(json['episodeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'episodeId': serializer.toJson<String>(episodeId),
    };
  }

  AudioTrackRow copyWith({int position, String episodeId}) => AudioTrackRow(
        position: position ?? this.position,
        episodeId: episodeId ?? this.episodeId,
      );
  @override
  String toString() {
    return (StringBuffer('AudioTrackRow(')
          ..write('position: $position, ')
          ..write('episodeId: $episodeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(position.hashCode, episodeId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudioTrackRow &&
          other.position == this.position &&
          other.episodeId == this.episodeId);
}

class AudioTracksCompanion extends UpdateCompanion<AudioTrackRow> {
  final Value<int> position;
  final Value<String> episodeId;
  const AudioTracksCompanion({
    this.position = const Value.absent(),
    this.episodeId = const Value.absent(),
  });
  AudioTracksCompanion.insert({
    this.position = const Value.absent(),
    @required String episodeId,
  }) : episodeId = Value(episodeId);
  static Insertable<AudioTrackRow> custom({
    Expression<int> position,
    Expression<String> episodeId,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (episodeId != null) 'episode_id': episodeId,
    });
  }

  AudioTracksCompanion copyWith(
      {Value<int> position, Value<String> episodeId}) {
    return AudioTracksCompanion(
      position: position ?? this.position,
      episodeId: episodeId ?? this.episodeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (episodeId.present) {
      map['episode_id'] = Variable<String>(episodeId.value);
    }
    return map;
  }
}

class $AudioTracksTable extends AudioTracks
    with TableInfo<$AudioTracksTable, AudioTrackRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudioTracksTable(this._db, [this._alias]);
  final VerificationMeta _positionMeta = const VerificationMeta('position');
  GeneratedIntColumn _position;
  @override
  GeneratedIntColumn get position => _position ??= _constructPosition();
  GeneratedIntColumn _constructPosition() {
    return GeneratedIntColumn(
      'position',
      $tableName,
      false,
    );
  }

  final VerificationMeta _episodeIdMeta = const VerificationMeta('episodeId');
  GeneratedTextColumn _episodeId;
  @override
  GeneratedTextColumn get episodeId => _episodeId ??= _constructEpisodeId();
  GeneratedTextColumn _constructEpisodeId() {
    return GeneratedTextColumn('episode_id', $tableName, false,
        $customConstraints: 'REFERENCES episodes(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [position, episodeId];
  @override
  $AudioTracksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audio_tracks';
  @override
  final String actualTableName = 'audio_tracks';
  @override
  VerificationContext validateIntegrity(Insertable<AudioTrackRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    }
    if (data.containsKey('episode_id')) {
      context.handle(_episodeIdMeta,
          episodeId.isAcceptableOrUnknown(data['episode_id'], _episodeIdMeta));
    } else if (isInserting) {
      context.missing(_episodeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {position};
  @override
  AudioTrackRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudioTrackRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AudioTracksTable createAlias(String alias) {
    return $AudioTracksTable(_db, alias);
  }
}

class AudioPlayerSnapshotRow extends DataClass
    implements Insertable<AudioPlayerSnapshotRow> {
  final int id;
  final int queuePosition;
  final bool queueEnabled;
  AudioPlayerSnapshotRow(
      {@required this.id,
      @required this.queuePosition,
      @required this.queueEnabled});
  factory AudioPlayerSnapshotRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return AudioPlayerSnapshotRow(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      queuePosition: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}queue_position']),
      queueEnabled: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}queue_enabled']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || queuePosition != null) {
      map['queue_position'] = Variable<int>(queuePosition);
    }
    if (!nullToAbsent || queueEnabled != null) {
      map['queue_enabled'] = Variable<bool>(queueEnabled);
    }
    return map;
  }

  AudioPlayerSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return AudioPlayerSnapshotsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      queuePosition: queuePosition == null && nullToAbsent
          ? const Value.absent()
          : Value(queuePosition),
      queueEnabled: queueEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(queueEnabled),
    );
  }

  factory AudioPlayerSnapshotRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudioPlayerSnapshotRow(
      id: serializer.fromJson<int>(json['id']),
      queuePosition: serializer.fromJson<int>(json['queuePosition']),
      queueEnabled: serializer.fromJson<bool>(json['queueEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'queuePosition': serializer.toJson<int>(queuePosition),
      'queueEnabled': serializer.toJson<bool>(queueEnabled),
    };
  }

  AudioPlayerSnapshotRow copyWith(
          {int id, int queuePosition, bool queueEnabled}) =>
      AudioPlayerSnapshotRow(
        id: id ?? this.id,
        queuePosition: queuePosition ?? this.queuePosition,
        queueEnabled: queueEnabled ?? this.queueEnabled,
      );
  @override
  String toString() {
    return (StringBuffer('AudioPlayerSnapshotRow(')
          ..write('id: $id, ')
          ..write('queuePosition: $queuePosition, ')
          ..write('queueEnabled: $queueEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(queuePosition.hashCode, queueEnabled.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudioPlayerSnapshotRow &&
          other.id == this.id &&
          other.queuePosition == this.queuePosition &&
          other.queueEnabled == this.queueEnabled);
}

class AudioPlayerSnapshotsCompanion
    extends UpdateCompanion<AudioPlayerSnapshotRow> {
  final Value<int> id;
  final Value<int> queuePosition;
  final Value<bool> queueEnabled;
  const AudioPlayerSnapshotsCompanion({
    this.id = const Value.absent(),
    this.queuePosition = const Value.absent(),
    this.queueEnabled = const Value.absent(),
  });
  AudioPlayerSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    @required int queuePosition,
    @required bool queueEnabled,
  })  : queuePosition = Value(queuePosition),
        queueEnabled = Value(queueEnabled);
  static Insertable<AudioPlayerSnapshotRow> custom({
    Expression<int> id,
    Expression<int> queuePosition,
    Expression<bool> queueEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queuePosition != null) 'queue_position': queuePosition,
      if (queueEnabled != null) 'queue_enabled': queueEnabled,
    });
  }

  AudioPlayerSnapshotsCompanion copyWith(
      {Value<int> id, Value<int> queuePosition, Value<bool> queueEnabled}) {
    return AudioPlayerSnapshotsCompanion(
      id: id ?? this.id,
      queuePosition: queuePosition ?? this.queuePosition,
      queueEnabled: queueEnabled ?? this.queueEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (queuePosition.present) {
      map['queue_position'] = Variable<int>(queuePosition.value);
    }
    if (queueEnabled.present) {
      map['queue_enabled'] = Variable<bool>(queueEnabled.value);
    }
    return map;
  }
}

class $AudioPlayerSnapshotsTable extends AudioPlayerSnapshots
    with TableInfo<$AudioPlayerSnapshotsTable, AudioPlayerSnapshotRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudioPlayerSnapshotsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _queuePositionMeta =
      const VerificationMeta('queuePosition');
  GeneratedIntColumn _queuePosition;
  @override
  GeneratedIntColumn get queuePosition =>
      _queuePosition ??= _constructQueuePosition();
  GeneratedIntColumn _constructQueuePosition() {
    return GeneratedIntColumn(
      'queue_position',
      $tableName,
      false,
    );
  }

  final VerificationMeta _queueEnabledMeta =
      const VerificationMeta('queueEnabled');
  GeneratedBoolColumn _queueEnabled;
  @override
  GeneratedBoolColumn get queueEnabled =>
      _queueEnabled ??= _constructQueueEnabled();
  GeneratedBoolColumn _constructQueueEnabled() {
    return GeneratedBoolColumn(
      'queue_enabled',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, queuePosition, queueEnabled];
  @override
  $AudioPlayerSnapshotsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audio_player_snapshots';
  @override
  final String actualTableName = 'audio_player_snapshots';
  @override
  VerificationContext validateIntegrity(
      Insertable<AudioPlayerSnapshotRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('queue_position')) {
      context.handle(
          _queuePositionMeta,
          queuePosition.isAcceptableOrUnknown(
              data['queue_position'], _queuePositionMeta));
    } else if (isInserting) {
      context.missing(_queuePositionMeta);
    }
    if (data.containsKey('queue_enabled')) {
      context.handle(
          _queueEnabledMeta,
          queueEnabled.isAcceptableOrUnknown(
              data['queue_enabled'], _queueEnabledMeta));
    } else if (isInserting) {
      context.missing(_queueEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioPlayerSnapshotRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudioPlayerSnapshotRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AudioPlayerSnapshotsTable createAlias(String alias) {
    return $AudioPlayerSnapshotsTable(_db, alias);
  }
}

abstract class _$SqlDb extends GeneratedDatabase {
  _$SqlDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$SqlDb.connect(DatabaseConnection c) : super.connect(c);
  $PodcastsTable _podcasts;
  $PodcastsTable get podcasts => _podcasts ??= $PodcastsTable(this);
  $EpisodesTable _episodes;
  $EpisodesTable get episodes => _episodes ??= $EpisodesTable(this);
  $AudioTracksTable _audioTracks;
  $AudioTracksTable get audioTracks => _audioTracks ??= $AudioTracksTable(this);
  $AudioPlayerSnapshotsTable _audioPlayerSnapshots;
  $AudioPlayerSnapshotsTable get audioPlayerSnapshots =>
      _audioPlayerSnapshots ??= $AudioPlayerSnapshotsTable(this);
  PodcastDao _podcastDao;
  PodcastDao get podcastDao => _podcastDao ??= PodcastDao(this as SqlDb);
  AudioPlayerDao _audioPlayerDao;
  AudioPlayerDao get audioPlayerDao =>
      _audioPlayerDao ??= AudioPlayerDao(this as SqlDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [podcasts, episodes, audioTracks, audioPlayerSnapshots];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PodcastDaoMixin on DatabaseAccessor<SqlDb> {
  $PodcastsTable get podcasts => attachedDatabase.podcasts;
  $EpisodesTable get episodes => attachedDatabase.episodes;
}
mixin _$AudioPlayerDaoMixin on DatabaseAccessor<SqlDb> {
  $PodcastsTable get podcasts => attachedDatabase.podcasts;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $AudioTracksTable get audioTracks => attachedDatabase.audioTracks;
  $AudioPlayerSnapshotsTable get audioPlayerSnapshots =>
      attachedDatabase.audioPlayerSnapshots;
}
