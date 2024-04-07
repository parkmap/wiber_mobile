import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/data/dio_client.dart';
import 'package:wiber_mobile/models/listing/bucket.dart';
import 'package:wiber_mobile/models/listing/bucket_list.dart';

@lazySingleton
class UserApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserApi(this._dioClient);

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
}
