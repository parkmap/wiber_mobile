import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';

part 'home_ui_store.g.dart';

@injectable
class HomeUIStore = _HomeUIStore with _$HomeUIStore;

abstract class _HomeUIStore with Store {
  // repository instance

  // store variables:-----------------------------------------------------------
  @observable
  int selectedTabIndex = 0;

  @observable
  int selectedCategoryIndex = 0;

  @observable
  String selectedCategory = '';

  @observable
  String editingCategoryName = "";

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
}
