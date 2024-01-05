
import '../../entity/login_entity.dart';


/// @Author: gstory
/// @CreateDate: 2023/5/19 16:48
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

abstract class SPImpl{
  ///保存语言
  void saveLanguage(String? lan);
  ///获取语言
  String getLanguage();
  ///保存服务器地址
  void saveHost(String? url);
  ///获取服务器地址
  String getHost();
  ///保存账号密码
  void saveAccountPass(String account,String password);
  ///获取账号
  String getAccount();
  ///获取密码
  String getPassword();
  ///保存用户信息
  void saveUserInfo(LoginEntity entity);
  ///获取用户信息
  LoginEntity getUserInfo();
  ///保存音量
  void saveVolume(double volume);
  ///获取音量
  double getVolume();
  ///保存语言
  void saveLocale(int index);
  ///获取语言
  int getLocale();
}