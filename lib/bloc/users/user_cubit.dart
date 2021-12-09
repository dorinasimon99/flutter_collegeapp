import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/models/UserData.dart';
import 'package:flutter_collegeapp/bloc/users/user_repository.dart';

abstract class UsersState {}

class LoadingUsers extends UsersState {}

class ListUsersSuccess extends UsersState {
  final List<UserData> users;

  ListUsersSuccess({required this.users});
}

class ListUsersFailure extends UsersState {
  final Object exception;

  ListUsersFailure({required this.exception});
}

class ListStudentsSuccess extends UsersState {
  final List<UserData> users;

  ListStudentsSuccess({required this.users});
}

class ListStudentsFailure extends UsersState {
  final Object exception;

  ListStudentsFailure({required this.exception});
}

class GetUserSuccess extends UsersState {
  final UserData user;

  GetUserSuccess({required this.user});
}

class GetUserFailure extends UsersState {
  final Object exception;

  GetUserFailure({required this.exception});
}

class GetUserByNameSuccess extends UsersState {
  final UserData user;

  GetUserByNameSuccess({required this.user});
}

class GetUserByNameFailure extends UsersState {
  final Object exception;

  GetUserByNameFailure({required this.exception});
}

class UpdateUserSuccess extends UsersState {
  final UserData user;

  UpdateUserSuccess({required this.user});
}

class UpdateUserFailure extends UsersState {
  final Object exception;

  UpdateUserFailure({required this.exception});
}

class UsersCubit extends Cubit<UsersState> {
  final _usersRepo = UsersRepository();

  UsersCubit() : super(LoadingUsers());

  void getUsers() async {
    if (state is ListUsersSuccess == false) {
      emit(LoadingUsers());
    }

    try {
      final users = await _usersRepo.getUsers();
      emit(ListUsersSuccess(users: users));
    } catch (e) {
      emit(ListUsersFailure(exception: e));
    }
  }

  void getStudents(List<String> usernames) async {
    if (state is ListStudentsSuccess == false) {
      emit(LoadingUsers());
    }

    try {
      final users = await _usersRepo.getStudents(usernames);
      emit(ListStudentsSuccess(users: users));
    } catch (e) {
      emit(ListStudentsFailure(exception: e));
    }
  }

  void getUserByUsername(String username) async {
    try {
      final user = await _usersRepo.getUserByUsername(username);
      emit(GetUserSuccess(user: user));
    } catch (e) {
      emit(GetUserFailure(exception: e));
    }
  }

  void getUserByName(String name) async {
    try {
      final user = await _usersRepo.getUserByName(name);
      emit(GetUserByNameSuccess(user: user));
    } catch (e) {
      emit(GetUserByNameFailure(exception: e));
    }
  }

  void createUser(UserData user) async {
    await _usersRepo.createUser(user);
  }

  void updateUser(UserData user) async {
    try {
      await _usersRepo.updateUser(user);
      emit(UpdateUserSuccess(user: user));
    } catch (e) {
      emit(UpdateUserFailure(exception: e));
    }
  }
}