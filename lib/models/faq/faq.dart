import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq.g.dart';
part 'faq.freezed.dart';

@freezed
class Faq with _$Faq {
  const Faq._();

  factory Faq({
    @JsonKey(name: '_id') @Default('') String id,
    required String imageUrl,
    required String title,
    required String subTitle,
    required String contentText,
    required bool expanded,
  }) = _Faq;

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
}
