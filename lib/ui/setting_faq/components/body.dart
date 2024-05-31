import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/faq/faq.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/setting_ui/setting_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  SettingUiStore _uiStore = SettingUiStore();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nicknameController = TextEditingController();
  late FocusNode _nicknameFocusNode;

  List<Faq> faqList = [
    Faq(
      id: "0",
      imageUrl: "assets/icons/setting_faq_link_icon.svg",
      title: "상대방과의 연결을 끊고 싶어요",
      subTitle: "연결",
      contentText: "상대방과의 연결해제는 마이페이지에서 설정하실 수 있습니다.",
      expanded: false,
    ),
    Faq(
      id: "1",
      imageUrl: "assets/icons/setting_faq_light_icon.svg",
      title: "제가 원하는 카테고리 추가하고 싶어요",
      subTitle: "카테고리",
      contentText: "상대방과의 연결해제는 마이페이지에서 설정하실 수 있습니다.",
      expanded: false,
    ),
    Faq(
      id: "2",
      imageUrl: "assets/icons/setting_faq_message_icon.svg",
      title: "초대코드로 앱을 실행해도 연동이 안돼요",
      subTitle: "카테고리",
      contentText: "상대방과의 연결해제는 마이페이지에서 설정하실 수 있습니다.",
      expanded: false,
    ),
  ];

  @override
  void initState() {
    _uiStore = SettingUiStore();
    _nicknameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
    }

    _nicknameController.text = _userStore!.user!.nickname;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) => Column(
          children: [
            _buildTopBar(),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.gray20,
            ),
            ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 300),
              elevation: 0,
              dividerColor: Colors.transparent,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  Faq item = Faq(
                    id: faqList[panelIndex].id,
                    imageUrl: faqList[panelIndex].imageUrl,
                    title: faqList[panelIndex].title,
                    subTitle: faqList[panelIndex].subTitle,
                    contentText: faqList[panelIndex].contentText,
                    expanded: !faqList[panelIndex].expanded,
                  );

                  faqList[panelIndex] = item;
                });
              },
              children: [
                ...List.generate(
                  faqList.length,
                  (index) {
                    Faq item = faqList[index];
                    return _buildItems(
                      image: SvgPicture.asset(
                        item.imageUrl,
                        width: 20.w,
                        height: 20.h,
                      ),
                      title: item.title,
                      subTitle: item.subTitle,
                      contentText: item.contentText,
                      isExpanded: item.expanded,
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.only(
        top: 14.h,
        bottom: 14.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    context.router.pop();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/chevron_left_icon.svg',
                    width: 20.w,
                    height: 15.h,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "공지사항",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ExpansionPanel _buildItems({
    required Widget image,
    required String title,
    required String subTitle,
    required String contentText,
    required bool isExpanded,
  }) {
    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: Colors.white,
      isExpanded: isExpanded,
      headerBuilder: (context, isExpanded) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: image,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    subTitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.tertiaryBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: AutoSizeText(
          contentText,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryBlack,
          ),
        ),
      ),
    );
  }
}
