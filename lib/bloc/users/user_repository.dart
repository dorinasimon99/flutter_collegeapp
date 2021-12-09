import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_collegeapp/common/roles.dart';
import 'package:flutter_collegeapp/models/ModelProvider.dart';


class UsersRepository {

  Future<List<UserData>> getUsers() async {
    try {
      var items = await Amplify.DataStore.query(UserData.classType);
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserData>> getStudents(List<String> usernames) async {
    try {
      var users = await Amplify.DataStore.query(UserData.classType);
      var items = <UserData>[];
      for(var user in users){
        if(usernames.contains(user.username) && user.role == Roles.instance.student){
          items.add(user);
        }
      }
      return items;
    } catch (e) {
      throw e;
    }
  }

  Future<UserData> getUserByUsername(String username) async {
    try{
      var item = (await Amplify.DataStore.query(UserData.classType,
          where: UserData.USERNAME.eq(username)))[0];
      return item;
    } catch (e) {
      throw e;
    }
  }

  Future<UserData> getUserByName(String name) async {
    try{
      var item = (await Amplify.DataStore.query(UserData.classType,
          where: UserData.NAME.eq(name)))[0];
      return item;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUser(UserData user) async {
    try {
      await Amplify.DataStore.save(user);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserData user) async {
    try {
      await Amplify.DataStore.save(user);
    } catch (e) {
      throw e;
    }
  }
}