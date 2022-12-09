part of 'bloc.dart';

abstract class DestinationListBlockEvent extends Equatable {
  const DestinationListBlockEvent();

  @override
  List<Object?> get props => [];
}

class DestinationListAdded extends DestinationListBlockEvent {
  const DestinationListAdded(this.location) : super();

  final LocationInfo location;

  @override
  List<Object?> get props => [location];
}

class DestinationListRemoved extends DestinationListBlockEvent {
  const DestinationListRemoved(this.index) : super();

  final int index;

  @override
  List<Object?> get props => [index];
}

class DestinationListSaved extends DestinationListBlockEvent {
  const DestinationListSaved(this.outputFile);

  final String outputFile;

  @override
  List<Object> get props => [outputFile];
}
