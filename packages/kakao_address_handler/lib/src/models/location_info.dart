import 'package:equatable/equatable.dart';

class LocationInfo extends Equatable {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;

  factory LocationInfo.fromDocument(Map<String, dynamic> document) {
    final name = document["place_name"] ?? "";
    final address = document["road_address_name"] ?? "";
    final latitude = double.tryParse(document["y"]) ?? 0.0;
    final longitude = double.tryParse(document["x"]) ?? 0.0;
    final phone = document["phone"] ?? "";

    return LocationInfo(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      phone: phone,
    );
  }

  @override
  List<Object?> get props => [name, address, latitude, longitude, phone];

//<editor-fold desc="Data Methods">

  const LocationInfo({
    this.name = "",
    this.address = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.phone = "",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          phone == other.phone);

  @override
  int get hashCode => name.hashCode ^ address.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ phone.hashCode;

  @override
  String toString() {
    return 'LocationInfo{' +
        ' name: $name,' +
        ' address: $address,' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        ' phone: $phone,' +
        '}';
  }

  LocationInfo copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? phone,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (address == null || identical(address, this.address)) &&
        (latitude == null || identical(latitude, this.latitude)) &&
        (longitude == null || identical(longitude, this.longitude)) &&
        (phone == null || identical(phone, this.phone))) {
      return this;
    }

    return LocationInfo(
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap({
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return {
      keyMapper('name'): this.name,
      keyMapper('address'): this.address,
      keyMapper('latitude'): this.latitude,
      keyMapper('longitude'): this.longitude,
      keyMapper('phone'): this.phone,
    };
  }

  factory LocationInfo.fromMap(
    Map<String, dynamic> map, {
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return LocationInfo(
      name: map[keyMapper('name')] as String,
      address: map[keyMapper('address')] as String,
      latitude: map[keyMapper('latitude')] as double,
      longitude: map[keyMapper('longitude')] as double,
      phone: map[keyMapper('phone')] as String,
    );
  }

//</editor-fold>
}
