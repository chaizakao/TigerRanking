class SignInModel {
  String module;
  String target;
  Data data;

  SignInModel({this.module, this.target, this.data});

  SignInModel.fromJson(Map<String, dynamic> json) {
    module = json['module'];
    target = json['target'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['module'] = this.module;
    data['target'] = this.target;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String username;
  String password;

  Data({this.username, this.password});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  


}
