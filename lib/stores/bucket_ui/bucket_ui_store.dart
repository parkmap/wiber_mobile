import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/category/category.dart';

part 'bucket_ui_store.g.dart';

@injectable
class BucketUIStore = _BucketUIStore with _$BucketUIStore;

abstract class _BucketUIStore with Store {
  // repository instance

  // store variables:-----------------------------------------------------------
  @observable
  int selectedTabIndex = 0;

  @observable
  int selectedCategoryIndex = -1;

  @observable
  String selectedCategory = '';

  @observable
  String editingCategoryName = "";

  @observable
  String newBucketName = "";

  @observable
  String newBucketDescription = "";

  @observable
  String newBucketEndDate = "";

  @observable
  String newBucketDetailCategory = "";

  @observable
  int createNewBucketPhase = 0;

  @observable
  bool isEditing = false;

  @observable
  Bucket? tempBucket;

  @observable
  Category? tempSelectedCategory;

  @observable
  List<String> sortingList = [
    "등록일 기준",
    "완료일 기준",
  ];

  @observable
  String selectedSort = "등록일 기준";

  // getters:-------------------------------------------------------------------

  @computed
  bool get canEditCategoryName =>
      editingCategoryName.isNotEmpty && selectedCategory != editingCategoryName;

  // constructor:---------------------------------------------------------------
  // actions:-------------------------------------------------------------------
  @action
  void setSelectedTabIndex(int val) {
    selectedTabIndex = val;
  }

  @action
  void setSelectedCategoryIndex(int val) {
    selectedCategoryIndex = val;
  }

  @action
  void setSelectedCategory(String val) {
    selectedCategory = val;
  }

  @action
  void setEditingCategoryName(String val) {
    editingCategoryName = val;
  }

  @action
  void setNewBucketName(String val) {
    newBucketName = val;
  }

  @action
  void setNewBucketDescription(String val) {
    newBucketDescription = val;
  }

  @action
  void setNewBucketEndDate(String val) {
    newBucketEndDate = val;
  }

  @action
  void setCreateNewBucketPhase(int val) {
    createNewBucketPhase = val;
  }

  @action
  void setNewBucketDetailCategory(String val) {
    newBucketDetailCategory = val;
  }

  @action
  void setSelectedSort(String val) {
    selectedSort = val;
  }

  @action
  void resetNewBucketDatas() {
    createNewBucketPhase = 0;
    newBucketName = "";
    newBucketDescription = "";
    newBucketEndDate = "";
  }
}
