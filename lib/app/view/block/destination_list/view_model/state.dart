part of 'bloc.dart';

class DestinationListBlockState extends CustomBlockState with MixInLogger {
  DestinationListBlockState({
    this.addresses = const [],
  }) : super(FormzStatus.submissionSuccess);

  final List<LocationInfo> addresses;

  @override
  String toString() {
    return '{ status: $status, addresses count: ${addresses.length} }';
  }

  DestinationListBlockState copyWith({
    FormzStatus? status,
    List<LocationInfo>? addresses,
  }) {
    return DestinationListBlockState(
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  List<Object> get props => [
        addresses,
      ];

  @override
  FormzInput getCube() {
    // TODO: implement getCube
    throw UnimplementedError();
  }

  @override
  // TODO: implement isSavable
  bool get isSavable => throw UnimplementedError();

  @override
  get output => addresses;
}
