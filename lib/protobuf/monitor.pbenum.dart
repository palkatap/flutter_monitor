///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart';

class NormalizeType extends ProtobufEnum {
  static const NormalizeType NOT_NORM = const NormalizeType._(0, 'NOT_NORM');
  static const NormalizeType NORM_TO_TARGET = const NormalizeType._(1, 'NORM_TO_TARGET');
  static const NormalizeType NORM_TO_SPEC = const NormalizeType._(2, 'NORM_TO_SPEC');
  static const NormalizeType NORM_TO_CL = const NormalizeType._(3, 'NORM_TO_CL');

  static const List<NormalizeType> values = const <NormalizeType> [
    NOT_NORM,
    NORM_TO_TARGET,
    NORM_TO_SPEC,
    NORM_TO_CL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static NormalizeType valueOf(int value) => _byValue[value] as NormalizeType;
  static void $checkItem(NormalizeType v) {
    if (v is! NormalizeType) checkItemFailed(v, 'NormalizeType');
  }

  const NormalizeType._(int v, String n) : super(v, n);
}

