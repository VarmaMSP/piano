part of '../db.dart';

@DataClassName('SubscriptionFilterRow')
class SubscriptionFilters extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

SubscriptionFilterRow subscriptionFilterRowFromModel(SubscriptionFilter model) {
  return SubscriptionFilterRow(
    id: model.id,
    name: model.name,
    updatedAt: model.updatedAt,
  );
}

extension SubscriptionFilterRowExtension on SubscriptionFilterRow {
  SubscriptionFilter toModel() {
    return SubscriptionFilter(
      id: id,
      name: name,
      updatedAt: updatedAt,
    );
  }
}
