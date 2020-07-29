// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'db.dart';

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
  final bool cachedAllEpisodes;
  final DateTime cacheUpdatedAt;
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
      @required this.feedUrl,
      this.cachedAllEpisodes,
      @required this.cacheUpdatedAt});
  factory PodcastRow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
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
      cachedAllEpisodes: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}cached_all_episodes']),
      cacheUpdatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}cache_updated_at']),
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
    if (!nullToAbsent || cachedAllEpisodes != null) {
      map['cached_all_episodes'] = Variable<bool>(cachedAllEpisodes);
    }
    if (!nullToAbsent || cacheUpdatedAt != null) {
      map['cache_updated_at'] = Variable<DateTime>(cacheUpdatedAt);
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
      cachedAllEpisodes: cachedAllEpisodes == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedAllEpisodes),
      cacheUpdatedAt: cacheUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cacheUpdatedAt),
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
      cachedAllEpisodes: serializer.fromJson<bool>(json['cachedAllEpisodes']),
      cacheUpdatedAt: serializer.fromJson<DateTime>(json['cacheUpdatedAt']),
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
      'cachedAllEpisodes': serializer.toJson<bool>(cachedAllEpisodes),
      'cacheUpdatedAt': serializer.toJson<DateTime>(cacheUpdatedAt),
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
          String feedUrl,
          bool cachedAllEpisodes,
          DateTime cacheUpdatedAt}) =>
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
        cachedAllEpisodes: cachedAllEpisodes ?? this.cachedAllEpisodes,
        cacheUpdatedAt: cacheUpdatedAt ?? this.cacheUpdatedAt,
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
          ..write('feedUrl: $feedUrl, ')
          ..write('cachedAllEpisodes: $cachedAllEpisodes, ')
          ..write('cacheUpdatedAt: $cacheUpdatedAt')
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
                                                      $mrjc(
                                                          feedUrl.hashCode,
                                                          $mrjc(
                                                              cachedAllEpisodes
                                                                  .hashCode,
                                                              cacheUpdatedAt
                                                                  .hashCode))))))))))))))));
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
          other.feedUrl == this.feedUrl &&
          other.cachedAllEpisodes == this.cachedAllEpisodes &&
          other.cacheUpdatedAt == this.cacheUpdatedAt);
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
  final Value<bool> cachedAllEpisodes;
  final Value<DateTime> cacheUpdatedAt;
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
    this.cachedAllEpisodes = const Value.absent(),
    this.cacheUpdatedAt = const Value.absent(),
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
    this.cachedAllEpisodes = const Value.absent(),
    @required DateTime cacheUpdatedAt,
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
        feedUrl = Value(feedUrl),
        cacheUpdatedAt = Value(cacheUpdatedAt);
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
    Expression<bool> cachedAllEpisodes,
    Expression<DateTime> cacheUpdatedAt,
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
      if (cachedAllEpisodes != null) 'cached_all_episodes': cachedAllEpisodes,
      if (cacheUpdatedAt != null) 'cache_updated_at': cacheUpdatedAt,
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
      Value<String> feedUrl,
      Value<bool> cachedAllEpisodes,
      Value<DateTime> cacheUpdatedAt}) {
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
      cachedAllEpisodes: cachedAllEpisodes ?? this.cachedAllEpisodes,
      cacheUpdatedAt: cacheUpdatedAt ?? this.cacheUpdatedAt,
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
    if (cachedAllEpisodes.present) {
      map['cached_all_episodes'] = Variable<bool>(cachedAllEpisodes.value);
    }
    if (cacheUpdatedAt.present) {
      map['cache_updated_at'] = Variable<DateTime>(cacheUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PodcastsCompanion(')
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
          ..write('feedUrl: $feedUrl, ')
          ..write('cachedAllEpisodes: $cachedAllEpisodes, ')
          ..write('cacheUpdatedAt: $cacheUpdatedAt')
          ..write(')'))
        .toString();
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

  final VerificationMeta _cachedAllEpisodesMeta =
      const VerificationMeta('cachedAllEpisodes');
  GeneratedBoolColumn _cachedAllEpisodes;
  @override
  GeneratedBoolColumn get cachedAllEpisodes =>
      _cachedAllEpisodes ??= _constructCachedAllEpisodes();
  GeneratedBoolColumn _constructCachedAllEpisodes() {
    return GeneratedBoolColumn(
      'cached_all_episodes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cacheUpdatedAtMeta =
      const VerificationMeta('cacheUpdatedAt');
  GeneratedDateTimeColumn _cacheUpdatedAt;
  @override
  GeneratedDateTimeColumn get cacheUpdatedAt =>
      _cacheUpdatedAt ??= _constructCacheUpdatedAt();
  GeneratedDateTimeColumn _constructCacheUpdatedAt() {
    return GeneratedDateTimeColumn(
      'cache_updated_at',
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
        feedUrl,
        cachedAllEpisodes,
        cacheUpdatedAt
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
    if (data.containsKey('cached_all_episodes')) {
      context.handle(
          _cachedAllEpisodesMeta,
          cachedAllEpisodes.isAcceptableOrUnknown(
              data['cached_all_episodes'], _cachedAllEpisodesMeta));
    }
    if (data.containsKey('cache_updated_at')) {
      context.handle(
          _cacheUpdatedAtMeta,
          cacheUpdatedAt.isAcceptableOrUnknown(
              data['cache_updated_at'], _cacheUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_cacheUpdatedAtMeta);
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
  final DateTime pubDate;
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
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
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
      pubDate: dateTimeType
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
      map['pub_date'] = Variable<DateTime>(pubDate);
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
      pubDate: serializer.fromJson<DateTime>(json['pubDate']),
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
      'pubDate': serializer.toJson<DateTime>(pubDate),
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
          DateTime pubDate,
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
  final Value<DateTime> pubDate;
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
    @required DateTime pubDate,
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
    Expression<DateTime> pubDate,
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
      Value<DateTime> pubDate,
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
      map['pub_date'] = Variable<DateTime>(pubDate.value);
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

  @override
  String toString() {
    return (StringBuffer('EpisodesCompanion(')
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
  GeneratedDateTimeColumn _pubDate;
  @override
  GeneratedDateTimeColumn get pubDate => _pubDate ??= _constructPubDate();
  GeneratedDateTimeColumn _constructPubDate() {
    return GeneratedDateTimeColumn(
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

  @override
  String toString() {
    return (StringBuffer('AudioTracksCompanion(')
          ..write('position: $position, ')
          ..write('episodeId: $episodeId')
          ..write(')'))
        .toString();
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

class PlaybackPositionRow extends DataClass
    implements Insertable<PlaybackPositionRow> {
  final String episodeId;
  final int position;
  final int duration;
  final DateTime updatedAt;
  PlaybackPositionRow(
      {@required this.episodeId,
      @required this.position,
      @required this.duration,
      @required this.updatedAt});
  factory PlaybackPositionRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return PlaybackPositionRow(
      episodeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}episode_id']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      duration:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || episodeId != null) {
      map['episode_id'] = Variable<String>(episodeId);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<int>(position);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PlaybackPositionsCompanion toCompanion(bool nullToAbsent) {
    return PlaybackPositionsCompanion(
      episodeId: episodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeId),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PlaybackPositionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PlaybackPositionRow(
      episodeId: serializer.fromJson<String>(json['episodeId']),
      position: serializer.fromJson<int>(json['position']),
      duration: serializer.fromJson<int>(json['duration']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'episodeId': serializer.toJson<String>(episodeId),
      'position': serializer.toJson<int>(position),
      'duration': serializer.toJson<int>(duration),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlaybackPositionRow copyWith(
          {String episodeId, int position, int duration, DateTime updatedAt}) =>
      PlaybackPositionRow(
        episodeId: episodeId ?? this.episodeId,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PlaybackPositionRow(')
          ..write('episodeId: $episodeId, ')
          ..write('position: $position, ')
          ..write('duration: $duration, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(episodeId.hashCode,
      $mrjc(position.hashCode, $mrjc(duration.hashCode, updatedAt.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PlaybackPositionRow &&
          other.episodeId == this.episodeId &&
          other.position == this.position &&
          other.duration == this.duration &&
          other.updatedAt == this.updatedAt);
}

class PlaybackPositionsCompanion extends UpdateCompanion<PlaybackPositionRow> {
  final Value<String> episodeId;
  final Value<int> position;
  final Value<int> duration;
  final Value<DateTime> updatedAt;
  const PlaybackPositionsCompanion({
    this.episodeId = const Value.absent(),
    this.position = const Value.absent(),
    this.duration = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlaybackPositionsCompanion.insert({
    @required String episodeId,
    @required int position,
    @required int duration,
    @required DateTime updatedAt,
  })  : episodeId = Value(episodeId),
        position = Value(position),
        duration = Value(duration),
        updatedAt = Value(updatedAt);
  static Insertable<PlaybackPositionRow> custom({
    Expression<String> episodeId,
    Expression<int> position,
    Expression<int> duration,
    Expression<DateTime> updatedAt,
  }) {
    return RawValuesInsertable({
      if (episodeId != null) 'episode_id': episodeId,
      if (position != null) 'position': position,
      if (duration != null) 'duration': duration,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlaybackPositionsCompanion copyWith(
      {Value<String> episodeId,
      Value<int> position,
      Value<int> duration,
      Value<DateTime> updatedAt}) {
    return PlaybackPositionsCompanion(
      episodeId: episodeId ?? this.episodeId,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (episodeId.present) {
      map['episode_id'] = Variable<String>(episodeId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackPositionsCompanion(')
          ..write('episodeId: $episodeId, ')
          ..write('position: $position, ')
          ..write('duration: $duration, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlaybackPositionsTable extends PlaybackPositions
    with TableInfo<$PlaybackPositionsTable, PlaybackPositionRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlaybackPositionsTable(this._db, [this._alias]);
  final VerificationMeta _episodeIdMeta = const VerificationMeta('episodeId');
  GeneratedTextColumn _episodeId;
  @override
  GeneratedTextColumn get episodeId => _episodeId ??= _constructEpisodeId();
  GeneratedTextColumn _constructEpisodeId() {
    return GeneratedTextColumn('episode_id', $tableName, false,
        $customConstraints: 'REFERENCES episodes(id)');
  }

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

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [episodeId, position, duration, updatedAt];
  @override
  $PlaybackPositionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'playback_positions';
  @override
  final String actualTableName = 'playback_positions';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaybackPositionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('episode_id')) {
      context.handle(_episodeIdMeta,
          episodeId.isAcceptableOrUnknown(data['episode_id'], _episodeIdMeta));
    } else if (isInserting) {
      context.missing(_episodeIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {episodeId};
  @override
  PlaybackPositionRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PlaybackPositionRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PlaybackPositionsTable createAlias(String alias) {
    return $PlaybackPositionsTable(_db, alias);
  }
}

class PreferenceRow extends DataClass implements Insertable<PreferenceRow> {
  final String key;
  final PreferenceValue value;
  PreferenceRow({@required this.key, this.value});
  factory PreferenceRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return PreferenceRow(
      key: stringType.mapFromDatabaseResponse(data['${effectivePrefix}key']),
      value: $PreferencesTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || value != null) {
      final converter = $PreferencesTable.$converter0;
      map['value'] = Variable<String>(converter.mapToSql(value));
    }
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory PreferenceRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PreferenceRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<PreferenceValue>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<PreferenceValue>(value),
    };
  }

  PreferenceRow copyWith({String key, PreferenceValue value}) => PreferenceRow(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('PreferenceRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(key.hashCode, value.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PreferenceRow &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferencesCompanion extends UpdateCompanion<PreferenceRow> {
  final Value<String> key;
  final Value<PreferenceValue> value;
  const PreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  PreferencesCompanion.insert({
    @required String key,
    this.value = const Value.absent(),
  }) : key = Value(key);
  static Insertable<PreferenceRow> custom({
    Expression<String> key,
    Expression<String> value,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  PreferencesCompanion copyWith(
      {Value<String> key, Value<PreferenceValue> value}) {
    return PreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      final converter = $PreferencesTable.$converter0;
      map['value'] = Variable<String>(converter.mapToSql(value.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, PreferenceRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $PreferencesTable(this._db, [this._alias]);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedTextColumn _key;
  @override
  GeneratedTextColumn get key => _key ??= _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedTextColumn _value;
  @override
  GeneratedTextColumn get value => _value ??= _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn(
      'value',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  $PreferencesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'preferences';
  @override
  final String actualTableName = 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<PreferenceRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key'], _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    context.handle(_valueMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  PreferenceRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PreferenceRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(_db, alias);
  }

  static TypeConverter<PreferenceValue, String> $converter0 =
      PreferenceValueTypeConverter();
}

class SubscriptionRow extends DataClass implements Insertable<SubscriptionRow> {
  final String podcastId;
  final DateTime updatedAt;
  SubscriptionRow({@required this.podcastId, @required this.updatedAt});
  factory SubscriptionRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SubscriptionRow(
      podcastId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}podcast_id']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || podcastId != null) {
      map['podcast_id'] = Variable<String>(podcastId);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      podcastId: podcastId == null && nullToAbsent
          ? const Value.absent()
          : Value(podcastId),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SubscriptionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SubscriptionRow(
      podcastId: serializer.fromJson<String>(json['podcastId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'podcastId': serializer.toJson<String>(podcastId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SubscriptionRow copyWith({String podcastId, DateTime updatedAt}) =>
      SubscriptionRow(
        podcastId: podcastId ?? this.podcastId,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SubscriptionRow(')
          ..write('podcastId: $podcastId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(podcastId.hashCode, updatedAt.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SubscriptionRow &&
          other.podcastId == this.podcastId &&
          other.updatedAt == this.updatedAt);
}

class SubscriptionsCompanion extends UpdateCompanion<SubscriptionRow> {
  final Value<String> podcastId;
  final Value<DateTime> updatedAt;
  const SubscriptionsCompanion({
    this.podcastId = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    @required String podcastId,
    @required DateTime updatedAt,
  })  : podcastId = Value(podcastId),
        updatedAt = Value(updatedAt);
  static Insertable<SubscriptionRow> custom({
    Expression<String> podcastId,
    Expression<DateTime> updatedAt,
  }) {
    return RawValuesInsertable({
      if (podcastId != null) 'podcast_id': podcastId,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubscriptionsCompanion copyWith(
      {Value<String> podcastId, Value<DateTime> updatedAt}) {
    return SubscriptionsCompanion(
      podcastId: podcastId ?? this.podcastId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (podcastId.present) {
      map['podcast_id'] = Variable<String>(podcastId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('podcastId: $podcastId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, SubscriptionRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubscriptionsTable(this._db, [this._alias]);
  final VerificationMeta _podcastIdMeta = const VerificationMeta('podcastId');
  GeneratedTextColumn _podcastId;
  @override
  GeneratedTextColumn get podcastId => _podcastId ??= _constructPodcastId();
  GeneratedTextColumn _constructPodcastId() {
    return GeneratedTextColumn('podcast_id', $tableName, false,
        $customConstraints: 'REFERENCES podcasts(id)');
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [podcastId, updatedAt];
  @override
  $SubscriptionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subscriptions';
  @override
  final String actualTableName = 'subscriptions';
  @override
  VerificationContext validateIntegrity(Insertable<SubscriptionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('podcast_id')) {
      context.handle(_podcastIdMeta,
          podcastId.isAcceptableOrUnknown(data['podcast_id'], _podcastIdMeta));
    } else if (isInserting) {
      context.missing(_podcastIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {podcastId};
  @override
  SubscriptionRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubscriptionRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(_db, alias);
  }
}

class SubscriptionFilterRow extends DataClass
    implements Insertable<SubscriptionFilterRow> {
  final String id;
  final String name;
  final DateTime updatedAt;
  SubscriptionFilterRow(
      {@required this.id, @required this.name, @required this.updatedAt});
  factory SubscriptionFilterRow.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SubscriptionFilterRow(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SubscriptionFiltersCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionFiltersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SubscriptionFilterRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SubscriptionFilterRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SubscriptionFilterRow copyWith(
          {String id, String name, DateTime updatedAt}) =>
      SubscriptionFilterRow(
        id: id ?? this.id,
        name: name ?? this.name,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SubscriptionFilterRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, updatedAt.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SubscriptionFilterRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.updatedAt == this.updatedAt);
}

class SubscriptionFiltersCompanion
    extends UpdateCompanion<SubscriptionFilterRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> updatedAt;
  const SubscriptionFiltersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubscriptionFiltersCompanion.insert({
    @required String id,
    @required String name,
    @required DateTime updatedAt,
  })  : id = Value(id),
        name = Value(name),
        updatedAt = Value(updatedAt);
  static Insertable<SubscriptionFilterRow> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<DateTime> updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubscriptionFiltersCompanion copyWith(
      {Value<String> id, Value<String> name, Value<DateTime> updatedAt}) {
    return SubscriptionFiltersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionFiltersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionFiltersTable extends SubscriptionFilters
    with TableInfo<$SubscriptionFiltersTable, SubscriptionFilterRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubscriptionFiltersTable(this._db, [this._alias]);
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

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, updatedAt];
  @override
  $SubscriptionFiltersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subscription_filters';
  @override
  final String actualTableName = 'subscription_filters';
  @override
  VerificationContext validateIntegrity(
      Insertable<SubscriptionFilterRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubscriptionFilterRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubscriptionFilterRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SubscriptionFiltersTable createAlias(String alias) {
    return $SubscriptionFiltersTable(_db, alias);
  }
}

class TaskRow extends DataClass implements Insertable<TaskRow> {
  final int id;
  final TaskType taskType;
  final TaskStatus taskStatus;
  final TaskPriority taskPriority;
  final DateTime createdAt;
  final DateTime updatedAt;
  TaskRow(
      {@required this.id,
      @required this.taskType,
      @required this.taskStatus,
      @required this.taskPriority,
      @required this.createdAt,
      @required this.updatedAt});
  factory TaskRow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TaskRow(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      taskType: $TasksTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_type'])),
      taskStatus: $TasksTable.$converter1.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_status'])),
      taskPriority: $TasksTable.$converter2.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}task_priority'])),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || taskType != null) {
      final converter = $TasksTable.$converter0;
      map['task_type'] = Variable<String>(converter.mapToSql(taskType));
    }
    if (!nullToAbsent || taskStatus != null) {
      final converter = $TasksTable.$converter1;
      map['task_status'] = Variable<int>(converter.mapToSql(taskStatus));
    }
    if (!nullToAbsent || taskPriority != null) {
      final converter = $TasksTable.$converter2;
      map['task_priority'] = Variable<int>(converter.mapToSql(taskPriority));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      taskType: taskType == null && nullToAbsent
          ? const Value.absent()
          : Value(taskType),
      taskStatus: taskStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(taskStatus),
      taskPriority: taskPriority == null && nullToAbsent
          ? const Value.absent()
          : Value(taskPriority),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory TaskRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskRow(
      id: serializer.fromJson<int>(json['id']),
      taskType: serializer.fromJson<TaskType>(json['taskType']),
      taskStatus: serializer.fromJson<TaskStatus>(json['taskStatus']),
      taskPriority: serializer.fromJson<TaskPriority>(json['taskPriority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskType': serializer.toJson<TaskType>(taskType),
      'taskStatus': serializer.toJson<TaskStatus>(taskStatus),
      'taskPriority': serializer.toJson<TaskPriority>(taskPriority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TaskRow copyWith(
          {int id,
          TaskType taskType,
          TaskStatus taskStatus,
          TaskPriority taskPriority,
          DateTime createdAt,
          DateTime updatedAt}) =>
      TaskRow(
        id: id ?? this.id,
        taskType: taskType ?? this.taskType,
        taskStatus: taskStatus ?? this.taskStatus,
        taskPriority: taskPriority ?? this.taskPriority,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TaskRow(')
          ..write('id: $id, ')
          ..write('taskType: $taskType, ')
          ..write('taskStatus: $taskStatus, ')
          ..write('taskPriority: $taskPriority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          taskType.hashCode,
          $mrjc(
              taskStatus.hashCode,
              $mrjc(taskPriority.hashCode,
                  $mrjc(createdAt.hashCode, updatedAt.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskRow &&
          other.id == this.id &&
          other.taskType == this.taskType &&
          other.taskStatus == this.taskStatus &&
          other.taskPriority == this.taskPriority &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<TaskRow> {
  final Value<int> id;
  final Value<TaskType> taskType;
  final Value<TaskStatus> taskStatus;
  final Value<TaskPriority> taskPriority;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.taskType = const Value.absent(),
    this.taskStatus = const Value.absent(),
    this.taskPriority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required TaskType taskType,
    @required TaskStatus taskStatus,
    @required TaskPriority taskPriority,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : taskType = Value(taskType),
        taskStatus = Value(taskStatus),
        taskPriority = Value(taskPriority),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TaskRow> custom({
    Expression<int> id,
    Expression<String> taskType,
    Expression<int> taskStatus,
    Expression<int> taskPriority,
    Expression<DateTime> createdAt,
    Expression<DateTime> updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskType != null) 'task_type': taskType,
      if (taskStatus != null) 'task_status': taskStatus,
      if (taskPriority != null) 'task_priority': taskPriority,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<TaskType> taskType,
      Value<TaskStatus> taskStatus,
      Value<TaskPriority> taskPriority,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return TasksCompanion(
      id: id ?? this.id,
      taskType: taskType ?? this.taskType,
      taskStatus: taskStatus ?? this.taskStatus,
      taskPriority: taskPriority ?? this.taskPriority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskType.present) {
      final converter = $TasksTable.$converter0;
      map['task_type'] = Variable<String>(converter.mapToSql(taskType.value));
    }
    if (taskStatus.present) {
      final converter = $TasksTable.$converter1;
      map['task_status'] = Variable<int>(converter.mapToSql(taskStatus.value));
    }
    if (taskPriority.present) {
      final converter = $TasksTable.$converter2;
      map['task_priority'] =
          Variable<int>(converter.mapToSql(taskPriority.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('taskType: $taskType, ')
          ..write('taskStatus: $taskStatus, ')
          ..write('taskPriority: $taskPriority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _taskTypeMeta = const VerificationMeta('taskType');
  GeneratedTextColumn _taskType;
  @override
  GeneratedTextColumn get taskType => _taskType ??= _constructTaskType();
  GeneratedTextColumn _constructTaskType() {
    return GeneratedTextColumn(
      'task_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskStatusMeta = const VerificationMeta('taskStatus');
  GeneratedIntColumn _taskStatus;
  @override
  GeneratedIntColumn get taskStatus => _taskStatus ??= _constructTaskStatus();
  GeneratedIntColumn _constructTaskStatus() {
    return GeneratedIntColumn(
      'task_status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskPriorityMeta =
      const VerificationMeta('taskPriority');
  GeneratedIntColumn _taskPriority;
  @override
  GeneratedIntColumn get taskPriority =>
      _taskPriority ??= _constructTaskPriority();
  GeneratedIntColumn _constructTaskPriority() {
    return GeneratedIntColumn(
      'task_priority',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, taskType, taskStatus, taskPriority, createdAt, updatedAt];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<TaskRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    context.handle(_taskTypeMeta, const VerificationResult.success());
    context.handle(_taskStatusMeta, const VerificationResult.success());
    context.handle(_taskPriorityMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }

  static TypeConverter<TaskType, String> $converter0 = TaskTypeConverter();
  static TypeConverter<TaskStatus, int> $converter1 = TaskStatusConverter();
  static TypeConverter<TaskPriority, int> $converter2 = TaskPriorityConverter();
}

class AudioFileRow extends DataClass implements Insertable<AudioFileRow> {
  final String episodeId;
  final String url;
  final String filename;
  final String storagePath;
  final DownloadState downloadState;
  final double downloadPercentage;
  final int downloadTaskId;
  final DateTime createdAt;
  final DateTime updatedAt;
  AudioFileRow(
      {@required this.episodeId,
      @required this.url,
      @required this.filename,
      @required this.storagePath,
      @required this.downloadState,
      @required this.downloadPercentage,
      @required this.downloadTaskId,
      @required this.createdAt,
      @required this.updatedAt});
  factory AudioFileRow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return AudioFileRow(
      episodeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}episode_id']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      filename: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}filename']),
      storagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_path']),
      downloadState: $AudioFilesTable.$converter0.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}download_state'])),
      downloadPercentage: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}download_percentage']),
      downloadTaskId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}download_task_id']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || episodeId != null) {
      map['episode_id'] = Variable<String>(episodeId);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || filename != null) {
      map['filename'] = Variable<String>(filename);
    }
    if (!nullToAbsent || storagePath != null) {
      map['storage_path'] = Variable<String>(storagePath);
    }
    if (!nullToAbsent || downloadState != null) {
      final converter = $AudioFilesTable.$converter0;
      map['download_state'] = Variable<int>(converter.mapToSql(downloadState));
    }
    if (!nullToAbsent || downloadPercentage != null) {
      map['download_percentage'] = Variable<double>(downloadPercentage);
    }
    if (!nullToAbsent || downloadTaskId != null) {
      map['download_task_id'] = Variable<int>(downloadTaskId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AudioFilesCompanion toCompanion(bool nullToAbsent) {
    return AudioFilesCompanion(
      episodeId: episodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeId),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      filename: filename == null && nullToAbsent
          ? const Value.absent()
          : Value(filename),
      storagePath: storagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(storagePath),
      downloadState: downloadState == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadState),
      downloadPercentage: downloadPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadPercentage),
      downloadTaskId: downloadTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadTaskId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory AudioFileRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudioFileRow(
      episodeId: serializer.fromJson<String>(json['episodeId']),
      url: serializer.fromJson<String>(json['url']),
      filename: serializer.fromJson<String>(json['filename']),
      storagePath: serializer.fromJson<String>(json['storagePath']),
      downloadState: serializer.fromJson<DownloadState>(json['downloadState']),
      downloadPercentage:
          serializer.fromJson<double>(json['downloadPercentage']),
      downloadTaskId: serializer.fromJson<int>(json['downloadTaskId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'episodeId': serializer.toJson<String>(episodeId),
      'url': serializer.toJson<String>(url),
      'filename': serializer.toJson<String>(filename),
      'storagePath': serializer.toJson<String>(storagePath),
      'downloadState': serializer.toJson<DownloadState>(downloadState),
      'downloadPercentage': serializer.toJson<double>(downloadPercentage),
      'downloadTaskId': serializer.toJson<int>(downloadTaskId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AudioFileRow copyWith(
          {String episodeId,
          String url,
          String filename,
          String storagePath,
          DownloadState downloadState,
          double downloadPercentage,
          int downloadTaskId,
          DateTime createdAt,
          DateTime updatedAt}) =>
      AudioFileRow(
        episodeId: episodeId ?? this.episodeId,
        url: url ?? this.url,
        filename: filename ?? this.filename,
        storagePath: storagePath ?? this.storagePath,
        downloadState: downloadState ?? this.downloadState,
        downloadPercentage: downloadPercentage ?? this.downloadPercentage,
        downloadTaskId: downloadTaskId ?? this.downloadTaskId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('AudioFileRow(')
          ..write('episodeId: $episodeId, ')
          ..write('url: $url, ')
          ..write('filename: $filename, ')
          ..write('storagePath: $storagePath, ')
          ..write('downloadState: $downloadState, ')
          ..write('downloadPercentage: $downloadPercentage, ')
          ..write('downloadTaskId: $downloadTaskId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      episodeId.hashCode,
      $mrjc(
          url.hashCode,
          $mrjc(
              filename.hashCode,
              $mrjc(
                  storagePath.hashCode,
                  $mrjc(
                      downloadState.hashCode,
                      $mrjc(
                          downloadPercentage.hashCode,
                          $mrjc(
                              downloadTaskId.hashCode,
                              $mrjc(createdAt.hashCode,
                                  updatedAt.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudioFileRow &&
          other.episodeId == this.episodeId &&
          other.url == this.url &&
          other.filename == this.filename &&
          other.storagePath == this.storagePath &&
          other.downloadState == this.downloadState &&
          other.downloadPercentage == this.downloadPercentage &&
          other.downloadTaskId == this.downloadTaskId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AudioFilesCompanion extends UpdateCompanion<AudioFileRow> {
  final Value<String> episodeId;
  final Value<String> url;
  final Value<String> filename;
  final Value<String> storagePath;
  final Value<DownloadState> downloadState;
  final Value<double> downloadPercentage;
  final Value<int> downloadTaskId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AudioFilesCompanion({
    this.episodeId = const Value.absent(),
    this.url = const Value.absent(),
    this.filename = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.downloadState = const Value.absent(),
    this.downloadPercentage = const Value.absent(),
    this.downloadTaskId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AudioFilesCompanion.insert({
    @required String episodeId,
    @required String url,
    @required String filename,
    @required String storagePath,
    @required DownloadState downloadState,
    @required double downloadPercentage,
    @required int downloadTaskId,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  })  : episodeId = Value(episodeId),
        url = Value(url),
        filename = Value(filename),
        storagePath = Value(storagePath),
        downloadState = Value(downloadState),
        downloadPercentage = Value(downloadPercentage),
        downloadTaskId = Value(downloadTaskId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AudioFileRow> custom({
    Expression<String> episodeId,
    Expression<String> url,
    Expression<String> filename,
    Expression<String> storagePath,
    Expression<int> downloadState,
    Expression<double> downloadPercentage,
    Expression<int> downloadTaskId,
    Expression<DateTime> createdAt,
    Expression<DateTime> updatedAt,
  }) {
    return RawValuesInsertable({
      if (episodeId != null) 'episode_id': episodeId,
      if (url != null) 'url': url,
      if (filename != null) 'filename': filename,
      if (storagePath != null) 'storage_path': storagePath,
      if (downloadState != null) 'download_state': downloadState,
      if (downloadPercentage != null) 'download_percentage': downloadPercentage,
      if (downloadTaskId != null) 'download_task_id': downloadTaskId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AudioFilesCompanion copyWith(
      {Value<String> episodeId,
      Value<String> url,
      Value<String> filename,
      Value<String> storagePath,
      Value<DownloadState> downloadState,
      Value<double> downloadPercentage,
      Value<int> downloadTaskId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt}) {
    return AudioFilesCompanion(
      episodeId: episodeId ?? this.episodeId,
      url: url ?? this.url,
      filename: filename ?? this.filename,
      storagePath: storagePath ?? this.storagePath,
      downloadState: downloadState ?? this.downloadState,
      downloadPercentage: downloadPercentage ?? this.downloadPercentage,
      downloadTaskId: downloadTaskId ?? this.downloadTaskId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (episodeId.present) {
      map['episode_id'] = Variable<String>(episodeId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (downloadState.present) {
      final converter = $AudioFilesTable.$converter0;
      map['download_state'] =
          Variable<int>(converter.mapToSql(downloadState.value));
    }
    if (downloadPercentage.present) {
      map['download_percentage'] = Variable<double>(downloadPercentage.value);
    }
    if (downloadTaskId.present) {
      map['download_task_id'] = Variable<int>(downloadTaskId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioFilesCompanion(')
          ..write('episodeId: $episodeId, ')
          ..write('url: $url, ')
          ..write('filename: $filename, ')
          ..write('storagePath: $storagePath, ')
          ..write('downloadState: $downloadState, ')
          ..write('downloadPercentage: $downloadPercentage, ')
          ..write('downloadTaskId: $downloadTaskId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AudioFilesTable extends AudioFiles
    with TableInfo<$AudioFilesTable, AudioFileRow> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudioFilesTable(this._db, [this._alias]);
  final VerificationMeta _episodeIdMeta = const VerificationMeta('episodeId');
  GeneratedTextColumn _episodeId;
  @override
  GeneratedTextColumn get episodeId => _episodeId ??= _constructEpisodeId();
  GeneratedTextColumn _constructEpisodeId() {
    return GeneratedTextColumn('episode_id', $tableName, false,
        $customConstraints: 'REFERENCES episodes(id)');
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _filenameMeta = const VerificationMeta('filename');
  GeneratedTextColumn _filename;
  @override
  GeneratedTextColumn get filename => _filename ??= _constructFilename();
  GeneratedTextColumn _constructFilename() {
    return GeneratedTextColumn(
      'filename',
      $tableName,
      false,
    );
  }

  final VerificationMeta _storagePathMeta =
      const VerificationMeta('storagePath');
  GeneratedTextColumn _storagePath;
  @override
  GeneratedTextColumn get storagePath =>
      _storagePath ??= _constructStoragePath();
  GeneratedTextColumn _constructStoragePath() {
    return GeneratedTextColumn(
      'storage_path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _downloadStateMeta =
      const VerificationMeta('downloadState');
  GeneratedIntColumn _downloadState;
  @override
  GeneratedIntColumn get downloadState =>
      _downloadState ??= _constructDownloadState();
  GeneratedIntColumn _constructDownloadState() {
    return GeneratedIntColumn(
      'download_state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _downloadPercentageMeta =
      const VerificationMeta('downloadPercentage');
  GeneratedRealColumn _downloadPercentage;
  @override
  GeneratedRealColumn get downloadPercentage =>
      _downloadPercentage ??= _constructDownloadPercentage();
  GeneratedRealColumn _constructDownloadPercentage() {
    return GeneratedRealColumn(
      'download_percentage',
      $tableName,
      false,
    );
  }

  final VerificationMeta _downloadTaskIdMeta =
      const VerificationMeta('downloadTaskId');
  GeneratedIntColumn _downloadTaskId;
  @override
  GeneratedIntColumn get downloadTaskId =>
      _downloadTaskId ??= _constructDownloadTaskId();
  GeneratedIntColumn _constructDownloadTaskId() {
    return GeneratedIntColumn(
      'download_task_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        episodeId,
        url,
        filename,
        storagePath,
        downloadState,
        downloadPercentage,
        downloadTaskId,
        createdAt,
        updatedAt
      ];
  @override
  $AudioFilesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audio_files';
  @override
  final String actualTableName = 'audio_files';
  @override
  VerificationContext validateIntegrity(Insertable<AudioFileRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('episode_id')) {
      context.handle(_episodeIdMeta,
          episodeId.isAcceptableOrUnknown(data['episode_id'], _episodeIdMeta));
    } else if (isInserting) {
      context.missing(_episodeIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename'], _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('storage_path')) {
      context.handle(
          _storagePathMeta,
          storagePath.isAcceptableOrUnknown(
              data['storage_path'], _storagePathMeta));
    } else if (isInserting) {
      context.missing(_storagePathMeta);
    }
    context.handle(_downloadStateMeta, const VerificationResult.success());
    if (data.containsKey('download_percentage')) {
      context.handle(
          _downloadPercentageMeta,
          downloadPercentage.isAcceptableOrUnknown(
              data['download_percentage'], _downloadPercentageMeta));
    } else if (isInserting) {
      context.missing(_downloadPercentageMeta);
    }
    if (data.containsKey('download_task_id')) {
      context.handle(
          _downloadTaskIdMeta,
          downloadTaskId.isAcceptableOrUnknown(
              data['download_task_id'], _downloadTaskIdMeta));
    } else if (isInserting) {
      context.missing(_downloadTaskIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {episodeId};
  @override
  AudioFileRow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudioFileRow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AudioFilesTable createAlias(String alias) {
    return $AudioFilesTable(_db, alias);
  }

  static TypeConverter<DownloadState, int> $converter0 =
      DownloadStateConverter();
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
  $PlaybackPositionsTable _playbackPositions;
  $PlaybackPositionsTable get playbackPositions =>
      _playbackPositions ??= $PlaybackPositionsTable(this);
  $PreferencesTable _preferences;
  $PreferencesTable get preferences => _preferences ??= $PreferencesTable(this);
  $SubscriptionsTable _subscriptions;
  $SubscriptionsTable get subscriptions =>
      _subscriptions ??= $SubscriptionsTable(this);
  $SubscriptionFiltersTable _subscriptionFilters;
  $SubscriptionFiltersTable get subscriptionFilters =>
      _subscriptionFilters ??= $SubscriptionFiltersTable(this);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $AudioFilesTable _audioFiles;
  $AudioFilesTable get audioFiles => _audioFiles ??= $AudioFilesTable(this);
  PodcastDao _podcastDao;
  PodcastDao get podcastDao => _podcastDao ??= PodcastDao(this as SqlDb);
  EpisodeDao _episodeDao;
  EpisodeDao get episodeDao => _episodeDao ??= EpisodeDao(this as SqlDb);
  AudioTrackDao _audioTrackDao;
  AudioTrackDao get audioTrackDao =>
      _audioTrackDao ??= AudioTrackDao(this as SqlDb);
  PlaybackPositionDao _playbackPositionDao;
  PlaybackPositionDao get playbackPositionDao =>
      _playbackPositionDao ??= PlaybackPositionDao(this as SqlDb);
  PreferenceDao _preferenceDao;
  PreferenceDao get preferenceDao =>
      _preferenceDao ??= PreferenceDao(this as SqlDb);
  SubscriptionDao _subscriptionDao;
  SubscriptionDao get subscriptionDao =>
      _subscriptionDao ??= SubscriptionDao(this as SqlDb);
  TaskDao _taskDao;
  TaskDao get taskDao => _taskDao ??= TaskDao(this as SqlDb);
  AudioFileDao _audioFileDao;
  AudioFileDao get audioFileDao =>
      _audioFileDao ??= AudioFileDao(this as SqlDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        podcasts,
        episodes,
        audioTracks,
        playbackPositions,
        preferences,
        subscriptions,
        subscriptionFilters,
        tasks,
        audioFiles
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PodcastDaoMixin on DatabaseAccessor<SqlDb> {
  $PodcastsTable get podcasts => attachedDatabase.podcasts;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
}
mixin _$EpisodeDaoMixin on DatabaseAccessor<SqlDb> {
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $AudioTracksTable get audioTracks => attachedDatabase.audioTracks;
  $AudioFilesTable get audioFiles => attachedDatabase.audioFiles;
  $PlaybackPositionsTable get playbackPositions =>
      attachedDatabase.playbackPositions;
}
mixin _$PlaybackPositionDaoMixin on DatabaseAccessor<SqlDb> {
  $PlaybackPositionsTable get playbackPositions =>
      attachedDatabase.playbackPositions;
}
mixin _$PreferenceDaoMixin on DatabaseAccessor<SqlDb> {
  $PreferencesTable get preferences => attachedDatabase.preferences;
}
mixin _$AudioTrackDaoMixin on DatabaseAccessor<SqlDb> {
  $PodcastsTable get podcasts => attachedDatabase.podcasts;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $AudioTracksTable get audioTracks => attachedDatabase.audioTracks;
}
mixin _$SubscriptionDaoMixin on DatabaseAccessor<SqlDb> {
  $SubscriptionsTable get subscriptions => attachedDatabase.subscriptions;
  $SubscriptionFiltersTable get subscriptionFilters =>
      attachedDatabase.subscriptionFilters;
}
mixin _$TaskDaoMixin on DatabaseAccessor<SqlDb> {
  $TasksTable get tasks => attachedDatabase.tasks;
}
mixin _$AudioFileDaoMixin on DatabaseAccessor<SqlDb> {
  $AudioFilesTable get audioFiles => attachedDatabase.audioFiles;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $PodcastsTable get podcasts => attachedDatabase.podcasts;
}
