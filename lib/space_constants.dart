  //  constants for limit_enable string positions
const int LIMIT_MV_LCL = 0;
const int LIMIT_MV_UCL = 1;
const int LIMIT_S_LCL = 2;
const int LIMIT_SIGMA_LCL = LIMIT_S_LCL;
const int LIMIT_R_UCL = 3;
const int LIMIT_RANGE_UCL = LIMIT_R_UCL;
const int LIMIT_S_UCL = 4;
const int LIMIT_SIGMA_UCL = LIMIT_S_UCL;
const int LIMIT_FIXED_LIMITS = 5;
const int LIMIT_MV_CENTER = 6;
const int LIMIT_S_CENTER = 7;
const int LIMIT_SIGMA_CENTER = LIMIT_S_CENTER;
const int LIMIT_R_CENTER = 8;
const int LIMIT_RANGE_CENTER = LIMIT_R_CENTER;

const int LIMIT_ALL = 9;

const int LIMIT_EWMA_MV_UCL = 10;
const int LIMIT_EWMA_MV_CENTER = 11;
const int LIMIT_EWMA_MV_LCL = 12;

const int LIMIT_MA_MV_UCL = 13;
const int LIMIT_MA_MV_CENTER = 14;
const int LIMIT_MA_MV_LCL = 15;

const int LIMIT_MS_MV_UCL = 16;
const int LIMIT_MS_MV_CENTER = 17;
const int LIMIT_MS_MV_LCL = 18;

const int LIMIT_RAW_LCL = 19;
const int LIMIT_RAW_CENTER = 20;
const int LIMIT_RAW_UCL = 21;

const int LIMIT_EWMA_S_LCL = 22;
const int LIMIT_EWMA_S_CENTER = 23;
const int LIMIT_EWMA_S_UCL = 24;

const int LIMIT_EWMA_R_LCL = 25;
const int LIMIT_EWMA_R_CENTER = 26;
const int LIMIT_EWMA_R_UCL = 27;

const int LIMIT_R_LCL = 28;
const int LIMIT_RANGE_LCL = LIMIT_R_LCL;

const int LIMIT_MV_LAL = 29;
const int LIMIT_MV_UAL = 30;

const int LIMIT_RAW_LAL = 31;
const int LIMIT_RAW_UAL = 32;

const int LIMIT_SIGMA_LAL = 33;
const int LIMIT_SIGMA_UAL = 34;

const int LIMIT_RANGE_LAL = 35;
const int LIMIT_RANGE_UAL = 36;

/** length of the limit_enable string */
const int LIMIT_SIZE = 37;

const int CHART_TYPE_MV = 2;
const int CHART_TYPE_SIGMA = 3;
const int CHART_TYPE_RANGE = 4;
const int CHART_TYPE_RAW = 5;
const int CHART_TYPE_EWMA_MEAN = 6;
const int CHART_TYPE_MA = 7;
const int CHART_TYPE_MS = 8;
const int CHART_TYPE_EWMA_S = 9;
const int CHART_TYPE_EWMA_R = 10;
const int CHART_TYPE_COMMON = -1;

const int DISPLAY_RULE_NEVER = 0;
const int DISPLAY_RULE_ALWAYS = 1;
const int DISPLAY_RULE_VIOL_ONLY = 2;
const int DISPLAY_RULE_ON_DEMAND = 3;