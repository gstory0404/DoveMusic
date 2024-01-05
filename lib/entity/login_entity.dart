
/// @Author: gstory
/// @CreateDate: 2023/5/23 18:01
/// @Email gstory0404@gmail.com
/// @Description: 登录

class LoginEntity {
	String? token;
	String? userName;
	int? userId;
	int? purview;

	LoginEntity({this.token, this.userName, this.userId, this.purview});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		token = json['token'];
		userName = json['name'];
		userId = json['userId'];
		purview = json['purview'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['token'] = token;
		data['name'] = userName;
		data['userId'] = userId;
		data['purview'] = purview;
		return data;
	}
}
