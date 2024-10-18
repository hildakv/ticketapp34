class User {
  late String userId;
  late String name;
  late String? organisation;
  late String? office;
  late String? clientSecret;

  String? accessToken;
  String? refreshToken;
  DateTime? tokenExpiryDate;
  User({
    required this.userId,
    required this.name,
    required this.organisation,
    required this.office,
    required this.clientSecret,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] as String;
    name = json['name'] as String;
    organisation = json['organisation'] as String?;
    office = json['office'] as String?;
    clientSecret = json['client_secret'] as String?;

    accessToken = json['access_token'] as String?;
    refreshToken = json['refresh_token'] as String?;
    tokenExpiryDate = json['token_expiry_date'] != null
        ? DateTime.parse(json['token_expiry_date'] as String)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['organisation'] = organisation;
    data['office'] = office;
    data['client_secret'] = clientSecret;

    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_expiry_date'] = tokenExpiryDate?.toIso8601String();
    return data;
  }
}
