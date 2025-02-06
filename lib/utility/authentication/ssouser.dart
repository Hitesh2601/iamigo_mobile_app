class SSOUser {
  String? displayName;
  String? givenName;
  String? jobTitle;
  String? mail;
  String? mobilePhone;
  String? officeLocation;
  String? preferredLanguage;
  String? surname;
  String? userPrincipalName;
  String? id;

  SSOUser(
      {this.displayName,
      this.givenName,
      this.jobTitle,
      this.mail,
      this.mobilePhone,
      this.officeLocation,
      this.preferredLanguage,
      this.surname,
      this.userPrincipalName,
      this.id});

  factory SSOUser.fromJson(Map<String, dynamic> json) => SSOUser(
        displayName: json['displayName'],
        givenName: json['givenName'],
        jobTitle: json['jobTitle'],
        mail: json['mail'],
        mobilePhone: json['mobilePhone'],
        officeLocation: json['officeLocation'],
        preferredLanguage: json['preferredLanguage'],
        surname: json['surname'],
        userPrincipalName: json['userPrincipalName'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['displayName'] = displayName;
    data['givenName'] = givenName;
    data['jobTitle'] = jobTitle;
    data['mail'] = mail;
    data['mobilePhone'] = mobilePhone;
    data['officeLocation'] = officeLocation;
    data['preferredLanguage'] = preferredLanguage;
    data['surname'] = surname;
    data['userPrincipalName'] = userPrincipalName;
    data['id'] = id;
    return data;
  }
}
