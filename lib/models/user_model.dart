class UserModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Users>? users;

  UserModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.users,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        users: json["data"] == null
            ? []
            : List<Users>.from(json["data"]?.map((x) => Users.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class Users {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Users({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
