///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'monitor.pbenum.dart';

export 'monitor.pbenum.dart';

class Exkey extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Exkey')
    ..aOS(1, 'exkeyName')
    ..aOS(2, 'fixedFilter')
    ..hasRequiredFields = false
  ;

  Exkey() : super();
  Exkey.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Exkey.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Exkey clone() => new Exkey()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Exkey create() => new Exkey();
  static PbList<Exkey> createRepeated() => new PbList<Exkey>();
  static Exkey getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExkey();
    return _defaultInstance;
  }
  static Exkey _defaultInstance;
  static void $checkItem(Exkey v) {
    if (v is! Exkey) checkItemFailed(v, 'Exkey');
  }

  String get exkeyName => $_getS(0, '');
  set exkeyName(String v) { $_setString(0, v); }
  bool hasExkeyName() => $_has(0);
  void clearExkeyName() => clearField(1);

  String get fixedFilter => $_getS(1, '');
  set fixedFilter(String v) { $_setString(1, v); }
  bool hasFixedFilter() => $_has(1);
  void clearFixedFilter() => clearField(2);
}

class _ReadonlyExkey extends Exkey with ReadonlyMessageMixin {}

class DisplayRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DisplayRule')
    ..a<int>(1, 'chartTypeId', PbFieldType.O3)
    ..a<int>(2, 'displayRule', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DisplayRule() : super();
  DisplayRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DisplayRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DisplayRule clone() => new DisplayRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DisplayRule create() => new DisplayRule();
  static PbList<DisplayRule> createRepeated() => new PbList<DisplayRule>();
  static DisplayRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDisplayRule();
    return _defaultInstance;
  }
  static DisplayRule _defaultInstance;
  static void $checkItem(DisplayRule v) {
    if (v is! DisplayRule) checkItemFailed(v, 'DisplayRule');
  }

  int get chartTypeId => $_get(0, 0);
  set chartTypeId(int v) { $_setSignedInt32(0, v); }
  bool hasChartTypeId() => $_has(0);
  void clearChartTypeId() => clearField(1);

  int get displayRule => $_get(1, 0);
  set displayRule(int v) { $_setSignedInt32(1, v); }
  bool hasDisplayRule() => $_has(1);
  void clearDisplayRule() => clearField(2);
}

class _ReadonlyDisplayRule extends DisplayRule with ReadonlyMessageMixin {}

class Violation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Violation')
    ..a<int>(1, 'valTypeId', PbFieldType.O3)
    ..aInt64(2, 'lastViolWinSmp')
    ..hasRequiredFields = false
  ;

  Violation() : super();
  Violation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Violation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Violation clone() => new Violation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Violation create() => new Violation();
  static PbList<Violation> createRepeated() => new PbList<Violation>();
  static Violation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyViolation();
    return _defaultInstance;
  }
  static Violation _defaultInstance;
  static void $checkItem(Violation v) {
    if (v is! Violation) checkItemFailed(v, 'Violation');
  }

  int get valTypeId => $_get(0, 0);
  set valTypeId(int v) { $_setSignedInt32(0, v); }
  bool hasValTypeId() => $_has(0);
  void clearValTypeId() => clearField(1);

  Int64 get lastViolWinSmp => $_getI64(1);
  set lastViolWinSmp(Int64 v) { $_setInt64(1, v); }
  bool hasLastViolWinSmp() => $_has(1);
  void clearLastViolWinSmp() => clearField(2);
}

class _ReadonlyViolation extends Violation with ReadonlyMessageMixin {}

class RawValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RawValue')
    ..a<double>(1, 'rawValue', PbFieldType.OD)
    ..pPS(2, 'rawExval')
    ..pPS(3, 'rawDaval')
    ..hasRequiredFields = false
  ;

  RawValue() : super();
  RawValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RawValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RawValue clone() => new RawValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RawValue create() => new RawValue();
  static PbList<RawValue> createRepeated() => new PbList<RawValue>();
  static RawValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRawValue();
    return _defaultInstance;
  }
  static RawValue _defaultInstance;
  static void $checkItem(RawValue v) {
    if (v is! RawValue) checkItemFailed(v, 'RawValue');
  }

  double get rawValue => $_getN(0);
  set rawValue(double v) { $_setDouble(0, v); }
  bool hasRawValue() => $_has(0);
  void clearRawValue() => clearField(1);

  List<String> get rawExval => $_getList(1);

  List<String> get rawDaval => $_getList(2);
}

class _ReadonlyRawValue extends RawValue with ReadonlyMessageMixin {}

class Guidis extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Guidis')
    ..a<int>(1, 'ldsId', PbFieldType.O3)
    ..aOS(2, 'ldsName')
    ..a<int>(3, 'folderId', PbFieldType.O3)
    ..aOS(4, 'folderName')
    ..a<int>(5, 'chId', PbFieldType.O3)
    ..a<int>(6, 'ckcId', PbFieldType.O3)
    ..aOS(7, 'chName')
    ..aOS(8, 'ckcName')
    ..aOS(9, 'chDescr')
    ..aOS(10, 'ckcDescr')
    ..aOS(11, 'parameterName')
    ..aOS(12, 'parameterUnit')
    ..a<int>(13, 'defMatchDefId', PbFieldType.O3)
    ..aOS(14, 'matchModeFlag')
    ..aOS(15, 'owner')
    ..a<int>(16, 'permDomainId', PbFieldType.O3)
    ..aOS(17, 'violMailAddr')
    ..a<int>(18, 'mpcDefId', PbFieldType.O3)
    ..aOS(19, 'commentReqFlag')
    ..a<int>(20, 'tsgDisplayMode', PbFieldType.O3)
    ..a<int>(21, 'digits', PbFieldType.O3)
    ..a<int>(22, 'serverTime', PbFieldType.O3)
    ..a<List<int>>(23, 'chartSetupBlob', PbFieldType.OY)
    ..e<NormalizeType>(24, 'normalizeType', PbFieldType.OE, NormalizeType.NOT_NORM, NormalizeType.valueOf, NormalizeType.values)
    ..aOS(25, 'fixedScaleLimits')
    ..a<int>(26, 'chartDesignId', PbFieldType.O3)
    ..pp<Exkey>(27, 'exkeys', PbFieldType.PM, Exkey.$checkItem, Exkey.create)
    ..pPS(28, 'dakeyNames')
    ..pPS(29, 'routingAddress')
    ..pp<DisplayRule>(30, 'displayRules', PbFieldType.PM, DisplayRule.$checkItem, DisplayRule.create)
    ..aInt64(31, 'localTimestamp')
    ..a<int>(32, 'currSampleIdIdx', PbFieldType.O3)
    ..aInt64(33, 'currSampleId')
    ..a<int>(34, 'prioValTypeId', PbFieldType.O3)
    ..pPS(35, 'routeAddress')
    ..pp<Sample>(400, 'samples', PbFieldType.PM, Sample.$checkItem, Sample.create)
    ..pp<CA>(401, 'cas', PbFieldType.PM, CA.$checkItem, CA.create)
    ..pp<TSG>(402, 'tsgs', PbFieldType.PM, TSG.$checkItem, TSG.create)
    ..pp<Alarm>(403, 'alarms', PbFieldType.PM, Alarm.$checkItem, Alarm.create)
    ..hasRequiredFields = false
  ;

  Guidis() : super();
  Guidis.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Guidis.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Guidis clone() => new Guidis()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Guidis create() => new Guidis();
  static PbList<Guidis> createRepeated() => new PbList<Guidis>();
  static Guidis getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGuidis();
    return _defaultInstance;
  }
  static Guidis _defaultInstance;
  static void $checkItem(Guidis v) {
    if (v is! Guidis) checkItemFailed(v, 'Guidis');
  }

  int get ldsId => $_get(0, 0);
  set ldsId(int v) { $_setSignedInt32(0, v); }
  bool hasLdsId() => $_has(0);
  void clearLdsId() => clearField(1);

  String get ldsName => $_getS(1, '');
  set ldsName(String v) { $_setString(1, v); }
  bool hasLdsName() => $_has(1);
  void clearLdsName() => clearField(2);

  int get folderId => $_get(2, 0);
  set folderId(int v) { $_setSignedInt32(2, v); }
  bool hasFolderId() => $_has(2);
  void clearFolderId() => clearField(3);

  String get folderName => $_getS(3, '');
  set folderName(String v) { $_setString(3, v); }
  bool hasFolderName() => $_has(3);
  void clearFolderName() => clearField(4);

  int get chId => $_get(4, 0);
  set chId(int v) { $_setSignedInt32(4, v); }
  bool hasChId() => $_has(4);
  void clearChId() => clearField(5);

  int get ckcId => $_get(5, 0);
  set ckcId(int v) { $_setSignedInt32(5, v); }
  bool hasCkcId() => $_has(5);
  void clearCkcId() => clearField(6);

  String get chName => $_getS(6, '');
  set chName(String v) { $_setString(6, v); }
  bool hasChName() => $_has(6);
  void clearChName() => clearField(7);

  String get ckcName => $_getS(7, '');
  set ckcName(String v) { $_setString(7, v); }
  bool hasCkcName() => $_has(7);
  void clearCkcName() => clearField(8);

  String get chDescr => $_getS(8, '');
  set chDescr(String v) { $_setString(8, v); }
  bool hasChDescr() => $_has(8);
  void clearChDescr() => clearField(9);

  String get ckcDescr => $_getS(9, '');
  set ckcDescr(String v) { $_setString(9, v); }
  bool hasCkcDescr() => $_has(9);
  void clearCkcDescr() => clearField(10);

  String get parameterName => $_getS(10, '');
  set parameterName(String v) { $_setString(10, v); }
  bool hasParameterName() => $_has(10);
  void clearParameterName() => clearField(11);

  String get parameterUnit => $_getS(11, '');
  set parameterUnit(String v) { $_setString(11, v); }
  bool hasParameterUnit() => $_has(11);
  void clearParameterUnit() => clearField(12);

  int get defMatchDefId => $_get(12, 0);
  set defMatchDefId(int v) { $_setSignedInt32(12, v); }
  bool hasDefMatchDefId() => $_has(12);
  void clearDefMatchDefId() => clearField(13);

  String get matchModeFlag => $_getS(13, '');
  set matchModeFlag(String v) { $_setString(13, v); }
  bool hasMatchModeFlag() => $_has(13);
  void clearMatchModeFlag() => clearField(14);

  String get owner => $_getS(14, '');
  set owner(String v) { $_setString(14, v); }
  bool hasOwner() => $_has(14);
  void clearOwner() => clearField(15);

  int get permDomainId => $_get(15, 0);
  set permDomainId(int v) { $_setSignedInt32(15, v); }
  bool hasPermDomainId() => $_has(15);
  void clearPermDomainId() => clearField(16);

  String get violMailAddr => $_getS(16, '');
  set violMailAddr(String v) { $_setString(16, v); }
  bool hasViolMailAddr() => $_has(16);
  void clearViolMailAddr() => clearField(17);

  int get mpcDefId => $_get(17, 0);
  set mpcDefId(int v) { $_setSignedInt32(17, v); }
  bool hasMpcDefId() => $_has(17);
  void clearMpcDefId() => clearField(18);

  String get commentReqFlag => $_getS(18, '');
  set commentReqFlag(String v) { $_setString(18, v); }
  bool hasCommentReqFlag() => $_has(18);
  void clearCommentReqFlag() => clearField(19);

  int get tsgDisplayMode => $_get(19, 0);
  set tsgDisplayMode(int v) { $_setSignedInt32(19, v); }
  bool hasTsgDisplayMode() => $_has(19);
  void clearTsgDisplayMode() => clearField(20);

  int get digits => $_get(20, 0);
  set digits(int v) { $_setSignedInt32(20, v); }
  bool hasDigits() => $_has(20);
  void clearDigits() => clearField(21);

  int get serverTime => $_get(21, 0);
  set serverTime(int v) { $_setSignedInt32(21, v); }
  bool hasServerTime() => $_has(21);
  void clearServerTime() => clearField(22);

  List<int> get chartSetupBlob => $_getN(22);
  set chartSetupBlob(List<int> v) { $_setBytes(22, v); }
  bool hasChartSetupBlob() => $_has(22);
  void clearChartSetupBlob() => clearField(23);

  NormalizeType get normalizeType => $_getN(23);
  set normalizeType(NormalizeType v) { setField(24, v); }
  bool hasNormalizeType() => $_has(23);
  void clearNormalizeType() => clearField(24);

  String get fixedScaleLimits => $_getS(24, '');
  set fixedScaleLimits(String v) { $_setString(24, v); }
  bool hasFixedScaleLimits() => $_has(24);
  void clearFixedScaleLimits() => clearField(25);

  int get chartDesignId => $_get(25, 0);
  set chartDesignId(int v) { $_setSignedInt32(25, v); }
  bool hasChartDesignId() => $_has(25);
  void clearChartDesignId() => clearField(26);

  List<Exkey> get exkeys => $_getList(26);

  List<String> get dakeyNames => $_getList(27);

  List<String> get routingAddress => $_getList(28);

  List<DisplayRule> get displayRules => $_getList(29);

  Int64 get localTimestamp => $_getI64(30);
  set localTimestamp(Int64 v) { $_setInt64(30, v); }
  bool hasLocalTimestamp() => $_has(30);
  void clearLocalTimestamp() => clearField(31);

  int get currSampleIdIdx => $_get(31, 0);
  set currSampleIdIdx(int v) { $_setSignedInt32(31, v); }
  bool hasCurrSampleIdIdx() => $_has(31);
  void clearCurrSampleIdIdx() => clearField(32);

  Int64 get currSampleId => $_getI64(32);
  set currSampleId(Int64 v) { $_setInt64(32, v); }
  bool hasCurrSampleId() => $_has(32);
  void clearCurrSampleId() => clearField(33);

  int get prioValTypeId => $_get(33, 0);
  set prioValTypeId(int v) { $_setSignedInt32(33, v); }
  bool hasPrioValTypeId() => $_has(33);
  void clearPrioValTypeId() => clearField(34);

  List<String> get routeAddress => $_getList(34);

  List<Sample> get samples => $_getList(35);

  List<CA> get cas => $_getList(36);

  List<TSG> get tsgs => $_getList(37);

  List<Alarm> get alarms => $_getList(38);
}

class _ReadonlyGuidis extends Guidis with ReadonlyMessageMixin {}

class Sample extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Sample')
    ..aInt64(1, 'sampleId')
    ..a<int>(2, 'sampleDate', PbFieldType.O3)
    ..aOS(3, 'spcComExtern')
    ..aOS(4, 'spcFlagExtern')
    ..aOS(5, 'spcComIntern')
    ..aOS(6, 'spcFlagIntern')
    ..pp<Violation>(7, 'violations', PbFieldType.PM, Violation.$checkItem, Violation.create)
    ..a<int>(8, 'prioValTypeId', PbFieldType.O3)
    ..aOS(9, 'violComment')
    ..a<int>(10, 'violCommentDate', PbFieldType.O3)
    ..aOS(11, 'violCommentFlag')
    ..pPS(12, 'exkeyValue')
    ..pPS(13, 'dakeyValue')
    ..aOS(14, 'rawValueFlag')
    ..a<double>(15, 'specUpper', PbFieldType.OD)
    ..a<double>(16, 'specTarget', PbFieldType.OD)
    ..a<double>(17, 'specLower', PbFieldType.OD)
    ..aOS(18, 'specTargetOrigin')
    ..aOS(19, 'specLimitEnable')
    ..a<double>(20, 'extSpecUpper', PbFieldType.OD)
    ..a<double>(21, 'extSpecLower', PbFieldType.OD)
    ..a<double>(22, 'extSigma', PbFieldType.OD)
    ..a<double>(23, 'extMv', PbFieldType.OD)
    ..a<double>(24, 'extMin', PbFieldType.OD)
    ..a<double>(25, 'extMax', PbFieldType.OD)
    ..a<double>(26, 'extMedian', PbFieldType.OD)
    ..a<double>(27, 'extQ1', PbFieldType.OD)
    ..a<double>(28, 'extQ3', PbFieldType.OD)
    ..a<int>(29, 'extSampleSize', PbFieldType.O3)
    ..a<double>(30, 'ewmaMv', PbFieldType.OD)
    ..a<double>(31, 'maMv', PbFieldType.OD)
    ..a<double>(32, 'ewmaS', PbFieldType.OD)
    ..a<double>(33, 'ewmaR', PbFieldType.OD)
    ..a<double>(34, 'msMv', PbFieldType.OD)
    ..aOS(35, 'limitEnable')
    ..a<int>(36, 'clOrigin', PbFieldType.O3)
    ..a<double>(37, 'mvLcl', PbFieldType.OD)
    ..a<double>(38, 'mvLal', PbFieldType.OD)
    ..a<double>(39, 'mvCenter', PbFieldType.OD)
    ..a<double>(40, 'mvUal', PbFieldType.OD)
    ..a<double>(41, 'mvUcl', PbFieldType.OD)
    ..a<double>(42, 'rawLcl', PbFieldType.OD)
    ..a<double>(43, 'rawLal', PbFieldType.OD)
    ..a<double>(44, 'rawCenter', PbFieldType.OD)
    ..a<double>(45, 'rawUal', PbFieldType.OD)
    ..a<double>(46, 'rawUcl', PbFieldType.OD)
    ..a<double>(47, 'sLcl', PbFieldType.OD)
    ..a<double>(48, 'sLal', PbFieldType.OD)
    ..a<double>(49, 'sCenter', PbFieldType.OD)
    ..a<double>(50, 'sUal', PbFieldType.OD)
    ..a<double>(51, 'sUcl', PbFieldType.OD)
    ..a<double>(52, 'rLcl', PbFieldType.OD)
    ..a<double>(53, 'rLal', PbFieldType.OD)
    ..a<double>(54, 'rCenter', PbFieldType.OD)
    ..a<double>(55, 'rUal', PbFieldType.OD)
    ..a<double>(56, 'rUcl', PbFieldType.OD)
    ..a<double>(57, 'ewmaMvLcl', PbFieldType.OD)
    ..a<double>(58, 'ewmaMvCenter', PbFieldType.OD)
    ..a<double>(59, 'ewmaMvUcl', PbFieldType.OD)
    ..a<double>(60, 'maMvLcl', PbFieldType.OD)
    ..a<double>(61, 'maMvCenter', PbFieldType.OD)
    ..a<double>(62, 'maMvUcl', PbFieldType.OD)
    ..a<double>(63, 'ewmaSLcl', PbFieldType.OD)
    ..a<double>(64, 'ewmaSCenter', PbFieldType.OD)
    ..a<double>(65, 'ewmaSUcl', PbFieldType.OD)
    ..a<double>(66, 'ewmaRLcl', PbFieldType.OD)
    ..a<double>(67, 'ewmaRCenter', PbFieldType.OD)
    ..a<double>(68, 'ewmaRUcl', PbFieldType.OD)
    ..a<double>(69, 'msMvLcl', PbFieldType.OD)
    ..a<double>(70, 'msMvCenter', PbFieldType.OD)
    ..a<double>(71, 'msMvUcl', PbFieldType.OD)
    ..pp<RawValue>(72, 'raws', PbFieldType.PM, RawValue.$checkItem, RawValue.create)
    ..pp<SampleTag>(73, 'sampleTags', PbFieldType.PM, SampleTag.$checkItem, SampleTag.create)
    ..pp<Attr>(74, 'attr', PbFieldType.PM, Attr.$checkItem, Attr.create)
    ..hasRequiredFields = false
  ;

  Sample() : super();
  Sample.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Sample.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Sample clone() => new Sample()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Sample create() => new Sample();
  static PbList<Sample> createRepeated() => new PbList<Sample>();
  static Sample getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySample();
    return _defaultInstance;
  }
  static Sample _defaultInstance;
  static void $checkItem(Sample v) {
    if (v is! Sample) checkItemFailed(v, 'Sample');
  }

  Int64 get sampleId => $_getI64(0);
  set sampleId(Int64 v) { $_setInt64(0, v); }
  bool hasSampleId() => $_has(0);
  void clearSampleId() => clearField(1);

  int get sampleDate => $_get(1, 0);
  set sampleDate(int v) { $_setSignedInt32(1, v); }
  bool hasSampleDate() => $_has(1);
  void clearSampleDate() => clearField(2);

  String get spcComExtern => $_getS(2, '');
  set spcComExtern(String v) { $_setString(2, v); }
  bool hasSpcComExtern() => $_has(2);
  void clearSpcComExtern() => clearField(3);

  String get spcFlagExtern => $_getS(3, '');
  set spcFlagExtern(String v) { $_setString(3, v); }
  bool hasSpcFlagExtern() => $_has(3);
  void clearSpcFlagExtern() => clearField(4);

  String get spcComIntern => $_getS(4, '');
  set spcComIntern(String v) { $_setString(4, v); }
  bool hasSpcComIntern() => $_has(4);
  void clearSpcComIntern() => clearField(5);

  String get spcFlagIntern => $_getS(5, '');
  set spcFlagIntern(String v) { $_setString(5, v); }
  bool hasSpcFlagIntern() => $_has(5);
  void clearSpcFlagIntern() => clearField(6);

  List<Violation> get violations => $_getList(6);

  int get prioValTypeId => $_get(7, 0);
  set prioValTypeId(int v) { $_setSignedInt32(7, v); }
  bool hasPrioValTypeId() => $_has(7);
  void clearPrioValTypeId() => clearField(8);

  String get violComment => $_getS(8, '');
  set violComment(String v) { $_setString(8, v); }
  bool hasViolComment() => $_has(8);
  void clearViolComment() => clearField(9);

  int get violCommentDate => $_get(9, 0);
  set violCommentDate(int v) { $_setSignedInt32(9, v); }
  bool hasViolCommentDate() => $_has(9);
  void clearViolCommentDate() => clearField(10);

  String get violCommentFlag => $_getS(10, '');
  set violCommentFlag(String v) { $_setString(10, v); }
  bool hasViolCommentFlag() => $_has(10);
  void clearViolCommentFlag() => clearField(11);

  List<String> get exkeyValue => $_getList(11);

  List<String> get dakeyValue => $_getList(12);

  String get rawValueFlag => $_getS(13, '');
  set rawValueFlag(String v) { $_setString(13, v); }
  bool hasRawValueFlag() => $_has(13);
  void clearRawValueFlag() => clearField(14);

  double get specUpper => $_getN(14);
  set specUpper(double v) { $_setDouble(14, v); }
  bool hasSpecUpper() => $_has(14);
  void clearSpecUpper() => clearField(15);

  double get specTarget => $_getN(15);
  set specTarget(double v) { $_setDouble(15, v); }
  bool hasSpecTarget() => $_has(15);
  void clearSpecTarget() => clearField(16);

  double get specLower => $_getN(16);
  set specLower(double v) { $_setDouble(16, v); }
  bool hasSpecLower() => $_has(16);
  void clearSpecLower() => clearField(17);

  String get specTargetOrigin => $_getS(17, '');
  set specTargetOrigin(String v) { $_setString(17, v); }
  bool hasSpecTargetOrigin() => $_has(17);
  void clearSpecTargetOrigin() => clearField(18);

  String get specLimitEnable => $_getS(18, '');
  set specLimitEnable(String v) { $_setString(18, v); }
  bool hasSpecLimitEnable() => $_has(18);
  void clearSpecLimitEnable() => clearField(19);

  double get extSpecUpper => $_getN(19);
  set extSpecUpper(double v) { $_setDouble(19, v); }
  bool hasExtSpecUpper() => $_has(19);
  void clearExtSpecUpper() => clearField(20);

  double get extSpecLower => $_getN(20);
  set extSpecLower(double v) { $_setDouble(20, v); }
  bool hasExtSpecLower() => $_has(20);
  void clearExtSpecLower() => clearField(21);

  double get extSigma => $_getN(21);
  set extSigma(double v) { $_setDouble(21, v); }
  bool hasExtSigma() => $_has(21);
  void clearExtSigma() => clearField(22);

  double get extMv => $_getN(22);
  set extMv(double v) { $_setDouble(22, v); }
  bool hasExtMv() => $_has(22);
  void clearExtMv() => clearField(23);

  double get extMin => $_getN(23);
  set extMin(double v) { $_setDouble(23, v); }
  bool hasExtMin() => $_has(23);
  void clearExtMin() => clearField(24);

  double get extMax => $_getN(24);
  set extMax(double v) { $_setDouble(24, v); }
  bool hasExtMax() => $_has(24);
  void clearExtMax() => clearField(25);

  double get extMedian => $_getN(25);
  set extMedian(double v) { $_setDouble(25, v); }
  bool hasExtMedian() => $_has(25);
  void clearExtMedian() => clearField(26);

  double get extQ1 => $_getN(26);
  set extQ1(double v) { $_setDouble(26, v); }
  bool hasExtQ1() => $_has(26);
  void clearExtQ1() => clearField(27);

  double get extQ3 => $_getN(27);
  set extQ3(double v) { $_setDouble(27, v); }
  bool hasExtQ3() => $_has(27);
  void clearExtQ3() => clearField(28);

  int get extSampleSize => $_get(28, 0);
  set extSampleSize(int v) { $_setSignedInt32(28, v); }
  bool hasExtSampleSize() => $_has(28);
  void clearExtSampleSize() => clearField(29);

  double get ewmaMv => $_getN(29);
  set ewmaMv(double v) { $_setDouble(29, v); }
  bool hasEwmaMv() => $_has(29);
  void clearEwmaMv() => clearField(30);

  double get maMv => $_getN(30);
  set maMv(double v) { $_setDouble(30, v); }
  bool hasMaMv() => $_has(30);
  void clearMaMv() => clearField(31);

  double get ewmaS => $_getN(31);
  set ewmaS(double v) { $_setDouble(31, v); }
  bool hasEwmaS() => $_has(31);
  void clearEwmaS() => clearField(32);

  double get ewmaR => $_getN(32);
  set ewmaR(double v) { $_setDouble(32, v); }
  bool hasEwmaR() => $_has(32);
  void clearEwmaR() => clearField(33);

  double get msMv => $_getN(33);
  set msMv(double v) { $_setDouble(33, v); }
  bool hasMsMv() => $_has(33);
  void clearMsMv() => clearField(34);

  String get limitEnable => $_getS(34, '');
  set limitEnable(String v) { $_setString(34, v); }
  bool hasLimitEnable() => $_has(34);
  void clearLimitEnable() => clearField(35);

  int get clOrigin => $_get(35, 0);
  set clOrigin(int v) { $_setSignedInt32(35, v); }
  bool hasClOrigin() => $_has(35);
  void clearClOrigin() => clearField(36);

  double get mvLcl => $_getN(36);
  set mvLcl(double v) { $_setDouble(36, v); }
  bool hasMvLcl() => $_has(36);
  void clearMvLcl() => clearField(37);

  double get mvLal => $_getN(37);
  set mvLal(double v) { $_setDouble(37, v); }
  bool hasMvLal() => $_has(37);
  void clearMvLal() => clearField(38);

  double get mvCenter => $_getN(38);
  set mvCenter(double v) { $_setDouble(38, v); }
  bool hasMvCenter() => $_has(38);
  void clearMvCenter() => clearField(39);

  double get mvUal => $_getN(39);
  set mvUal(double v) { $_setDouble(39, v); }
  bool hasMvUal() => $_has(39);
  void clearMvUal() => clearField(40);

  double get mvUcl => $_getN(40);
  set mvUcl(double v) { $_setDouble(40, v); }
  bool hasMvUcl() => $_has(40);
  void clearMvUcl() => clearField(41);

  double get rawLcl => $_getN(41);
  set rawLcl(double v) { $_setDouble(41, v); }
  bool hasRawLcl() => $_has(41);
  void clearRawLcl() => clearField(42);

  double get rawLal => $_getN(42);
  set rawLal(double v) { $_setDouble(42, v); }
  bool hasRawLal() => $_has(42);
  void clearRawLal() => clearField(43);

  double get rawCenter => $_getN(43);
  set rawCenter(double v) { $_setDouble(43, v); }
  bool hasRawCenter() => $_has(43);
  void clearRawCenter() => clearField(44);

  double get rawUal => $_getN(44);
  set rawUal(double v) { $_setDouble(44, v); }
  bool hasRawUal() => $_has(44);
  void clearRawUal() => clearField(45);

  double get rawUcl => $_getN(45);
  set rawUcl(double v) { $_setDouble(45, v); }
  bool hasRawUcl() => $_has(45);
  void clearRawUcl() => clearField(46);

  double get sLcl => $_getN(46);
  set sLcl(double v) { $_setDouble(46, v); }
  bool hasSLcl() => $_has(46);
  void clearSLcl() => clearField(47);

  double get sLal => $_getN(47);
  set sLal(double v) { $_setDouble(47, v); }
  bool hasSLal() => $_has(47);
  void clearSLal() => clearField(48);

  double get sCenter => $_getN(48);
  set sCenter(double v) { $_setDouble(48, v); }
  bool hasSCenter() => $_has(48);
  void clearSCenter() => clearField(49);

  double get sUal => $_getN(49);
  set sUal(double v) { $_setDouble(49, v); }
  bool hasSUal() => $_has(49);
  void clearSUal() => clearField(50);

  double get sUcl => $_getN(50);
  set sUcl(double v) { $_setDouble(50, v); }
  bool hasSUcl() => $_has(50);
  void clearSUcl() => clearField(51);

  double get rLcl => $_getN(51);
  set rLcl(double v) { $_setDouble(51, v); }
  bool hasRLcl() => $_has(51);
  void clearRLcl() => clearField(52);

  double get rLal => $_getN(52);
  set rLal(double v) { $_setDouble(52, v); }
  bool hasRLal() => $_has(52);
  void clearRLal() => clearField(53);

  double get rCenter => $_getN(53);
  set rCenter(double v) { $_setDouble(53, v); }
  bool hasRCenter() => $_has(53);
  void clearRCenter() => clearField(54);

  double get rUal => $_getN(54);
  set rUal(double v) { $_setDouble(54, v); }
  bool hasRUal() => $_has(54);
  void clearRUal() => clearField(55);

  double get rUcl => $_getN(55);
  set rUcl(double v) { $_setDouble(55, v); }
  bool hasRUcl() => $_has(55);
  void clearRUcl() => clearField(56);

  double get ewmaMvLcl => $_getN(56);
  set ewmaMvLcl(double v) { $_setDouble(56, v); }
  bool hasEwmaMvLcl() => $_has(56);
  void clearEwmaMvLcl() => clearField(57);

  double get ewmaMvCenter => $_getN(57);
  set ewmaMvCenter(double v) { $_setDouble(57, v); }
  bool hasEwmaMvCenter() => $_has(57);
  void clearEwmaMvCenter() => clearField(58);

  double get ewmaMvUcl => $_getN(58);
  set ewmaMvUcl(double v) { $_setDouble(58, v); }
  bool hasEwmaMvUcl() => $_has(58);
  void clearEwmaMvUcl() => clearField(59);

  double get maMvLcl => $_getN(59);
  set maMvLcl(double v) { $_setDouble(59, v); }
  bool hasMaMvLcl() => $_has(59);
  void clearMaMvLcl() => clearField(60);

  double get maMvCenter => $_getN(60);
  set maMvCenter(double v) { $_setDouble(60, v); }
  bool hasMaMvCenter() => $_has(60);
  void clearMaMvCenter() => clearField(61);

  double get maMvUcl => $_getN(61);
  set maMvUcl(double v) { $_setDouble(61, v); }
  bool hasMaMvUcl() => $_has(61);
  void clearMaMvUcl() => clearField(62);

  double get ewmaSLcl => $_getN(62);
  set ewmaSLcl(double v) { $_setDouble(62, v); }
  bool hasEwmaSLcl() => $_has(62);
  void clearEwmaSLcl() => clearField(63);

  double get ewmaSCenter => $_getN(63);
  set ewmaSCenter(double v) { $_setDouble(63, v); }
  bool hasEwmaSCenter() => $_has(63);
  void clearEwmaSCenter() => clearField(64);

  double get ewmaSUcl => $_getN(64);
  set ewmaSUcl(double v) { $_setDouble(64, v); }
  bool hasEwmaSUcl() => $_has(64);
  void clearEwmaSUcl() => clearField(65);

  double get ewmaRLcl => $_getN(65);
  set ewmaRLcl(double v) { $_setDouble(65, v); }
  bool hasEwmaRLcl() => $_has(65);
  void clearEwmaRLcl() => clearField(66);

  double get ewmaRCenter => $_getN(66);
  set ewmaRCenter(double v) { $_setDouble(66, v); }
  bool hasEwmaRCenter() => $_has(66);
  void clearEwmaRCenter() => clearField(67);

  double get ewmaRUcl => $_getN(67);
  set ewmaRUcl(double v) { $_setDouble(67, v); }
  bool hasEwmaRUcl() => $_has(67);
  void clearEwmaRUcl() => clearField(68);

  double get msMvLcl => $_getN(68);
  set msMvLcl(double v) { $_setDouble(68, v); }
  bool hasMsMvLcl() => $_has(68);
  void clearMsMvLcl() => clearField(69);

  double get msMvCenter => $_getN(69);
  set msMvCenter(double v) { $_setDouble(69, v); }
  bool hasMsMvCenter() => $_has(69);
  void clearMsMvCenter() => clearField(70);

  double get msMvUcl => $_getN(70);
  set msMvUcl(double v) { $_setDouble(70, v); }
  bool hasMsMvUcl() => $_has(70);
  void clearMsMvUcl() => clearField(71);

  List<RawValue> get raws => $_getList(71);

  List<SampleTag> get sampleTags => $_getList(72);

  List<Attr> get attr => $_getList(73);
}

class _ReadonlySample extends Sample with ReadonlyMessageMixin {}

class CA extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CA')
    ..a<int>(1, 'caId', PbFieldType.O3)
    ..aOS(2, 'caName')
    ..aOS(3, 'caDescription')
    ..aOS(4, 'caText')
    ..aOS(5, 'caAuthor')
    ..aOS(6, 'caCostSection')
    ..aOS(7, 'caDepartment')
    ..a<int>(8, 'caCreated', PbFieldType.O3)
    ..a<int>(9, 'caUpdated', PbFieldType.O3)
    ..aOS(10, 'caUpdatedBy')
    ..pPS(11, 'caAttribute')
    ..hasRequiredFields = false
  ;

  CA() : super();
  CA.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CA.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CA clone() => new CA()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CA create() => new CA();
  static PbList<CA> createRepeated() => new PbList<CA>();
  static CA getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCA();
    return _defaultInstance;
  }
  static CA _defaultInstance;
  static void $checkItem(CA v) {
    if (v is! CA) checkItemFailed(v, 'CA');
  }

  int get caId => $_get(0, 0);
  set caId(int v) { $_setSignedInt32(0, v); }
  bool hasCaId() => $_has(0);
  void clearCaId() => clearField(1);

  String get caName => $_getS(1, '');
  set caName(String v) { $_setString(1, v); }
  bool hasCaName() => $_has(1);
  void clearCaName() => clearField(2);

  String get caDescription => $_getS(2, '');
  set caDescription(String v) { $_setString(2, v); }
  bool hasCaDescription() => $_has(2);
  void clearCaDescription() => clearField(3);

  String get caText => $_getS(3, '');
  set caText(String v) { $_setString(3, v); }
  bool hasCaText() => $_has(3);
  void clearCaText() => clearField(4);

  String get caAuthor => $_getS(4, '');
  set caAuthor(String v) { $_setString(4, v); }
  bool hasCaAuthor() => $_has(4);
  void clearCaAuthor() => clearField(5);

  String get caCostSection => $_getS(5, '');
  set caCostSection(String v) { $_setString(5, v); }
  bool hasCaCostSection() => $_has(5);
  void clearCaCostSection() => clearField(6);

  String get caDepartment => $_getS(6, '');
  set caDepartment(String v) { $_setString(6, v); }
  bool hasCaDepartment() => $_has(6);
  void clearCaDepartment() => clearField(7);

  int get caCreated => $_get(7, 0);
  set caCreated(int v) { $_setSignedInt32(7, v); }
  bool hasCaCreated() => $_has(7);
  void clearCaCreated() => clearField(8);

  int get caUpdated => $_get(8, 0);
  set caUpdated(int v) { $_setSignedInt32(8, v); }
  bool hasCaUpdated() => $_has(8);
  void clearCaUpdated() => clearField(9);

  String get caUpdatedBy => $_getS(9, '');
  set caUpdatedBy(String v) { $_setString(9, v); }
  bool hasCaUpdatedBy() => $_has(9);
  void clearCaUpdatedBy() => clearField(10);

  List<String> get caAttribute => $_getList(10);
}

class _ReadonlyCA extends CA with ReadonlyMessageMixin {}

class TSG extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TSG')
    ..a<int>(1, 'tsgId', PbFieldType.O3)
    ..aOS(2, 'tsgName')
    ..aOS(3, 'tsgDescription')
    ..aOS(5, 'tsgAuthor')
    ..aOS(6, 'tsgCostSection')
    ..aOS(7, 'tsgDepartment')
    ..a<int>(8, 'tsgCreated', PbFieldType.O3)
    ..a<int>(9, 'tsgUpdated', PbFieldType.O3)
    ..aOS(10, 'tsgUpdatedBy')
    ..aOS(11, 'flowchartFilename')
    ..aOS(12, 'flowchartAppl')
    ..hasRequiredFields = false
  ;

  TSG() : super();
  TSG.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TSG.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TSG clone() => new TSG()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TSG create() => new TSG();
  static PbList<TSG> createRepeated() => new PbList<TSG>();
  static TSG getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTSG();
    return _defaultInstance;
  }
  static TSG _defaultInstance;
  static void $checkItem(TSG v) {
    if (v is! TSG) checkItemFailed(v, 'TSG');
  }

  int get tsgId => $_get(0, 0);
  set tsgId(int v) { $_setSignedInt32(0, v); }
  bool hasTsgId() => $_has(0);
  void clearTsgId() => clearField(1);

  String get tsgName => $_getS(1, '');
  set tsgName(String v) { $_setString(1, v); }
  bool hasTsgName() => $_has(1);
  void clearTsgName() => clearField(2);

  String get tsgDescription => $_getS(2, '');
  set tsgDescription(String v) { $_setString(2, v); }
  bool hasTsgDescription() => $_has(2);
  void clearTsgDescription() => clearField(3);

  String get tsgAuthor => $_getS(3, '');
  set tsgAuthor(String v) { $_setString(3, v); }
  bool hasTsgAuthor() => $_has(3);
  void clearTsgAuthor() => clearField(5);

  String get tsgCostSection => $_getS(4, '');
  set tsgCostSection(String v) { $_setString(4, v); }
  bool hasTsgCostSection() => $_has(4);
  void clearTsgCostSection() => clearField(6);

  String get tsgDepartment => $_getS(5, '');
  set tsgDepartment(String v) { $_setString(5, v); }
  bool hasTsgDepartment() => $_has(5);
  void clearTsgDepartment() => clearField(7);

  int get tsgCreated => $_get(6, 0);
  set tsgCreated(int v) { $_setSignedInt32(6, v); }
  bool hasTsgCreated() => $_has(6);
  void clearTsgCreated() => clearField(8);

  int get tsgUpdated => $_get(7, 0);
  set tsgUpdated(int v) { $_setSignedInt32(7, v); }
  bool hasTsgUpdated() => $_has(7);
  void clearTsgUpdated() => clearField(9);

  String get tsgUpdatedBy => $_getS(8, '');
  set tsgUpdatedBy(String v) { $_setString(8, v); }
  bool hasTsgUpdatedBy() => $_has(8);
  void clearTsgUpdatedBy() => clearField(10);

  String get flowchartFilename => $_getS(9, '');
  set flowchartFilename(String v) { $_setString(9, v); }
  bool hasFlowchartFilename() => $_has(9);
  void clearFlowchartFilename() => clearField(11);

  String get flowchartAppl => $_getS(10, '');
  set flowchartAppl(String v) { $_setString(10, v); }
  bool hasFlowchartAppl() => $_has(10);
  void clearFlowchartAppl() => clearField(12);
}

class _ReadonlyTSG extends TSG with ReadonlyMessageMixin {}

class Alarm extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Alarm')
    ..a<int>(1, 'alarmId', PbFieldType.O3)
    ..aOS(2, 'alarmName')
    ..aOS(3, 'alarmDescription')
    ..aOS(4, 'alarmText')
    ..aOS(5, 'alarmAuthor')
    ..aOS(6, 'alarmCostSection')
    ..aOS(7, 'alarmDepartment')
    ..a<int>(8, 'alarmCreated', PbFieldType.O3)
    ..a<int>(9, 'alarmUpdated', PbFieldType.O3)
    ..aOS(10, 'alarmUpdatedBy')
    ..hasRequiredFields = false
  ;

  Alarm() : super();
  Alarm.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Alarm.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Alarm clone() => new Alarm()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Alarm create() => new Alarm();
  static PbList<Alarm> createRepeated() => new PbList<Alarm>();
  static Alarm getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAlarm();
    return _defaultInstance;
  }
  static Alarm _defaultInstance;
  static void $checkItem(Alarm v) {
    if (v is! Alarm) checkItemFailed(v, 'Alarm');
  }

  int get alarmId => $_get(0, 0);
  set alarmId(int v) { $_setSignedInt32(0, v); }
  bool hasAlarmId() => $_has(0);
  void clearAlarmId() => clearField(1);

  String get alarmName => $_getS(1, '');
  set alarmName(String v) { $_setString(1, v); }
  bool hasAlarmName() => $_has(1);
  void clearAlarmName() => clearField(2);

  String get alarmDescription => $_getS(2, '');
  set alarmDescription(String v) { $_setString(2, v); }
  bool hasAlarmDescription() => $_has(2);
  void clearAlarmDescription() => clearField(3);

  String get alarmText => $_getS(3, '');
  set alarmText(String v) { $_setString(3, v); }
  bool hasAlarmText() => $_has(3);
  void clearAlarmText() => clearField(4);

  String get alarmAuthor => $_getS(4, '');
  set alarmAuthor(String v) { $_setString(4, v); }
  bool hasAlarmAuthor() => $_has(4);
  void clearAlarmAuthor() => clearField(5);

  String get alarmCostSection => $_getS(5, '');
  set alarmCostSection(String v) { $_setString(5, v); }
  bool hasAlarmCostSection() => $_has(5);
  void clearAlarmCostSection() => clearField(6);

  String get alarmDepartment => $_getS(6, '');
  set alarmDepartment(String v) { $_setString(6, v); }
  bool hasAlarmDepartment() => $_has(6);
  void clearAlarmDepartment() => clearField(7);

  int get alarmCreated => $_get(7, 0);
  set alarmCreated(int v) { $_setSignedInt32(7, v); }
  bool hasAlarmCreated() => $_has(7);
  void clearAlarmCreated() => clearField(8);

  int get alarmUpdated => $_get(8, 0);
  set alarmUpdated(int v) { $_setSignedInt32(8, v); }
  bool hasAlarmUpdated() => $_has(8);
  void clearAlarmUpdated() => clearField(9);

  String get alarmUpdatedBy => $_getS(9, '');
  set alarmUpdatedBy(String v) { $_setString(9, v); }
  bool hasAlarmUpdatedBy() => $_has(9);
  void clearAlarmUpdatedBy() => clearField(10);
}

class _ReadonlyAlarm extends Alarm with ReadonlyMessageMixin {}

class SampleTag extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SampleTag')
    ..a<int>(1, 'tagId', PbFieldType.O3)
    ..a<int>(2, 'tagUpdated', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SampleTag() : super();
  SampleTag.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SampleTag.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SampleTag clone() => new SampleTag()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SampleTag create() => new SampleTag();
  static PbList<SampleTag> createRepeated() => new PbList<SampleTag>();
  static SampleTag getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySampleTag();
    return _defaultInstance;
  }
  static SampleTag _defaultInstance;
  static void $checkItem(SampleTag v) {
    if (v is! SampleTag) checkItemFailed(v, 'SampleTag');
  }

  int get tagId => $_get(0, 0);
  set tagId(int v) { $_setSignedInt32(0, v); }
  bool hasTagId() => $_has(0);
  void clearTagId() => clearField(1);

  int get tagUpdated => $_get(1, 0);
  set tagUpdated(int v) { $_setSignedInt32(1, v); }
  bool hasTagUpdated() => $_has(1);
  void clearTagUpdated() => clearField(2);
}

class _ReadonlySampleTag extends SampleTag with ReadonlyMessageMixin {}

class Attr extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Attr')
    ..aOS(1, 'attrType')
    ..aOS(2, 'attrLocation')
    ..aOS(3, 'attrCause')
    ..a<int>(4, 'attrCount', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Attr() : super();
  Attr.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Attr.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Attr clone() => new Attr()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Attr create() => new Attr();
  static PbList<Attr> createRepeated() => new PbList<Attr>();
  static Attr getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAttr();
    return _defaultInstance;
  }
  static Attr _defaultInstance;
  static void $checkItem(Attr v) {
    if (v is! Attr) checkItemFailed(v, 'Attr');
  }

  String get attrType => $_getS(0, '');
  set attrType(String v) { $_setString(0, v); }
  bool hasAttrType() => $_has(0);
  void clearAttrType() => clearField(1);

  String get attrLocation => $_getS(1, '');
  set attrLocation(String v) { $_setString(1, v); }
  bool hasAttrLocation() => $_has(1);
  void clearAttrLocation() => clearField(2);

  String get attrCause => $_getS(2, '');
  set attrCause(String v) { $_setString(2, v); }
  bool hasAttrCause() => $_has(2);
  void clearAttrCause() => clearField(3);

  int get attrCount => $_get(3, 0);
  set attrCount(int v) { $_setSignedInt32(3, v); }
  bool hasAttrCount() => $_has(3);
  void clearAttrCount() => clearField(4);
}

class _ReadonlyAttr extends Attr with ReadonlyMessageMixin {}

