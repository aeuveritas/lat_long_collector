part of 'bloc.dart';

enum MapSearchLocationBlockStatus { pure, inProgress, valid }

class LocationLightBlockState extends AbstractFormzBlocState {
  LocationLightBlockState([
    this.locationInfo = const LocationInfo(),
    FormzStatus status = FormzStatus.pure,
  ]) : super(FormzStatus.submissionSuccess);

  final LocationInfo locationInfo;

  LocationLightBlockState copyWith({
    LocationInfo? locationInfo,
    FormzStatus? status,
  }) {
    return LocationLightBlockState(
      locationInfo ?? this.locationInfo,
      status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        locationInfo,
        status,
      ];

  @override
  bool get isSavable => locationInfo.name != "";

  @override
  FormzInput getCube() {
    // TODO: implement getCube
    throw UnimplementedError();
  }

  @override
  get output => locationInfo;
}
