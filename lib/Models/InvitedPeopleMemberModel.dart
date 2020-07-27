class InvitePeopleMember {
  String status;
  int statusCode;
  List<InvitePeopleMemberList> data;

  InvitePeopleMember({this.status, this.statusCode, this.data});

  InvitePeopleMember.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = new List<InvitePeopleMemberList>();
      json['data'].forEach((v) {
        data.add(new InvitePeopleMemberList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvitePeopleMemberList {
  int id;
  String firstName;
  String lastName;

  InvitePeopleMemberList({this.id, this.firstName, this.lastName});

  InvitePeopleMemberList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
