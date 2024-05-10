import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/data/dio_client.dart';
import 'package:wiber_mobile/data/network/constants/endpoints.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/bucket/bucket_list.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space_list.dart';

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
    required String push_token,
  }) async {
    try {
      var data = {
        "username": username,
        "app_uuid": app_uuid,
        "push_token": push_token,
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

  Future saveProfileImage(
      {required MultipartFile profileImage,
      required String userId,
      required String uuid}) async {
    try {
      String basicAuth = 'Basic ' + base64.encode(utf8.encode('$userId:$uuid'));
      var formData = FormData.fromMap({'image': profileImage});

      // var res = await _dioClient.put(
      //   Endpoints.uploadProfileImage,
      //   data: formData,
      // );

      var res = await _dio.put(Endpoints.uploadProfileImage,
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': basicAuth
            },
          ));

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  Future<String> getUserNickname() async {
    try {
      var res = "위버";
      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      var res = [
        "카테고리1",
        "카테고리2",
        "카테고리3",
        "카테고리4",
        "카테고리5",
        "카테고리6",
        "카테고리7",
        "카테고리8",
        "카테고리9",
      ];
      return res;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<BucketList> getBucketList() async {
    try {
      List<Bucket> dummyBucket = List.generate(
        50,
        (index) => Bucket(
          title: '버켓 ${index + 1}',
          body: '간략한 버켓 설명 ${index + 1}',
          category: '카테고리${(index + 1) % 9}',
          isCompleted: Random().nextBool(),
          endDate: "2024년 12월 31일",
        ),
      );

      var res = BucketList(
        list: dummyBucket,
        totalCount: 3,
        nextPage: 1,
      );
      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future<User> getUserInfo() async {
    try {
      var res = User(
        id: "0",
        nickname: "위버",
        profileImageUrl: "assets/images/default_profile_image.png",
      );

      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }

  Future<WiberSpaceList> getWiberSpaceListByUser(String userId) async {
    try {
      var res = WiberSpaceList(
        list: [
          WiberSpace(
            id: "0",
            title: "위버스페이스1",
            isFavorite: true,
            maxCount: 30,
            completeCount: 12,
            owner: "0",
            participants: [
              User(
                id: "0",
                nickname: "위버",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "1",
                nickname: "위버2",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "2",
                nickname: "위버3",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
            ],
          ),
          WiberSpace(
            id: "1",
            title: "위버스페이스2",
            isFavorite: true,
            maxCount: 30,
            completeCount: 19,
            owner: "1",
            participants: [
              User(
                id: "0",
                nickname: "위버",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "1",
                nickname: "위버2",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "2",
                nickname: "위버3",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "3",
                nickname: "위버4",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
              User(
                id: "4",
                nickname: "위버5",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
            ],
          ),
          WiberSpace(
            id: "2",
            title: "위버스페이스3",
            isFavorite: true,
            maxCount: 30,
            completeCount: 19,
            owner: "0",
            participants: [
              User(
                id: "0",
                nickname: "위버",
                profileImageUrl: "assets/images/default_profile_image.png",
              ),
            ],
          ),
        ],
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
