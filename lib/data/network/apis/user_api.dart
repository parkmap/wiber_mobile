import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/data/dio_client.dart';
import 'package:wiber_mobile/data/network/constants/endpoints.dart';

@lazySingleton
class UserApi {
  // dio instance
  final DioClient _dioClient;
  final Dio _dio;

  // injecting dio instance
  UserApi(
    this._dioClient,
    this._dio,
  );

  Future<dynamic> createUser({
    required String username,
    required String app_uuid,
  }) async {
    try {
      String? _fcmToken = await FirebaseMessaging.instance.getToken();

      var data = {
        "username": username,
        "app_uuid": app_uuid,
        "push_token": _fcmToken,
      };

      var res = await _dioClient.post(Endpoints.auth, data: data);
      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future saveProfileImage({
    required Uint8List profileImage,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var res = await _dioClient.put(
        Endpoints.uploadProfileImage,
        data: profileImage,
        options: Options(
          headers: {
            "Content-Type": "image/png",
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  Future deleteProfileImage({
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var res = await _dioClient.delete(
        Endpoints.uploadProfileImage,
        options: Options(
          headers: {
            "Content-Type": "image/png",
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  Future getUserInfo({
    String? userId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "id": userId,
      };

      var res = await _dio.get(
        Endpoints.auth,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future updateUserInfo({
    required String userId,
    required String userNickname,
    String? pushToken,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "username": userNickname,
        "push_token": pushToken,
      };

      var res = await _dio.patch(
        Endpoints.auth,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future getWiberSpaceList({
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var res = await _dio.get(
        Endpoints.wiberSpace,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future createWiberSpace({
    required String title,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "title": title,
      };

      var res = await _dio.put(
        Endpoints.wiberSpace,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future updateWiberSpace({
    required String title,
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "title": title,
      };

      var res = await _dio.patch(
        Endpoints.wiberSpace,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future deleteWiberSpace({
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
      };

      var res = await _dio.delete(
        Endpoints.wiberSpace,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future leaveWiberSpace({
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
      };

      var res = await _dio.put(
        "${Endpoints.wiberSpace}/exit",
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future createWiberSpaceInviteLink({
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
      };

      var res = await _dio.put(
        "${Endpoints.wiberSpace}/share",
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future kickUserFromWiberSpace({
    required String spaceId,
    required String exitId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "exit_id": exitId,
      };

      var res = await _dio.patch(
        "${Endpoints.wiberSpace}/manage",
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future changeOwnerOfWiberSpace({
    required String spaceId,
    required String userId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "user_id": userId,
      };

      var res = await _dio.patch(
        "${Endpoints.wiberSpace}/manage",
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future enterWiberSpaceInvitation({
    required String spaceId,
    required String shareId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "share_id": shareId,
      };

      var res = await _dio.put(
        "${Endpoints.wiberSpace}/enter",
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future getCategoryList({
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
      };

      var res = await _dio.get(
        Endpoints.category,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future createCategory({
    required String title,
    required String spaceId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "title": title,
      };

      var res = await _dio.put(
        Endpoints.category,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future updateCategory({
    required String title,
    required String spaceId,
    required String categoryId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "category_id": categoryId,
        "title": title,
      };

      var res = await _dio.patch(
        Endpoints.category,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future deleteCategory({
    required String spaceId,
    required String categoryId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "category_id": categoryId,
      };

      var res = await _dio.delete(
        Endpoints.category,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future getBucketList({
    required String spaceId,
    String? categoryId,
    String? state,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "category_id": categoryId,
        "state": state,
      };

      var res = await _dio.get(
        Endpoints.bucket,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future createBucket({
    required String spaceId,
    required String categoryId,
    required String state,
    required String date,
    required String title,
    required String content,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "category_id": categoryId,
        "state": state,
        "date": date,
        "title": title,
        "content": content,
      };

      var res = await _dio.put(
        Endpoints.bucket,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future updateBucket({
    required String spaceId,
    required String bucketId,
    required String categoryId,
    String? state,
    String? date,
    String? title,
    String? content,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "bucket_id": bucketId,
        "state": state,
        "date": date,
        "category_id": categoryId,
        "title": title,
        "content": content,
      };

      var res = await _dio.patch(
        Endpoints.bucket,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future deleteBucket({
    required String spaceId,
    required String bucketId,
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var data = {
        "space_id": spaceId,
        "bucket_id": bucketId,
      };

      var res = await _dio.delete(
        Endpoints.bucket,
        data: data,
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return res;
    } catch (error) {
      if (error is DioException && error.response != null) {
        return DioError(
          requestOptions: error.requestOptions,
          error: error.response?.data['message'],
        );
      } else {
        print(
          error.toString(),
        );
        rethrow;
      }
    }
  }

  Future getFaq() async {
    try {
      var res = await _dio.get(
        Endpoints.faq,
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future getNotice() async {
    try {
      var res = await _dio.get(
        Endpoints.notice,
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }
}
