import 'package:equatable/equatable.dart';

class AvailabilityFilterEntity extends Equatable {
  const AvailabilityFilterEntity({
    required this.groupName,
    required this.displayName,
    required this.value,
    this.apiValue,
    this.identifier,
  });

  /// groupName - the name of filter group
  /// identifier - the name of concrete filter (inside group or independent)
  /// displayName - is displayed inside the filters list
  /// value - can be displayed after displayName. displayName (value)
  /// apiValue - can me used as a filter for api calls
  final String groupName;
  final String displayName;
  final String value;
  final dynamic apiValue;
  final String? identifier;

  @override
  List<Object?> get props => [
    groupName,
    displayName,
    value,
    apiValue,
    identifier,
  ];
}
