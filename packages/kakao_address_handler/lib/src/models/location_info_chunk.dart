import 'package:kakao_address_handler/src/models/location_info.dart';

class LocationInfoChunk {
  final List<LocationInfo> locationInfoList;
  final int responseHashCode;
  final bool tooEarly;

//<editor-fold desc="Data Methods">

  const LocationInfoChunk({
    required this.locationInfoList,
    required this.responseHashCode,
    required this.tooEarly,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationInfoChunk &&
          runtimeType == other.runtimeType &&
          locationInfoList == other.locationInfoList &&
          responseHashCode == other.responseHashCode &&
          tooEarly == other.tooEarly);

  @override
  int get hashCode => locationInfoList.hashCode ^ responseHashCode.hashCode ^ tooEarly.hashCode;

  @override
  String toString() {
    return 'LocationInfoChunk{' +
        ' locationInfoList: $locationInfoList,' +
        ' responseHashCode: $responseHashCode,' +
        ' tooEarly: $tooEarly,' +
        '}';
  }

  LocationInfoChunk copyWith({
    List<LocationInfo>? locationInfoList,
    int? responseHashCode,
    bool? tooEarly,
  }) {
    return LocationInfoChunk(
      locationInfoList: locationInfoList ?? this.locationInfoList,
      responseHashCode: responseHashCode ?? this.responseHashCode,
      tooEarly: tooEarly ?? this.tooEarly,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationInfoList': this.locationInfoList,
      'responseHashCode': this.responseHashCode,
      'tooEarly': this.tooEarly,
    };
  }

  factory LocationInfoChunk.fromMap(Map<String, dynamic> map) {
    return LocationInfoChunk(
      locationInfoList: map['locationInfoList'] as List<LocationInfo>,
      responseHashCode: map['responseHashCode'] as int,
      tooEarly: map['tooEarly'] as bool,
    );
  }

//</editor-fold>
}
