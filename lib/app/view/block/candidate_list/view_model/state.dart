part of 'bloc.dart';

class CandidateListBlockState extends CustomBlockState with MixInLogger {
  CandidateListBlockState({
    this.addresses = const [],
    this.hasMaxReached = false,
    this.nextPageCount = 1,
    this.responseHashCode = 0,
  }) : super(FormzStatus.submissionSuccess);

  final List<LocationInfo> addresses;

  final bool hasMaxReached;
  final int nextPageCount;

  final int responseHashCode;

  @override
  String toString() {
    return '{ status: $status, addresses count: ${addresses.length},'
        ' hasMaxReached: $hasMaxReached, nextPageCount: $nextPageCount,'
        ' responseHashCode: $responseHashCode }';
  }

  CandidateListBlockState copyWith({
    FormzStatus? status,
    List<LocationInfo>? addresses,
    bool? hasMaxReached,
    int? nextPageCount,
    int? responseHashCode,
  }) {
    return CandidateListBlockState(
      addresses: addresses ?? this.addresses,
      hasMaxReached: hasMaxReached ?? this.hasMaxReached,
      nextPageCount: nextPageCount ?? this.nextPageCount,
      responseHashCode: responseHashCode ?? this.responseHashCode,
    );
  }

  @override
  List<Object> get props => [
        addresses,
        hasMaxReached,
        nextPageCount,
        responseHashCode,
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
  // TODO: implement output
  get output => throw UnimplementedError();
}
