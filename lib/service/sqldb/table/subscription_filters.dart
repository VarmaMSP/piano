part of '../sqldb.dart';

@DataClassName('SubscriptionFilterRow')
class SubscriptionFilters extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

SubscriptionFilterRow subscriptionFilterRowFromModel(SubscriptionFilter model) {
  return SubscriptionFilterRow(id: model.id, name: model.name);
}

extension SubscriptionFilterRowExtension on SubscriptionFilterRow {
  SubscriptionFilter toModel() {
    return SubscriptionFilter(id: id, name: name);
  }
}
