import 'protobuf/monitor.pb.dart';

import 'space_constants.dart';


bool isClCenterLine(int limIdx) {
  switch (limIdx) {
    case LIMIT_MV_CENTER: return true;
    case LIMIT_S_CENTER: return true;
    case LIMIT_R_CENTER: return true;
    case LIMIT_RAW_CENTER: return true;
    case LIMIT_MA_MV_CENTER: return true;
    case LIMIT_EWMA_MV_CENTER: return true;
    case LIMIT_EWMA_S_CENTER: return true;
    case LIMIT_EWMA_R_CENTER: return true;
    case LIMIT_MS_MV_CENTER: return true;
  }
  return false;
}

double getSpecValue(Sample s, specLimIdx) {
  var specValue;
  if (specLimIdx == 0) {
    specValue = s.specLimitEnable[0] == 'Y' ? s.specUpper : null;
  }
  if (specLimIdx == 2) {
    specValue = s.specLimitEnable[1] == 'Y' ? s.specLower : null;
  }
  if (specLimIdx == 1) {
    specValue = s.specTargetOrigin == "V" ? s.specTarget : null;
  }
  return specValue;
}

double getLimitValue(int limIdx, Sample s) {
  double lim;
  switch (limIdx) {
    case LIMIT_MV_LCL: lim = s.mvLcl; break;
    case LIMIT_MV_LAL: lim = s.mvLal; break;
    case LIMIT_MV_CENTER: lim = s.mvCenter; break;
    case LIMIT_MV_UAL: lim = s.mvUal; break;
    case LIMIT_MV_UCL: lim = s.mvUcl; break;

    case LIMIT_SIGMA_LCL: lim = s.sLcl; break;
    case LIMIT_SIGMA_LAL: lim = s.sLal; break;
    case LIMIT_SIGMA_CENTER: lim = s.sCenter; break;
    case LIMIT_SIGMA_UAL: lim = s.sUal; break;
    case LIMIT_SIGMA_UCL: lim = s.sUcl; break;

    case LIMIT_RANGE_LCL: lim = s.rLcl; break;
    case LIMIT_RANGE_LAL: lim = s.rLal; break;
    case LIMIT_RANGE_CENTER: lim = s.rCenter; break;
    case LIMIT_RANGE_UAL: lim = s.rUal; break;
    case LIMIT_RANGE_UCL: lim = s.rUcl; break;

    case LIMIT_RAW_LCL: lim = s.rawLcl; break;
    case LIMIT_RAW_LAL: lim = s.rawLal; break;
    case LIMIT_RAW_CENTER: lim = s.rawCenter; break;
    case LIMIT_RAW_UAL: lim = s.rawUal; break;
    case LIMIT_RAW_UCL: lim = s.rawUcl; break;

    case LIMIT_MA_MV_LCL: lim = s.maMvLcl; break;
    case LIMIT_MA_MV_CENTER: lim = s.maMvCenter; break;
    case LIMIT_MA_MV_UCL: lim = s.maMvUcl; break;

    case LIMIT_EWMA_MV_LCL: lim = s.ewmaMvLcl; break;
    case LIMIT_EWMA_MV_CENTER: lim = s.ewmaMvCenter; break;
    case LIMIT_EWMA_MV_UCL: lim = s.ewmaMvUcl; break;

    case LIMIT_EWMA_S_LCL: lim = s.ewmaSLcl; break;
    case LIMIT_EWMA_S_CENTER: lim = s.ewmaSCenter; break;
    case LIMIT_EWMA_S_UCL: lim = s.ewmaSUcl; break;

    case LIMIT_EWMA_R_LCL: lim = s.ewmaRLcl; break;
    case LIMIT_EWMA_R_CENTER: lim = s.ewmaRCenter; break;
    case LIMIT_EWMA_R_UCL: lim = s.ewmaRUcl; break;

    case LIMIT_MS_MV_LCL: lim = s.msMvLcl; break;
    case LIMIT_MS_MV_CENTER: lim = s.msMvCenter; break;
    case LIMIT_MS_MV_UCL: lim = s.msMvUcl; break;

    default: return null;
  }
  bool masterFlag = true;
  bool enableFlag = true;
  String limEn = s.limitEnable;
  if (LIMIT_ALL < limEn.length) {
    masterFlag = limEn[LIMIT_ALL] == 'Y';
  }
  if (limIdx < limEn.length) {
    enableFlag = masterFlag && limEn[limIdx] == 'Y';
  }
  if (!enableFlag) {
    return null;
  }
  return lim;
}

enum PlotType {
  mv,
  sigma,
  range,
  raw,
  ewmaMv,
  ewmaS,
  ewmaR,
  ma,
  ms,
}

PlotType plotTypeFromId(int typ) {
  switch (typ) {
    case CHART_TYPE_MV: return PlotType.mv;
    case CHART_TYPE_SIGMA: return PlotType.sigma;
    case CHART_TYPE_RANGE: return PlotType.range;
    case CHART_TYPE_RAW: return PlotType.raw;
    case CHART_TYPE_EWMA_MEAN: return PlotType.ewmaMv;
    case CHART_TYPE_EWMA_S: return PlotType.ewmaS;
    case CHART_TYPE_EWMA_R: return PlotType.ewmaR;
    case CHART_TYPE_MA: return PlotType.ma;
    case CHART_TYPE_MS: return PlotType.ms;
  }
  return null;
}

class SpaceChartState {
  bool showCl;
  bool showAl;
  bool showSpec;
  bool showZones;
  bool showExtSpec;
  bool scaleByCl;
  bool scaleByAl;
  bool scaleBySpec;
  bool scaleByValues;

  SpaceChartState({
    this.showCl = true,
    this.showAl = false,
    this.showSpec = true,
    this.showZones = false,
    this.showExtSpec = false,
    this.scaleByCl = true,
    this.scaleByAl = false,
    this.scaleBySpec = false,
    this.scaleByValues = true});
}

