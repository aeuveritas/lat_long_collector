part of 'bloc.dart';

abstract class LocationLightBlockEvent extends Equatable {
  const LocationLightBlockEvent();
}

class LocationLightUpdated extends LocationLightBlockEvent {
  const LocationLightUpdated(this.locationInfo);

  final LocationInfo locationInfo;

  @override
  List<Object?> get props => [locationInfo];
}
