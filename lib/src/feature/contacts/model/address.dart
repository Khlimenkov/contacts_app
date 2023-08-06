class Address {
  final int id;
  final String? streetAddress1;
  final String? streetAddress2;
  final String? city;
  final String? state;
  final String? zipCode;

  const Address({
    required this.id,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] ?? 0,
        city: json['city'],
        state: json['state'],
        streetAddress1: json['streetAddress1'],
        streetAddress2: json['streetAddress2'],
        zipCode: json['zipCode'],
      );

  Address copyWith({
    int? id,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? state,
    String? zipCode,
  }) =>
      Address(
        id: id ?? this.id,
        city: city ?? this.city,
        state: state ?? this.state,
        streetAddress1: streetAddress1 ?? this.streetAddress1,
        streetAddress2: streetAddress2 ?? this.streetAddress2,
        zipCode: zipCode ?? this.zipCode,
      );

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Address && runtimeType == other.runtimeType && id == other.id;
}
