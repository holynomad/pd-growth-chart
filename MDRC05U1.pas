{===============================================================================
   Program ID    : MDRC05U1
   Program Name  : 소아 성장발육곡선 Charting 및 측정이력 관리
   Program Desc. : 소아청소년 성장단계별(신생아, 0~36개월, 2세 ~ 18세)
                   표준도표 Charting 및 환자의 V/S 자동 Graph + 측정이력 관리

   Author        : Lee, Se-Ha
   Date          : 2013.11.19
===============================================================================}
unit MDRC05U1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, TFlatPanelUnit, TFlatTabControlUnit, StdCtrls,
  TFlatCheckBoxUnit, TFlatButtonUnit, TFlatComboBoxUnit, Grids, BaseGrid,
  AdvGrid, TFlatSpeedButtonUnit, AdvPanel, Buttons, Variants, VclTee.TeEngine,
  VclTee.Series, VclTee.TeeProcs, VclTee.Chart, AdvObj, VclTee.TeeGDIPlus;


const
   // 표준정규누적분포 상수 : 1/sqrt(2*pi)
   INVSQRT2PI = 0.3989422804014327;

   // Vert - Horiz Axis 초기화 기본값
   C_VERTAXIS_MAX_INIT   = 200;
   C_VERTAXIS_MIN_INIT   = 0;
   C_HORIZAXIS_MAX_INIT  = 100;
   C_HORIZAXIS_MIN_INIT  = 0;


   // 측정내역 Grid Column 정의
   C_CHECK     = 0;
   C_RGTDATE   = 1;
   C_MEDDEPT   = 2;
   C_YEAR      = 3;
   C_MONTH     = 4;
   C_TOTMONTH  = 5;
   C_WEIGHT    = 6;
   C_HEIGHT    = 7;
   C_HEADCIR   = 8;
   C_BMI       = 9;
   C_REMARK    = 10;
   C_RGTTIME   = 11;
   C_MEDDATE   = 12;
   C_MEDTIME   = 13;

   C_SERIES_CNT      = 25; // 표준지표 Series (2007) 총 Count
   C_SERIES_2017_CNT = 37; // 2017 표준 D/B Series 총 Count 추가 @ 2018.05.30 LSH

   // 환아 측정이력 Line Series index
   C_SERIES_IDX_PATHGT     = 23;
   C_SERIES_IDX_PATWGT     = 24;
   C_SERIES_IDX_PATHEADCIR = 25;
   C_SERIES_IDX_PATBMI     = 26;


   // flat Tab-Contrl Active Tab 인덱스
   AT_NEONATAL         = 0;
   AT_ZERO2THIRTYSIX   = 1;
   AT_TWO2EIGHTTEEN    = 2;
   AT_HEADCIR          = 3;
   AT_BMI              = 4;

   // 2007 vs. 2017 두위 표준 D/B 월령범위 변경에 따른 Const. @ 2018.05.29 LSH
   C_2007_HEADCIR_MAXRANGE = 81;
   C_2017_HEADCIR_MAXRANGE = 72;

   // 차트캡쳐 및 메인 Panel 조정하면서 생긴 axis 흔들림 보정용 offset @ 2020.01.22 LSH
   C_NEONATAL_TOP_OFFSET       = -25;
   C_ZERO2THIRTYSIX_TOP_OFFSET = -8;   // -10
   C_TWO2EIGHTTEEN_TOP_OFFSET  = -17;  // -15
type
  TMDRC05F1 = class(TForm)
    stb_Message: TStatusBar;
    fpn_Framework: TFlatPanel;
    fpn_Chart: TFlatPanel;
    ftc_Chart: TFlatTabControl;
    chr_PdGrow: TChart;
    lb_Age: TLabel;
    lb_AxisLocate: TLabel;
    Label1: TLabel;
    lb_RightHead: TLabel;
    lb_RightBmi: TLabel;
    lb_Hgt3rd: TLabel;
    lb_Wgt3rd: TLabel;
    lb_Hgt5th: TLabel;
    lb_Hgt10th: TLabel;
    lb_Hgt25th: TLabel;
    lb_Hgt50th: TLabel;
    lb_Hgt75th: TLabel;
    lb_Hgt90th: TLabel;
    lb_Hgt95th: TLabel;
    lb_Hgt97th: TLabel;
    lb_Wgt5th: TLabel;
    lb_Wgt10th: TLabel;
    lb_Wgt25th: TLabel;
    lb_Wgt50th: TLabel;
    lb_Wgt75th: TLabel;
    lb_Wgt90th: TLabel;
    lb_Wgt95th: TLabel;
    lb_Wgt97th: TLabel;
    lb_Neo3Rd: TLabel;
    lb_Neo10th: TLabel;
    lb_Neo50th: TLabel;
    lb_Neo90th: TLabel;
    lb_Neo97th: TLabel;
    lb_BornWks: TLabel;
    lb_Hgt85th: TLabel;
    fcb_AxisLocate: TFlatCheckBox;
    fcb_ConvertWks: TFlatCheckBox;
    Series18: TAreaSeries;
    Series17: TAreaSeries;
    Series16: TAreaSeries;
    Series15: TAreaSeries;
    Series14: TAreaSeries;
    Series13: TAreaSeries;
    Series12: TAreaSeries;
    Series11: TAreaSeries;
    Series10: TAreaSeries;
    Series9: TAreaSeries;
    Series7: TAreaSeries;
    Series6: TAreaSeries;
    Series8: TAreaSeries;
    Series5: TAreaSeries;
    Series4: TAreaSeries;
    Series3: TAreaSeries;
    Series2: TAreaSeries;
    Series1: TAreaSeries;
    Series27: TAreaSeries;
    Series26: TAreaSeries;
    Series25: TAreaSeries;
    Series24: TAreaSeries;
    Series23: TAreaSeries;
    Series19: TLineSeries;
    Series20: TLineSeries;
    Series21: TLineSeries;
    Series22: TLineSeries;
    fpn_PatInfo: TFlatPanel;
    Shape3: TShape;
    Shape2: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Shape1: TShape;
    Label7: TLabel;
    Shape4: TShape;
    Label8: TLabel;
    fsbt_Add: TFlatSpeedButton;
    sbt_Refresh: TSpeedButton;
    sbt_ZoomIn: TSpeedButton;
    fed_PatNo: TEdit;
    fed_PatName: TEdit;
    fed_SexAge: TEdit;
    fcb_MedDept: TFlatComboBox;
    fbt_Search: TFlatButton;
    fbt_Delete: TFlatButton;
    fbt_Close: TFlatButton;
    cbx_OtherDept: TCheckBox;
    cbx_AdmIncluded: TCheckBox;
    fcb_Number: TFlatCheckBox;
    fcb_Percent: TFlatCheckBox;
    asg_BodyInfo: TAdvStringGrid;
    apn_PdBodAdd: TAdvPanel;
    asg_PdBodAdd: TAdvStringGrid;
    apn_NeoBornWks: TAdvPanel;
    FlatPanel2: TFlatPanel;
    Shape6: TShape;
    Label2: TLabel;
    Shape7: TShape;
    Label3: TLabel;
    Shape8: TShape;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    fed_Wks: TEdit;
    fed_Day: TEdit;
    apn_NormsDist: TAdvPanel;
    asg_NormsDist: TAdvStringGrid;
    Advpn_Log: TAdvPanel;
    Memo1: TMemo;
    fpn_LeftHgtAxis: TFlatPanel;
    lb_LeftHgt: TLabel;
    fpn_LeftWgtAxis: TFlatPanel;
    lb_LeftWgt: TLabel;
    fpn_RightWgtAxis: TFlatPanel;
    lb_RightWgt: TLabel;
    fpn_RightHgtAxis: TFlatPanel;
    lb_RightHgt: TLabel;
    fbt_Print: TFlatButton;
    fbt_NeoChart: TFlatButton;

    procedure FormShow(Sender: TObject);


    procedure chr_PdGrowAfterDraw(Sender: TObject);
    procedure chr_PdGrowGetNextAxisLabel(Sender: TChartAxis;
      LabelIndex: Integer; var LabelValue: Double; var Stop: Boolean);
    procedure fpn_PatInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ftc_ChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chr_PdGrowMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chr_PdGrowZoom(Sender: TObject);
    procedure chr_PdGrowUndoZoom(Sender: TObject);
    procedure asg_BodyInfoGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure fbt_SearchClick(Sender: TObject);
    procedure fed_PatNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fed_PatNoChange(Sender: TObject);
    procedure fed_PatNoEnter(Sender: TObject);
    procedure ftc_ChartTabChanged(Sender: TObject);
    procedure fcb_NumberClick(Sender: TObject);
    procedure fcb_PercentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fcb_AxisLocateClick(Sender: TObject);
    procedure fsbt_AddClick(Sender: TObject);
    procedure asg_BodyInfoClick(Sender: TObject);
    procedure chr_PdGrowClick(Sender: TObject);
    procedure asg_PdBodAddGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure asg_PdBodAddGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure asg_PdBodAddKeyPress(Sender: TObject; var Key: Char);
    procedure asg_PdBodAddEditingDone(Sender: TObject);
    procedure asg_PdBodAddCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure asg_PdBodAddButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure asg_BodyInfoCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure fbt_DeleteClick(Sender: TObject);
    procedure fbt_NeoChartClick(Sender: TObject);
    procedure fbt_CloseClick(Sender: TObject);
    procedure asg_BodyInfoDblClick(Sender: TObject);
    procedure asg_BodyInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure fed_DayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fed_WksChange(Sender: TObject);
    procedure sbt_RefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sbt_ZoomInClick(Sender: TObject);
    procedure asg_NormsDistGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);

    // 컴포넌트 캡쳐 관련 모듈(from 김정수P) 추가 @ 2020.01.14 LSH
    procedure SaveComponentImg(Sender: TObject);
    procedure CaptureWinCtrlImage(AWinControl: TWinControl; AImg: TGraphic);
    procedure fbt_PrintClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
    IsAgeFlag : String;

    varPatname,
    varResno1,
    varResno2,
    varBirtdate,
    varSex,
    varTelno1,
    varTelno2,
    varTelno3,
    varEmail,
    varZipcd,
    varAddress,
    varBldtype,
    varScanyn,
    varResno3,
    varZpaddress,
    varAddress2 : String;
    varBornWks,
    varBornDay  : Integer;

    FsPatNo    : String;
    FsPatCls   : String;         // 입원시 측정이력 연동위한 구분 Flag @ 2017.01.17 LSH
    FsMedDate  : String;         // 진료(입원)일자 (yyyymmdd) @ 2017.01.17 LSH
    FsMedTime  : String;         // 외래 접수시간 (yyyymmddhh24miss) @ 2017.01.17 LSH
    FsFromForm : String;         // 입원 측정이력 자동포함 Check 위한 Flag @ 2017.01.17 LSH
    FsMedDept  : String;         // 환자 주 진료과 @ 2017.01.18 LSH
    FsStandIdx : String;         // 성장곡선 D/B 표준 인덱스 (2007/2017/..) @ 2018.05.28 LSH

    //-------------------------------------------------------------------
    // 성별-월령별 항목별 표준성장지표(D/B) Chart 표기
    //-------------------------------------------------------------------
    procedure GetStandardMarking(in_Flag,
                                 in_Gubun,
                                 in_Sex,
                                 in_Item : String);

    //-------------------------------------------------------------------
    // 성별-월령별 항목별 표준성장지표(D/B) Axis 설정
    //-------------------------------------------------------------------
    procedure SetStandardAxis(in_Flag,
                              in_Sex : String);

    //-------------------------------------------------------------------
    // 성별-월령별 Axis Hide Panel 위치 설정
    //-------------------------------------------------------------------
    procedure SetAxisPanel(in_Flag : String);

    //-------------------------------------------------------------------
    // 부서명 조회 (FlatCombo)
    //-------------------------------------------------------------------
    function GetFlatMedDept(FlatCombo : TFlatComboBox) : Integer;

    //-------------------------------------------------------------------
    // 신체측정 이력 조회
    //-------------------------------------------------------------------
    procedure SelBodyInfo;

    //-------------------------------------------------------------------
    // 특정기준별 나이(년, 개월, 총개월수) 계산 함수
    //-------------------------------------------------------------------
    function GetTransAge(in_Flag,
                         in_FromDate,
                         in_BirtDate : String) : String;

    //-------------------------------------------------------------------
    // 신체측정 종류별 Data 단위변환 함수
    //         - 신생아 성장발육곡선 입원이력 연동관련
    //           환아 연령정보(in_YearInfo) 추가 @ 2017.01.18 LSH (ASPD1610013, PD 신정희)
    //-------------------------------------------------------------------
    function GetTransData(in_Flag,
                          in_DataVal,
                          in_YearInfo : String) : String;

    //-------------------------------------------------------------------
    // BMI (체질량지수) 계산 함수
    //-------------------------------------------------------------------
    function CalcBmi(in_Height,
                     in_Weight : String) : String;

    //-------------------------------------------------------------------
    // 환아 측정이력 Series Draw
    //-------------------------------------------------------------------
    procedure DrawPatSeries;

    //-------------------------------------------------------------------
    // 신생아 재태연령 계산위한 윤년 여부(Y/N) 체크
    //-------------------------------------------------------------------
    function IsYunYear(in_Year : Integer) : Boolean;

    //-------------------------------------------------------------------
    // NeoNatal 재태연령 계산 함수
    //  - 출생일자, 기준 기록일자를 받아서 재태연령을 계산.
    //-------------------------------------------------------------------
    function CalcNeoWks(in_BornDate,
                        in_RgtDate : String) : String;

    //-------------------------------------------------------------------
    // 신생아 간호정보조사지 출생주수 조회 함수
    //-------------------------------------------------------------------
    function GetNeoBornWks(in_PatNo : String;
                           var varBornWks, varBornDay : Integer) : Boolean;

    //-------------------------------------------------------------------
    // 신생아 성장곡선 출생주수 Line Draw
    //-------------------------------------------------------------------
    procedure NeoBornAfterDraw;

    //-------------------------------------------------------------------
    // [디버깅] Chart Axis Range 초기화
    //-------------------------------------------------------------------
    procedure ResetAxisRange;

    //-------------------------------------------------------------------
    // [함수] 표준정규누적분포 (환아 신체측정 data 백분위수 표기) 계산
    //      - 2014.05.22 LSH
    //-------------------------------------------------------------------
    function NormsDist(in_ZScore : Extended ) : Extended;

    //-------------------------------------------------------------------
    // 표준정규분포 z-Score 및 백분위 계산 @ 2014.05.23 LSH
    //-------------------------------------------------------------------
    function CalcZScore2Dist(in_Gubun : String;
                             in_Year,
                             in_Month,
                             in_Item  : Extended) : String;


    //-------------------------------------------------------------------
    // 백분위수 Text Drawing @ 2014.05.26 LSH
    //-------------------------------------------------------------------
    procedure DrawNormsBanner(in_Series : TChartSeries;
                              in_Gubun  : String;
                              in_Year,
                              in_Month,
                              in_TotMon,
                              in_Item   : Extended;
                              in_Color  : TColor);

    //-------------------------------------------------------------------
    // 표준정규분포 백분위수 계산 및 Panel-on To Grid @ 2014.07.08 LSH
    //-------------------------------------------------------------------
    procedure CalcZScore2Grid;

    //-------------------------------------------------------------------
    // [구로] 처방화면에서 도표클릭시 화면 좌표 입력 - 2016.09.07 최영대
    //-------------------------------------------------------------------
    procedure FormSetting;


  public
    { Public declarations }

    //-------------------------------------------------------------------
    // Cross-Hair (좌표보기) 적용 관련 var.
    //-------------------------------------------------------------------
    OldX,OldY        :  Longint;
    CrossHairColor   :  TColor;
    CrossHairStyle   :  TPenStyle;

    // 2016.09.07 최영대
//    Form_OffSet      :  Boolean;

  published
    property prop_PatNo    : String read FsPatNo    write FsPatNo;     // 환자번호 Prop var.
    property prop_PatCls   : String read FsPatCls   write FsPatCls;    // 입원시 측정이력 연동위한 Flag @ 2017.01.17 LSH
    property prop_MedDate  : String read FsMedDate  write FsMedDate;   // 진료(입원)일자 @ 2017.01.17 LSH
    property prop_MedTime  : String read FsMedTime  write FsMedTime;   // 외래 접수시간 @ 2017.01.17 LSH
    property prop_FromForm : String read FsFromForm write FsFromForm;  // 입원 측정이력 자동포함 여부 Check 위한 Flag @ 2017.01.17 LSH
    property prop_MedDept  : String read FsMedDept  write FsMedDept;   // 환자 주 진료과 @ 2017.01.18 LSH
    property prop_StandIdx : String read FsStandIdx write FsStandIdx;  // 성장곡선 D/B 표준 인덱스 (2007/2017/..) @ 2018.05.28 LSH

  end;

var
  MDRC05F1: TMDRC05F1;

implementation

uses
   ShellAPI,
   CComFunc,
   VarCom,
   TuxCom,
   HisUtil,
   TpSvc,
   MComFunc,
   MDCLASS1,
   QuickRpt,
   Qrctrls,
   Math,
   MDRC05U1_P01;     // 출력양식(QR) 추가 @ 2020.01.14 LSH

{$R *.DFM}


//------------------------------------------------------------------------------
// [조회] 성별-월령별 항목별 표준성장지표 조회
//
// Date     : 2013.11.20
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.GetStandardMarking(in_Flag,
                                       in_Gubun,
                                       in_Sex,
                                       in_Item : String);
var
   TpGetGrow : TTpSvc;
   i, j, k   : Integer;
   sType1, sType2, sType3, sType4, sType5, sType6 : String;
begin
   // Log
   Memo1.Lines.Add('Call GetStandardMarking : ' + in_Flag + ' / ' + in_Gubun + ' / ' + in_Sex + ' / ' + in_Item);


   sType1 := in_Flag;
   sType2 := in_Gubun;
   sType3 := in_Sex;
   sType4 := in_Item;
   sType5 := '';


   //---------------------------------------------------------------------
   // Axis 백분위 Label Location 관련 Debugging 처리 @ 2013.12.24 LSH
   //---------------------------------------------------------------------
   chr_PdGrow.Repaint;


   TpGetGrow := TTpSvc.Create;
   TpGetGrow.Init(nil);


   Screen.Cursor := crHourglass;


   try
      TpGetGrow.CountField  := 'S_STRING1';
      TpGetGrow.ShowMsgFlag := False;

      if TpGetGrow.GetSvc('MD_PDBOD_L1',
                       ['S_TYPE1'    , sType1
                      , 'S_TYPE2'    , sType2
                      , 'S_TYPE3'    , sType3
                      , 'S_TYPE4'    , sType4
                      , 'S_TYPE5'    , sType5
                       ],
                       [
                        'S_STRING1'  , 'sFromAge'
                      , 'S_STRING2'  , 'sItem'
                      , 'S_STRING3'  , 'sItemName'
                      , 'S_STRING4'  , 's3rd'
                      , 'S_STRING5'  , 's5th'
                      , 'S_STRING6'  , 's10th'
                      , 'S_STRING7'  , 's25th'
                      , 'S_STRING8'  , 's50th'
                      , 'S_STRING9'  , 's75th'
                      , 'S_STRING10' , 's90th'
                      , 'S_STRING11' , 's95th'
                      , 'S_STRING12' , 's97th'
                      , 'S_STRING13' , 'sDispSeq'
                      , 'S_STRING37' , 's85th'     // BMI 85백분위수 추가 @ 2014.10.23 LSH
                      , 'S_STRING38' , 's1st'      // 2017 표준 D/B 1 백분위수 추가 @ 2018.05.29 LSH
                      , 'S_STRING39' , 's15th'     // 2017 표준 D/B 15 백분위수 추가 @ 2018.05.29 LSH
                      , 'S_STRING40' , 's99th'     // 2017 표준 D/B 99 백분위수 추가 @ 2018.05.29 LSH
                       ])
      then
      begin
         with chr_PdGrow do
         begin

            // Series 별 Clear
            // XE7 선반영. 홍창한.
            for j := 0 to C_SERIES_CNT do
            begin
{@ConvertPassSTART}
   {$IFDEF VER130}
               SeriesList.Series[j].Clear;
   {$ELSE}
               Series[j].Clear;
   {$ENDIF}
{@ConvertPassEND}
            end;


            for i := 0 to TpGetGrow.RowCount - 1 do
            begin

               if (IsAgeFlag = 'NEONATAL') then
               begin
                  //------------------------------------------------------
                  // 신생아 체중
                  //------------------------------------------------------
                  if (TpGetGrow.GetOutputDataS('sItem', i) = 'WEIGHT') then
                  begin
   // XE7 선반영. 홍창한.
   {$IFDEF VER130}
                     // 3Rd
                     SeriesList.Series[C_SERIES_CNT - 3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                               '',
                                                               clTeeColor);


                     // 10th
                     SeriesList.Series[C_SERIES_CNT - 4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                               '',
                                                               clTeeColor);


                     // 50th
                     SeriesList.Series[C_SERIES_CNT - 5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                               '',
                                                               clTeeColor);


                     // 90th
                     SeriesList.Series[C_SERIES_CNT - 6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                               '',
                                                               clTeeColor);


                     // 97th
                     SeriesList.Series[C_SERIES_CNT - 7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                               '',
                                                               clTeeColor);
   {$ELSE}
                     // 3Rd
                     Series[C_SERIES_CNT - 3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                    '',
                                                    clTeeColor);


                     // 10th
                     Series[C_SERIES_CNT - 4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                    '',
                                                    clTeeColor);


                     // 50th
                     Series[C_SERIES_CNT - 5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                    '',
                                                    clTeeColor);


                     // 90th
                     Series[C_SERIES_CNT - 6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                    '',
                                                    clTeeColor);


                     // 97th
                     Series[C_SERIES_CNT - 7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                    '',
                                                    clTeeColor);

   {$ENDIF}

                     // [체중] Vertical Axis
                     for k := C_SERIES_CNT - 7 to C_SERIES_CNT - 3 do
                     begin
   {$IFDEF VER130}
                        // [체중] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aRightAxis;
                        // [체중] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [체중] Vertical Axis
                        Series[k].VertAxis  := aRightAxis;
                        // [체중] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;



                     // [체중] 백분위 Label Location
                     if (i = (TpGetGrow.RowCount - 1)) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Weight(' + IsAgeFlag + ') Chart & Set 100분위 label --> ' + IntToStr(i) + '번째 Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Wgt3rd X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt3rd Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Wgt10th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt10th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Wgt50th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt50th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Wgt90th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt90th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Wgt97th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt97th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

   {$IFDEF VER130}
                        // 체중 3Rd
                        lb_Wgt3rd.Top  := SeriesList.Series[C_SERIES_CNT - 3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := SeriesList.Series[C_SERIES_CNT - 3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt3rd.Top  := Series[C_SERIES_CNT - 3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := Series[C_SERIES_CNT - 3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt3rd.Visible := True;

                        // 체중 5th
                        lb_Wgt5th.Visible := False;

                        // 체중 10th
   {$IFDEF VER130}
                        lb_Wgt10th.Top  := SeriesList.Series[C_SERIES_CNT - 4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) ;
                        lb_Wgt10th.Left := SeriesList.Series[C_SERIES_CNT - 4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt10th.Top  := Series[C_SERIES_CNT - 4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) ;
                        lb_Wgt10th.Left := Series[C_SERIES_CNT - 4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt10th.Visible := True;

                        // 체중 25th
                        lb_Wgt25th.Visible := False;

                        // 체중 50th
   {$IFDEF VER130}
                        lb_Wgt50th.Top  := SeriesList.Series[C_SERIES_CNT - 5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Wgt50th.Left := SeriesList.Series[C_SERIES_CNT - 5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt50th.Top  := Series[C_SERIES_CNT - 5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Wgt50th.Left := Series[C_SERIES_CNT - 5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt50th.Visible := True;

                        // 체중 75th
                        lb_Wgt75th.Visible := False;

                        // 체중 90th
   {$IFDEF VER130}
                        lb_Wgt90th.Top  := SeriesList.Series[C_SERIES_CNT - 6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Wgt90th.Left := SeriesList.Series[C_SERIES_CNT - 6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt90th.Top  := Series[C_SERIES_CNT - 6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Wgt90th.Left := Series[C_SERIES_CNT - 6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt90th.Visible := True;

                        // 체중 95th
                        lb_Wgt95th.Visible := False;

                        // 체중 97th
   {$IFDEF VER130}
                        lb_Wgt97th.Top  := SeriesList.Series[C_SERIES_CNT - 7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Wgt97th.Left := SeriesList.Series[C_SERIES_CNT - 7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt97th.Top  := Series[C_SERIES_CNT - 7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Wgt97th.Left := Series[C_SERIES_CNT - 7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt97th.Visible := True;
                     end;

                  end
                  //------------------------------------------------------
                  // 신생아 두위
                  //------------------------------------------------------
                  else if (TpGetGrow.GetOutputDataS('sItem', i) = 'HEADSIZE') then
                  begin
   {$IFDEF VER130}
                     // 3Rd
                     SeriesList.Series[C_SERIES_CNT - 8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                               StrToFloat(TpGetGrow.GetOutputDataS('s3rd',    i)),
                                                               '',
                                                               clTeeColor);


                     // 10th
                     SeriesList.Series[C_SERIES_CNT - 10].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s10th',   i)),
                                                                '',
                                                                clTeeColor);


                     // 50th
                     SeriesList.Series[C_SERIES_CNT - 12].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s50th',   i)),
                                                                '',
                                                                clTeeColor);


                     // 90th
                     SeriesList.Series[C_SERIES_CNT - 14].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s90th',   i)),
                                                                '',
                                                                clTeeColor);


                     // 97th
                     SeriesList.Series[C_SERIES_CNT - 16].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                                '',
                                                                clTeeColor);
   {$ELSE}
                     // 3Rd
                     Series[C_SERIES_CNT - 8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                    StrToFloat(TpGetGrow.GetOutputDataS('s3rd',    i)),
                                                    '',
                                                    clTeeColor);


                     // 10th
                     Series[C_SERIES_CNT - 10].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s10th',   i)),
                                                     '',
                                                     clTeeColor);


                     // 50th
                     Series[C_SERIES_CNT - 12].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s50th',   i)),
                                                     '',
                                                     clTeeColor);


                     // 90th
                     Series[C_SERIES_CNT - 14].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s90th',   i)),
                                                     '',
                                                     clTeeColor);


                     // 97th
                     Series[C_SERIES_CNT - 16].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                    '',
                                                    clTeeColor);

   {$ENDIF}


                     for k := C_SERIES_CNT - 16 to C_SERIES_CNT - 8 do
                     begin
                        if (k mod 2) <> 0 then
                        begin
   {$IFDEF VER130}
                           // [두위] Vertical Axis
                           SeriesList.Series[k].VertAxis  := aLeftAxis;
                           // [두위] Horizontal Axis
                           SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                           // [두위] Vertical Axis
                           Series[k].VertAxis  := aLeftAxis;
                           // [두위] Horizontal Axis
                           Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                        end;
                     end;


                     // [두위] 백분위 Label Location
                     if (i = (TpGetGrow.RowCount * 2 / 3)  - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing HeadCir(' + IsAgeFlag + ') Chart & Set 100분위 label --> ' + IntToStr(i) + '번째 Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Neo3rd X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo3rd Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Neo10th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo10th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Neo50th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo50th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Neo90th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo90th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Neo97th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo97th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

                        // 두위 3Rd
   {$IFDEF VER130}
                        lb_Neo3rd.Top  := SeriesList.Series[C_SERIES_CNT - 8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))- 0.5);
                        lb_Neo3rd.Left := SeriesList.Series[C_SERIES_CNT - 8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo3rd.Top  := Series[C_SERIES_CNT - 8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))- 0.5);
                        lb_Neo3rd.Left := Series[C_SERIES_CNT - 8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo3rd.Visible := True;

                        // 두위 10th
   {$IFDEF VER130}
                        lb_Neo10th.Top  := SeriesList.Series[C_SERIES_CNT - 10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Neo10th.Left := SeriesList.Series[C_SERIES_CNT - 10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo10th.Top  := Series[C_SERIES_CNT - 10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Neo10th.Left := Series[C_SERIES_CNT - 10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo10th.Visible := True;

                        // 두위 50th
   {$IFDEF VER130}
                        lb_Neo50th.Top  := SeriesList.Series[C_SERIES_CNT - 12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) ;
                        lb_Neo50th.Left := SeriesList.Series[C_SERIES_CNT - 12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo50th.Top  := Series[C_SERIES_CNT - 12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) ;
                        lb_Neo50th.Left := Series[C_SERIES_CNT - 12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo50th.Visible := True;

                        // 두위 90th
   {$IFDEF VER130}
                        lb_Neo90th.Top  := SeriesList.Series[C_SERIES_CNT - 14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))- 0.5);
                        lb_Neo90th.Left := SeriesList.Series[C_SERIES_CNT - 14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo90th.Top  := Series[C_SERIES_CNT - 14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))- 0.5);
                        lb_Neo90th.Left := Series[C_SERIES_CNT - 14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo90th.Visible := True;

                        // 두위 97th
   {$IFDEF VER130}
                        lb_Neo97th.Top  := SeriesList.Series[C_SERIES_CNT - 16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Neo97th.Left := SeriesList.Series[C_SERIES_CNT - 16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo97th.Top  := Series[C_SERIES_CNT - 16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Neo97th.Left := Series[C_SERIES_CNT - 16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo97th.Visible := True;
                     end;
                  end
                  //------------------------------------------------------
                  // 신생아 신장
                  //------------------------------------------------------
                  else if (TpGetGrow.GetOutputDataS('sItem', i) = 'HEIGHT') then
                  begin
   {$IFDEF VER130}
                     // 3Rd
                     SeriesList.Series[C_SERIES_CNT - 17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                                '',
                                                                clTeeColor);


                     // 10th
                     SeriesList.Series[C_SERIES_CNT - 19].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                                '',
                                                                clTeeColor);


                     // 50th
                     SeriesList.Series[C_SERIES_CNT - 21].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                                '',
                                                                clTeeColor);


                     // 90th
                     SeriesList.Series[C_SERIES_CNT - 23].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                                '',
                                                                clTeeColor);


                     // 97th
                     SeriesList.Series[C_SERIES_CNT - 25].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                                '',
                                                                clTeeColor);
   {$ELSE}
                     // 3Rd
                     Series[C_SERIES_CNT - 17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                     '',
                                                     clTeeColor);


                     // 10th
                     Series[C_SERIES_CNT - 19].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                     '',
                                                     clTeeColor);


                     // 50th
                     Series[C_SERIES_CNT - 21].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                     '',
                                                     clTeeColor);


                     // 90th
                     Series[C_SERIES_CNT - 23].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                     '',
                                                     clTeeColor);


                     // 97th
                     Series[C_SERIES_CNT - 25].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                     StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                     '',
                                                     clTeeColor);

   {$ENDIF}
                     // [신장] Vertical Axis
                     for k := 0 to C_SERIES_CNT - 17 do
                     begin
                        if (k = 0) or
                           ((k mod 2) = 0) then
                        begin
   {$IFDEF VER130}
                           // [신장] Vertical Axis
                           SeriesList.Series[k].VertAxis  := aLeftAxis;
                           // [신장] Horizontal Axis
                           SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                           // [신장] Vertical Axis
                           Series[k].VertAxis  := aLeftAxis;
                           // [신장] Horizontal Axis
                           Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                        end
                     end;


                     // [신장] 백분위 Label Location
                     if (i = (Trunc(TpGetGrow.RowCount / 3)) - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Height(' + IsAgeFlag + ') Chart & Set 100분위 label --> ' + IntToStr(i) + '번째 Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Hgt3rd X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt3rd Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Hgt10th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt10th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Hgt50th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt50th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Hgt90th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt90th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Hgt97th X좌표 : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt97th Y좌표 : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

                        // 신장 3Rd
   {$IFDEF VER130}
                        lb_Hgt3rd.Top  := SeriesList.Series[C_SERIES_CNT - 17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)));
                        lb_Hgt3rd.Left := SeriesList.Series[C_SERIES_CNT - 17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt3rd.Top  := Series[C_SERIES_CNT - 17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)));
                        lb_Hgt3rd.Left := Series[C_SERIES_CNT - 17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt3rd.Visible := True;

                        // 신장 5th
                        lb_Hgt5th.Visible := False;

                        // 신장 10th
   {$IFDEF VER130}
                        lb_Hgt10th.Top  := SeriesList.Series[C_SERIES_CNT - 19].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Hgt10th.Left := SeriesList.Series[C_SERIES_CNT - 19].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt10th.Top  := Series[C_SERIES_CNT - 19].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Hgt10th.Left := Series[C_SERIES_CNT - 19].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt10th.Visible := True;

                        // 신장 25th
                        lb_Hgt25th.Visible := False;

                        // 신장 50th
   {$IFDEF VER130}
                        lb_Hgt50th.Top  := SeriesList.Series[C_SERIES_CNT - 21].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Hgt50th.Left := SeriesList.Series[C_SERIES_CNT - 21].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt50th.Top  := Series[C_SERIES_CNT - 21].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Hgt50th.Left := Series[C_SERIES_CNT - 21].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt50th.Visible := True;

                        // 신장 75th
                        lb_Hgt75th.Visible := False;

                        // 신장 90th
   {$IFDEF VER130}
                        lb_Hgt90th.Top  := SeriesList.Series[C_SERIES_CNT - 23].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Hgt90th.Left := SeriesList.Series[C_SERIES_CNT - 23].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt90th.Top  := Series[C_SERIES_CNT - 23].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Hgt90th.Left := Series[C_SERIES_CNT - 23].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt90th.Visible := True;

                        // 신장 95th
                        lb_Hgt95th.Visible := False;

                        // 신장 97th
   {$IFDEF VER130}
                        lb_Hgt97th.Top  := SeriesList.Series[C_SERIES_CNT - 25].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Hgt97th.Left := SeriesList.Series[C_SERIES_CNT - 25].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt97th.Top  := Series[C_SERIES_CNT - 25].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)));
                        lb_Hgt97th.Left := Series[C_SERIES_CNT - 25].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt97th.Visible := True;
                     end;
                  end;

               end
               else if (IsAgeFlag = 'ZERO2THIRTYSIX') or
                       (IsAgeFlag = 'TWO2EIGHTTEEN')  then
               begin
                  if (TpGetGrow.GetOutputDataS('sItem', i) = 'HEIGHT') then
                  begin
   {$IFDEF VER130}
                     // 3Rd
                     SeriesList.Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                '',
                                                clTeeColor);

                     // 5th
                     SeriesList.Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                                '',
                                                clTeeColor);

                     // 10th
                     SeriesList.Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                '',
                                                clTeeColor);


                     // 25th
                     SeriesList.Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                                '',
                                                clTeeColor);

                     // 50th
                     SeriesList.Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                '',
                                                clTeeColor);

                     // 75th
                     SeriesList.Series[3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                                '',
                                                clTeeColor);

                     // 90th
                     SeriesList.Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                '',
                                                clTeeColor);

                     // 95th
                     SeriesList.Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                                '',
                                                clTeeColor);

                     // 97th
                     SeriesList.Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                '',
                                                clTeeColor);
   {$ELSE}
                     // 3rd
                     Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                                '',
                                                clTeeColor);

                     // 5th
                     Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                                '',
                                                clTeeColor);

                     // 10th
                     Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                                '',
                                                clTeeColor);


                     // 25th
                     Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                                '',
                                                clTeeColor);

                     // 50th
                     Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                                '',
                                                clTeeColor);

                     // 75th
                     Series[3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                                '',
                                                clTeeColor);

                     // 90th
                     Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                                '',
                                                clTeeColor);

                     // 95th
                     Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                                '',
                                                clTeeColor);

                     // 97th
                     Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                '',
                                                clTeeColor);

   {$ENDIF}

                     // [신장] Vertical Axis
                     for k := 0 to C_SERIES_CNT - 17 do
                     begin
   {$IFDEF VER130}
                        // [신장] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aLeftAxis;
                        // [신장] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [신장] Vertical Axis
                        Series[k].VertAxis  := aLeftAxis;
                        // [신장] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;


                     // [신장] 백분위 Label Location
                     if (i = Trunc((TpGetGrow.RowCount / 2)) - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Height(' + IsAgeFlag + ') Chart & Set 100분위 label');

   {$IFDEF VER130}
                        Memo1.Lines.Add('lb_Hgt3rd X좌표 : ' + FloatToStr(SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15));
                        Memo1.Lines.Add('lb_Hgt3rd Y좌표 : ' + FloatToStr(SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));

                        //------------------------------------------------------
                        // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                        //       - 관련 S/R : GRPD1410002 (PD 남효경)
                        //------------------------------------------------------
                        lb_Hgt85th.Visible := False;

                        // 신장 3Rd
                        lb_Hgt3rd.Top  := SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                        lb_Hgt3rd.Left := SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt3rd.Visible := True;

                        // 신장 5th
                        lb_Hgt5th.Top  := SeriesList.Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Hgt5th.Left := SeriesList.Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt5th.Visible := True;

                        // 신장 10th
                        lb_Hgt10th.Top  := SeriesList.Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Hgt10th.Left := SeriesList.Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt10th.Visible := True;

                        // 신장 25th
                        lb_Hgt25th.Top  := SeriesList.Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Hgt25th.Left := SeriesList.Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt25th.Visible := True;

                        // 신장 50th
                        lb_Hgt50th.Top  := SeriesList.Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Hgt50th.Left := SeriesList.Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt50th.Visible := True;

                        // 신장 75th
                        lb_Hgt75th.Top  := SeriesList.Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Hgt75th.Left := SeriesList.Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt75th.Visible := True;

                        // 신장 90th
                        lb_Hgt90th.Top  := SeriesList.Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Hgt90th.Left := SeriesList.Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt90th.Visible := True;

                        // 신장 95th
                        lb_Hgt95th.Top  := SeriesList.Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Hgt95th.Left := SeriesList.Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt95th.Visible := True;

                        // 신장 97th
                        lb_Hgt97th.Top  := SeriesList.Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Hgt97th.Left := SeriesList.Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt97th.Visible := True;
   {$ELSE}
                        Memo1.Lines.Add('lb_Hgt3rd X좌표 : ' + FloatToStr(Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15));
                        Memo1.Lines.Add('lb_Hgt3rd Y좌표 : ' + FloatToStr(Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));

                        //------------------------------------------------------
                        // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                        //       - 관련 S/R : GRPD1410002 (PD 남효경)
                        //------------------------------------------------------
                        lb_Hgt85th.Visible := False;


                        // 신장 3Rd
                        lb_Hgt3rd.Top  := Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                        lb_Hgt3rd.Left := Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt3rd.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt3rd.Top < 0 then
                                 lb_Hgt3rd.Top  := 175;

                              if lb_Hgt3rd.Left < 0 then
                                 lb_Hgt3rd.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt3rd.Top < 0 then
                                 lb_Hgt3rd.Top  := 272;

                              if lb_Hgt3rd.Left < 0 then
                                 lb_Hgt3rd.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt3rd.Top < 0 then
                                 lb_Hgt3rd.Top  := 168;

                              if lb_Hgt3rd.Left < 0 then
                                 lb_Hgt3rd.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt3rd.Top < 0 then
                                 lb_Hgt3rd.Top  := 210;

                              if lb_Hgt3rd.Left < 0 then
                                 lb_Hgt3rd.Left := 586;
                           end;
                        end;

                        // 신장 5th
                        lb_Hgt5th.Top  := Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Hgt5th.Left := Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt5th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt5th.Top < 0 then
                                 lb_Hgt5th.Top  := 165;

                              if lb_Hgt5th.Left < 0 then
                                 lb_Hgt5th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt5th.Top < 0 then
                                 lb_Hgt5th.Top  := 262;

                              if lb_Hgt5th.Left < 0 then
                                 lb_Hgt5th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt5th.Top < 0 then
                                 lb_Hgt5th.Top  := 158;

                              if lb_Hgt5th.Left < 0 then
                                 lb_Hgt5th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt5th.Top < 0 then
                                 lb_Hgt5th.Top  := 199;

                              if lb_Hgt5th.Left < 0 then
                                 lb_Hgt5th.Left := 586;
                           end;
                        end;

                        // 신장 10th
                        lb_Hgt10th.Top  := Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Hgt10th.Left := Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt10th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt10th.Top < 0 then
                                 lb_Hgt10th.Top  := 157;

                              if lb_Hgt10th.Left < 0 then
                                 lb_Hgt10th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt10th.Top < 0 then
                                 lb_Hgt10th.Top  := 252;

                              if lb_Hgt10th.Left < 0 then
                                 lb_Hgt10th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt10th.Top < 0 then
                                 lb_Hgt10th.Top  := 150;

                              if lb_Hgt10th.Left < 0 then
                                 lb_Hgt10th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt10th.Top < 0 then
                                 lb_Hgt10th.Top  := 188;

                              if lb_Hgt10th.Left < 0 then
                                 lb_Hgt10th.Left := 586;
                           end;
                        end;

                        // 신장 25th
                        lb_Hgt25th.Top  := Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Hgt25th.Left := Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt25th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt25th.Top < 0 then
                                 lb_Hgt25th.Top  := 142;

                              if lb_Hgt25th.Left < 0 then
                                 lb_Hgt25th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt25th.Top < 0 then
                                 lb_Hgt25th.Top  := 236;

                              if lb_Hgt25th.Left < 0 then
                                 lb_Hgt25th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt25th.Top < 0 then
                                 lb_Hgt25th.Top  := 136;

                              if lb_Hgt25th.Left < 0 then
                                 lb_Hgt25th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt25th.Top < 0 then
                                 lb_Hgt25th.Top  := 171;

                              if lb_Hgt25th.Left < 0 then
                                 lb_Hgt25th.Left := 586;
                           end;
                        end;

                        // 신장 50th
                        lb_Hgt50th.Top  := Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Hgt50th.Left := Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt50th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt50th.Top < 0 then
                                 lb_Hgt50th.Top  := 126;

                              if lb_Hgt50th.Left < 0 then
                                 lb_Hgt50th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt50th.Top < 0 then
                                 lb_Hgt50th.Top  := 218;

                              if lb_Hgt50th.Left < 0 then
                                 lb_Hgt50th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt50th.Top < 0 then
                                 lb_Hgt50th.Top  := 119;

                              if lb_Hgt50th.Left < 0 then
                                 lb_Hgt50th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt50th.Top < 0 then
                                 lb_Hgt50th.Top  := 150;

                              if lb_Hgt50th.Left < 0 then
                                 lb_Hgt50th.Left := 586;
                           end;
                        end;

                        // 신장 75th
                        lb_Hgt75th.Top  := Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Hgt75th.Left := Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt75th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt75th.Top < 0 then
                                 lb_Hgt75th.Top  := 109;

                              if lb_Hgt75th.Left < 0 then
                                 lb_Hgt75th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt75th.Top < 0 then
                                 lb_Hgt75th.Top  := 199;

                              if lb_Hgt75th.Left < 0 then
                                 lb_Hgt75th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt75th.Top < 0 then
                                 lb_Hgt75th.Top  := 101;

                              if lb_Hgt75th.Left < 0 then
                                 lb_Hgt75th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt75th.Top < 0 then
                                 lb_Hgt75th.Top  := 130;

                              if lb_Hgt75th.Left < 0 then
                                 lb_Hgt75th.Left := 586;
                           end;
                        end;

                        // 신장 90th
                        lb_Hgt90th.Top  := Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Hgt90th.Left := Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt90th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt90th.Top < 0 then
                                 lb_Hgt90th.Top  := 94;

                              if lb_Hgt90th.Left < 0 then
                                 lb_Hgt90th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt90th.Top < 0 then
                                 lb_Hgt90th.Top  := 181;

                              if lb_Hgt90th.Left < 0 then
                                 lb_Hgt90th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt90th.Top < 0 then
                                 lb_Hgt90th.Top  := 85;

                              if lb_Hgt90th.Left < 0 then
                                 lb_Hgt90th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt90th.Top < 0 then
                                 lb_Hgt90th.Top  := 111;

                              if lb_Hgt90th.Left < 0 then
                                 lb_Hgt90th.Left := 586;
                           end;
                        end;

                        // 신장 95th
                        lb_Hgt95th.Top  := Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Hgt95th.Left := Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt95th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt95th.Top < 0 then
                                 lb_Hgt95th.Top  := 85;

                              if lb_Hgt95th.Left < 0 then
                                 lb_Hgt95th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt95th.Top < 0 then
                                 lb_Hgt95th.Top  := 171;

                              if lb_Hgt95th.Left < 0 then
                                 lb_Hgt95th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt95th.Top < 0 then
                                 lb_Hgt95th.Top  := 75;

                              if lb_Hgt95th.Left < 0 then
                                 lb_Hgt95th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt95th.Top < 0 then
                                 lb_Hgt95th.Top  := 100;

                              if lb_Hgt95th.Left < 0 then
                                 lb_Hgt95th.Left := 586;
                           end;
                        end;

                        // 신장 97th
                        lb_Hgt97th.Top  := Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Hgt97th.Left := Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt97th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt97th.Top < 0 then
                                 lb_Hgt97th.Top  := 76;

                              if lb_Hgt97th.Left < 0 then
                                 lb_Hgt97th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt97th.Top < 0 then
                                 lb_Hgt97th.Top  := 161;

                              if lb_Hgt97th.Left < 0 then
                                 lb_Hgt97th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Hgt97th.Top < 0 then
                                 lb_Hgt97th.Top  := 66;

                              if lb_Hgt97th.Left < 0 then
                                 lb_Hgt97th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Hgt97th.Top < 0 then
                                 lb_Hgt97th.Top  := 89;

                              if lb_Hgt97th.Left < 0 then
                                 lb_Hgt97th.Left := 586;
                           end;
                        end;

   {$ENDIF}
                     end;
                  end
                  else if (TpGetGrow.GetOutputDataS('sItem', i) = 'WEIGHT') then
                  begin
   {$IFDEF VER130}
                     // 3Rd
                     SeriesList.Series[17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s3rd',    i)),
                                                 '',
                                                 clTeeColor);

                     // 5th
                     SeriesList.Series[16].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s5th',    i)),
                                                 '',
                                                 clTeeColor);

                     // 10th
                     SeriesList.Series[15].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s10th',   i)),
                                                 '',
                                                 clTeeColor);


                     // 25th
                     SeriesList.Series[14].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s25th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 50th
                     SeriesList.Series[13].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s50th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 75th
                     SeriesList.Series[12].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s75th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 90th
                     SeriesList.Series[11].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s90th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 95th
                     SeriesList.Series[10].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s95th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 97th
                     SeriesList.Series[9].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                '',
                                                clTeeColor);
   {$ELSE}
                     // 3Rd
                     Series[17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s3rd',    i)),
                                                 '',
                                                 clTeeColor);

                     // 5th
                     Series[16].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s5th',    i)),
                                                 '',
                                                 clTeeColor);

                     // 10th
                     Series[15].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s10th',   i)),
                                                 '',
                                                 clTeeColor);


                     // 25th
                     Series[14].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s25th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 50th
                     Series[13].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s50th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 75th
                     Series[12].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s75th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 90th
                     Series[11].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s90th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 95th
                     Series[10].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)),
                                                 StrToFloat(TpGetGrow.GetOutputDataS('s95th',   i)),
                                                 '',
                                                 clTeeColor);

                     // 97th
                     Series[9].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                                StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                                '',
                                                clTeeColor);
   {$ENDIF}


                     //------------------------------------------------------
                     // Multiple Axis 확장성 고려 주석처리 @ 2013.11.21 LSH
                     //------------------------------------------------------
                     {
                     // [체중] Custom Axis 정의 추가
                     LeftWgtAxis := TChartAxis.Create(chr_PdGrow);


                     LeftWgtAxis.Maximum         := 135;
                     LeftWgtAxis.Minimum         := 5;
                     LeftWgtAxis.Increment       := 0.1;
                     LeftWgtAxis.StartPosition   := 0;
                     LeftWgtAxis.EndPosition     := 100;

                     LeftWgtAxis.Automatic       := False;
                     LeftWgtAxis.LabelStyle      := talAuto;
                     LeftWgtAxis.MinorTicks.Visible := True;
                     LeftWgtAxis.MinorTickCount  := 4;
                     LeftWgtAxis.MinorTickLength := 2;

                     }

                     {
                     PosAxis := ChartRect.Right;

                     LeftWgtAxis.CustomDraw(PosAxis,
                                            PosAxis,
                                            PosAxis,
                                            True);

                     LeftWgtAxis.PositionPercent := -5;
                     }

                     {
                     LeftWgtAxis.PositionPercent := -5;
                     LeftWgtAxis.MinorTickCount  := 4;
                     LeftWgtAxis.MinorTickLength := 2;
                     LeftWgtAxis.MinorTicks.Visible := True;
                     LeftWgtAxis.LabelStyle      := talValue;
                     LeftWgtAxis.Automatic       := False;

                     // LeftAxis [체중] 추가
                     LeftAxis.CustomDrawMinMaxStartEnd(PosAxis,
                                                       PosAxis,
                                                       PosAxis,
                                                       True,
                                                       5,
                                                       180,
                                                       0.1,
                                                       0,
                                                       100
                                                       );

                     }



                     for k := C_SERIES_CNT - 16 to C_SERIES_CNT - 8 do
                     begin
   {$IFDEF VER130}
                        // [체중] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aRightAxis;
                        // [체중] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [체중] Vertical Axis
                        Series[k].VertAxis  := aRightAxis;
                        // [체중] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;


                     // [체중] 백분위 Label Location
                     if (i = (TpGetGrow.RowCount - 1)) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Weight(' + IsAgeFlag + ') Chart & Set 100분위 label');

   {$IFDEF VER130}
                        Memo1.Lines.Add('lb_Wgt3rd X좌표 : ' + FloatToStr(SeriesList.Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 50));
                        Memo1.Lines.Add('lb_Wgt3rd Y좌표 : ' + FloatToStr(SeriesList.Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));


                        // 체중 3Rd
                        lb_Wgt3rd.Top  := SeriesList.Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := SeriesList.Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt3rd.Visible := True;

                        // 체중 5th
                        lb_Wgt5th.Top  := SeriesList.Series[16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Wgt5th.Left := SeriesList.Series[16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt5th.Visible := True;

                        // 체중 10th
                        lb_Wgt10th.Top  := SeriesList.Series[15].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Wgt10th.Left := SeriesList.Series[15].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt10th.Visible := True;

                        // 체중 25th
                        lb_Wgt25th.Top  := SeriesList.Series[14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Wgt25th.Left := SeriesList.Series[14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt25th.Visible := True;

                        // 체중 50th
                        lb_Wgt50th.Top  := SeriesList.Series[13].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Wgt50th.Left := SeriesList.Series[13].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt50th.Visible := True;

                        // 체중 75th
                        lb_Wgt75th.Top  := SeriesList.Series[12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Wgt75th.Left := SeriesList.Series[12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt75th.Visible := True;

                        // 체중 90th
                        lb_Wgt90th.Top  := SeriesList.Series[11].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Wgt90th.Left := SeriesList.Series[11].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt90th.Visible := True;


                        // 체중 95th
                        lb_Wgt95th.Top  := SeriesList.Series[10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Wgt95th.Left := SeriesList.Series[10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt95th.Visible := True;


                        // 체중 97th
                        lb_Wgt97th.Top  := SeriesList.Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Wgt97th.Left := SeriesList.Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt97th.Visible := True;

   {$ELSE}
                        Memo1.Lines.Add('lb_Wgt3rd X좌표 : ' + FloatToStr(Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 50));
                        Memo1.Lines.Add('lb_Wgt3rd Y좌표 : ' + FloatToStr(Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));


                        // 체중 3Rd
                        lb_Wgt3rd.Top  := Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt3rd.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt3rd.Top <= 0 then
                                 lb_Wgt3rd.Top  := 479;

                              if lb_Wgt3rd.Left < 0 then
                                 lb_Wgt3rd.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt3rd.Top <= 0 then
                                 lb_Wgt3rd.Top  := 554;

                              if lb_Wgt3rd.Left < 0 then
                                 lb_Wgt3rd.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt3rd.Top <= 0 then
                                 lb_Wgt3rd.Top  := 464;

                              if lb_Wgt3rd.Left < 0 then
                                 lb_Wgt3rd.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt3rd.Top <= 0 then
                                 lb_Wgt3rd.Top  := 515;

                              if lb_Wgt3rd.Left < 0 then
                                 lb_Wgt3rd.Left := 586;
                           end;
                        end;

                        // 체중 5th
                        lb_Wgt5th.Top  := Series[16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Wgt5th.Left := Series[16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt5th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt5th.Top <= 0 then
                                 lb_Wgt5th.Top  := 466;

                              if lb_Wgt5th.Left < 0 then
                                 lb_Wgt5th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt5th.Top <= 0 then
                                 lb_Wgt5th.Top  := 544;

                              if lb_Wgt5th.Left < 0 then
                                 lb_Wgt5th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt5th.Top <= 0 then
                                 lb_Wgt5th.Top  := 451;

                              if lb_Wgt5th.Left < 0 then
                                 lb_Wgt5th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt5th.Top <= 0 then
                                 lb_Wgt5th.Top  := 503;

                              if lb_Wgt5th.Left < 0 then
                                 lb_Wgt5th.Left := 586;
                           end;
                        end;

                        // 체중 10th
                        lb_Wgt10th.Top  := Series[15].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Wgt10th.Left := Series[15].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt10th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt10th.Top <= 0 then
                                 lb_Wgt10th.Top  := 452;

                              if lb_Wgt10th.Left < 0 then
                                 lb_Wgt10th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt10th.Top <= 0 then
                                 lb_Wgt10th.Top  := 535;

                              if lb_Wgt10th.Left < 0 then
                                 lb_Wgt10th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt10th.Top <= 0 then
                                 lb_Wgt10th.Top  := 436;

                              if lb_Wgt10th.Left < 0 then
                                 lb_Wgt10th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt10th.Top <= 0 then
                                 lb_Wgt10th.Top  := 490;

                              if lb_Wgt10th.Left < 0 then
                                 lb_Wgt10th.Left := 586;
                           end;
                        end;

                        // 체중 25th
                        lb_Wgt25th.Top  := Series[14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Wgt25th.Left := Series[14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt25th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt25th.Top <= 0 then
                                 lb_Wgt25th.Top  := 427;

                              if lb_Wgt25th.Left < 0 then
                                 lb_Wgt25th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt25th.Top <= 0 then
                                 lb_Wgt25th.Top  := 518;

                              if lb_Wgt25th.Left < 0 then
                                 lb_Wgt25th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt25th.Top <= 0 then
                                 lb_Wgt25th.Top  := 410;

                              if lb_Wgt25th.Left < 0 then
                                 lb_Wgt25th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt25th.Top <= 0 then
                                 lb_Wgt25th.Top  := 466;

                              if lb_Wgt25th.Left < 0 then
                                 lb_Wgt25th.Left := 586;
                           end;
                        end;

                        // 체중 50th
                        lb_Wgt50th.Top  := Series[13].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Wgt50th.Left := Series[13].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt50th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt50th.Top <= 0 then
                                 lb_Wgt50th.Top  := 396;

                              if lb_Wgt50th.Left < 0 then
                                 lb_Wgt50th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt50th.Top <= 0 then
                                 lb_Wgt50th.Top  := 496;

                              if lb_Wgt50th.Left < 0 then
                                 lb_Wgt50th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt50th.Top <= 0 then
                                 lb_Wgt50th.Top  := 378;

                              if lb_Wgt50th.Left < 0 then
                                 lb_Wgt50th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt50th.Top <= 0 then
                                 lb_Wgt50th.Top  := 435;

                              if lb_Wgt50th.Left < 0 then
                                 lb_Wgt50th.Left := 586;
                           end;
                        end;


                        // 체중 75th
                        lb_Wgt75th.Top  := Series[12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Wgt75th.Left := Series[12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt75th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt75th.Top <= 0 then
                                 lb_Wgt75th.Top  := 361;

                              if lb_Wgt75th.Left < 0 then
                                 lb_Wgt75th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt75th.Top <= 0 then
                                 lb_Wgt75th.Top  := 469;

                              if lb_Wgt75th.Left < 0 then
                                 lb_Wgt75th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt75th.Top <= 0 then
                                 lb_Wgt75th.Top  := 343;

                              if lb_Wgt75th.Left < 0 then
                                 lb_Wgt75th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt75th.Top <= 0 then
                                 lb_Wgt75th.Top  := 398;

                              if lb_Wgt75th.Left < 0 then
                                 lb_Wgt75th.Left := 586;
                           end;
                        end;


                        // 체중 90th
                        lb_Wgt90th.Top  := Series[11].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Wgt90th.Left := Series[11].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt90th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt90th.Top <= 0 then
                                 lb_Wgt90th.Top  := 325;

                              if lb_Wgt90th.Left < 0 then
                                 lb_Wgt90th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt90th.Top <= 0 then
                                 lb_Wgt90th.Top  := 439;

                              if lb_Wgt90th.Left < 0 then
                                 lb_Wgt90th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt90th.Top <= 0 then
                                 lb_Wgt90th.Top  := 308;

                              if lb_Wgt90th.Left < 0 then
                                 lb_Wgt90th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt90th.Top <= 0 then
                                 lb_Wgt90th.Top  := 356;

                              if lb_Wgt90th.Left < 0 then
                                 lb_Wgt90th.Left := 586;
                           end;
                        end;

                        // 체중 95th
                        lb_Wgt95th.Top  := Series[10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Wgt95th.Left := Series[10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt95th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt95th.Top <= 0 then
                                 lb_Wgt95th.Top  := 302;

                              if lb_Wgt95th.Left < 0 then
                                 lb_Wgt95th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt95th.Top <= 0 then
                                 lb_Wgt95th.Top  := 418;

                              if lb_Wgt95th.Left < 0 then
                                 lb_Wgt95th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt95th.Top <= 0 then
                                 lb_Wgt95th.Top  := 285;

                              if lb_Wgt95th.Left < 0 then
                                 lb_Wgt95th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt95th.Top <= 0 then
                                 lb_Wgt95th.Top  := 327;

                              if lb_Wgt95th.Left < 0 then
                                 lb_Wgt95th.Left := 586;
                           end;
                        end;


                        // 체중 97th
                        lb_Wgt97th.Top  := Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Wgt97th.Left := Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt97th.Visible := True;

                        // FormShow시 Series의 Pos 계산 안되는 버그 개선위해 추가 @ 2016.01.27 LSH
                        if (in_Sex = 'F') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt97th.Top <= 0 then
                                 lb_Wgt97th.Top  := 282;

                              if lb_Wgt97th.Left < 0 then
                                 lb_Wgt97th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt97th.Top <= 0 then
                                 lb_Wgt97th.Top  := 400;

                              if lb_Wgt97th.Left < 0 then
                                 lb_Wgt97th.Left := 586;
                           end;
                        end
                        else if (in_Sex = 'M') then
                        begin
                           if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                           begin
                              if lb_Wgt97th.Top <= 0 then
                                 lb_Wgt97th.Top  := 267;

                              if lb_Wgt97th.Left < 0 then
                                 lb_Wgt97th.Left := 586;
                           end
                           else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                           begin
                              if lb_Wgt97th.Top <= 0 then
                                 lb_Wgt97th.Top  := 303;

                              if lb_Wgt97th.Left < 0 then
                                 lb_Wgt97th.Left := 586;
                           end;
                        end;
   {$ENDIF}
                     end;
                  end;
               end
               else if (TpGetGrow.GetOutputDataS('sItem', i) = 'HEADCIR') then
               begin
   {$IFDEF VER130}
                  // 3Rd
                  SeriesList.Series[9].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                             '',
                                             clTeeColor);

                  // 5th
                  SeriesList.Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                             '',
                                             clTeeColor);

                  // 10th
                  SeriesList.Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                             '',
                                             clTeeColor);


                  // 25th
                  SeriesList.Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                             '',
                                             clTeeColor);

                  // 50th
                  SeriesList.Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                             '',
                                             clTeeColor);

                  // 75th
                  SeriesList.Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                             '',
                                             clTeeColor);

                  // 90th
                  SeriesList.Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                             '',
                                             clTeeColor);

                  // 95th
                  SeriesList.Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                             '',
                                             clTeeColor);

                  // 97th
                  SeriesList.Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                             '',
                                             clTeeColor);
   {$ELSE}
                  // 3Rd
                  // XE7 전환시 Series Area Line Color 및 Transparency 적용된 Index로 변경 (9 -> 17) @ 2016.01.27 LSH
                  Series[17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                              StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                              '',
                                              clTeeColor);

                  // 5th
                  Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                             '',
                                             clTeeColor);

                  // 10th
                  Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                             '',
                                             clTeeColor);


                  // 25th
                  Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                             '',
                                             clTeeColor);

                  // 50th
                  Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                             '',
                                             clTeeColor);

                  // 75th
                  Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                             '',
                                             clTeeColor);

                  // 90th
                  Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                             '',
                                             clTeeColor);

                  // 95th
                  Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                             '',
                                             clTeeColor);

                  // 97th
                  Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                             '',
                                             clTeeColor);
   {$ENDIF}

                  // [두위] Vertical Axis
                  for k := 0 to C_SERIES_CNT - 17 do
                  begin
   {$IFDEF VER130}
                     // [두위] Vertical Axis
                     SeriesList.Series[k].VertAxis  := aRightAxis;
                     // [두위] Horizontal Axis
                     SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                     // [두위] Vertical Axis
                     Series[k].VertAxis  := aRightAxis;
                     // [두위] Horizontal Axis
                     Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                  end;


                  // [두위] 백분위 Label Location
                  if (i = (TpGetGrow.RowCount - 1)) then
                  begin
                     // Log
                     Memo1.Lines.Add('After Drawing ' + TpGetGrow.GetOutputDataS('sItem', i) + ' Chart & Set 100분위 label');

                     //---------------------------------------------------------
                     // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                     //       - 관련 S/R : GRPD1410002 (PD 남효경)
                     //---------------------------------------------------------
                     lb_Hgt85th.Visible := False;

   {$IFDEF VER130}
                     // 3Rd
                     lb_Hgt3rd.Top  := SeriesList.Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                     lb_Hgt3rd.Left := SeriesList.Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt3rd.Visible := True;

                     // 5th
                     lb_Hgt5th.Top  := SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                     lb_Hgt5th.Left := SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt5th.Visible := True;

                     // 10th
                     lb_Hgt10th.Top  := SeriesList.Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                     lb_Hgt10th.Left := SeriesList.Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt10th.Visible := True;

                     // 25th
                     lb_Hgt25th.Top  := SeriesList.Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                     lb_Hgt25th.Left := SeriesList.Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt25th.Visible := True;

                     // 50th
                     lb_Hgt50th.Top  := SeriesList.Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                     lb_Hgt50th.Left := SeriesList.Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt50th.Visible := True;

                     // 75th
                     lb_Hgt75th.Top  := SeriesList.Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                     lb_Hgt75th.Left := SeriesList.Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt75th.Visible := True;

                     // 90th
                     lb_Hgt90th.Top  := SeriesList.Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                     lb_Hgt90th.Left := SeriesList.Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt90th.Visible := True;

                     // 95th
                     lb_Hgt95th.Top  := SeriesList.Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                     lb_Hgt95th.Left := SeriesList.Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt95th.Visible := True;

                     // 97th
                     lb_Hgt97th.Top  := SeriesList.Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                     lb_Hgt97th.Left := SeriesList.Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt97th.Visible := True;

   {$ELSE}
                     // 3Rd
                     lb_Hgt3rd.Top  := Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                     lb_Hgt3rd.Left := Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt3rd.Visible := True;

                     // 5th
                     lb_Hgt5th.Top  := Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                     lb_Hgt5th.Left := Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt5th.Visible := True;

                     // 10th
                     lb_Hgt10th.Top  := Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                     lb_Hgt10th.Left := Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt10th.Visible := True;

                     // 25th
                     lb_Hgt25th.Top  := Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                     lb_Hgt25th.Left := Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt25th.Visible := True;

                     // 50th
                     lb_Hgt50th.Top  := Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                     lb_Hgt50th.Left := Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt50th.Visible := True;

                     // 75th
                     lb_Hgt75th.Top  := Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                     lb_Hgt75th.Left := Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt75th.Visible := True;

                     // 90th
                     lb_Hgt90th.Top  := Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                     lb_Hgt90th.Left := Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt90th.Visible := True;

                     // 95th
                     lb_Hgt95th.Top  := Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                     lb_Hgt95th.Left := Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt95th.Visible := True;

                     // 97th
                     lb_Hgt97th.Top  := Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                     lb_Hgt97th.Left := Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt97th.Visible := True;
   {$ENDIF}

                     lb_Wgt3rd.Visible  := False;
                     lb_Wgt5th.Visible  := False;
                     lb_Wgt10th.Visible := False;
                     lb_Wgt25th.Visible := False;
                     lb_Wgt50th.Visible := False;
                     lb_Wgt75th.Visible := False;
                     lb_Wgt90th.Visible := False;
                     lb_Wgt95th.Visible := False;
                     lb_Wgt97th.Visible := False;
                  end;
               end
               else if (TpGetGrow.GetOutputDataS('sItem', i) = 'BMI') then
               begin
   {$IFDEF VER130}
                  // 3Rd
                  SeriesList.Series[9].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                             '',
                                             clTeeColor);

                  // 5th
                  SeriesList.Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                             '',
                                             clTeeColor);

                  // 10th
                  SeriesList.Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                             '',
                                             clTeeColor);


                  // 25th
                  SeriesList.Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                             '',
                                             clTeeColor);

                  // 50th
                  SeriesList.Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                             '',
                                             clTeeColor);

                  // 75th
                  SeriesList.Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                             '',
                                             clTeeColor);

                  //------------------------------------------------------------
                  // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                  //       - 관련 S/R : GRPD1410002 (PD 남효경)
                  //------------------------------------------------------------
                  SeriesList.Series[3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s85th',    i)),
                                             '',
                                             clTeeColor);

                  // 90th
                  SeriesList.Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                             '',
                                             clTeeColor);

                  // 95th
                  SeriesList.Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                             '',
                                             clTeeColor);

                  // 97th
                  SeriesList.Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                             '',
                                             clTeeColor);
   {$ELSE}
                  // 3Rd
                  // XE7 전환시 Series Area Line Color 및 Transparency 적용된 Index로 변경 (9 -> 17) @ 2016.01.27 LSH
                  Series[17].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                              StrToFloat(TpGetGrow.GetOutputDataS('s3rd',     i)),
                                              '',
                                              clTeeColor);

                  // 5th
                  Series[8].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s5th',     i)),
                                             '',
                                             clTeeColor);

                  // 10th
                  Series[7].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s10th',    i)),
                                             '',
                                             clTeeColor);


                  // 25th
                  Series[6].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s25th',    i)),
                                             '',
                                             clTeeColor);

                  // 50th
                  Series[5].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s50th',    i)),
                                             '',
                                             clTeeColor);

                  // 75th
                  Series[4].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s75th',    i)),
                                             '',
                                             clTeeColor);

                  //------------------------------------------------------------
                  // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                  //       - 관련 S/R : GRPD1410002 (PD 남효경)
                  //------------------------------------------------------------
                  Series[3].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s85th',    i)),
                                             '',
                                             clTeeColor);

                  // 90th
                  Series[2].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s90th',    i)),
                                             '',
                                             clTeeColor);

                  // 95th
                  Series[1].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s95th',    i)),
                                             '',
                                             clTeeColor);

                  // 97th
                  Series[0].AddXy(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge', i)),
                                             StrToFloat(TpGetGrow.GetOutputDataS('s97th',    i)),
                                             '',
                                             clTeeColor);
   {$ENDIF}

                  // [BMI] Vertical Axis
                  for k := 0 to C_SERIES_CNT - 17 do
                  begin
   {$IFDEF VER130}
                     // [두위/BMI] Vertical Axis
                     SeriesList.Series[k].VertAxis  := aRightAxis;
                     // [두위/BMI] Horizontal Axis
                     SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                     // [두위/BMI] Vertical Axis
                     Series[k].VertAxis  := aRightAxis;
                     // [두위/BMI] Horizontal Axis
                     Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                  end;


                  // [BMI] 백분위 Label Location
                  if (i = (TpGetGrow.RowCount - 1)) then
                  begin
                     // Log
                     Memo1.Lines.Add('After Drawing ' + TpGetGrow.GetOutputDataS('sItem', i) + ' Chart & Set 100분위 label');

   {$IFDEF VER130}
                     // 3Rd
                     lb_Hgt3rd.Top  := SeriesList.Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                     lb_Hgt3rd.Left := SeriesList.Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt3rd.Visible := True;

                     // 5th
                     lb_Hgt5th.Top  := SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                     lb_Hgt5th.Left := SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt5th.Visible := True;

                     // 10th
                     lb_Hgt10th.Top  := SeriesList.Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                     lb_Hgt10th.Left := SeriesList.Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt10th.Visible := True;

                     // 25th
                     lb_Hgt25th.Top  := SeriesList.Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                     lb_Hgt25th.Left := SeriesList.Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt25th.Visible := True;

                     // 50th
                     lb_Hgt50th.Top  := SeriesList.Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                     lb_Hgt50th.Left := SeriesList.Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt50th.Visible := True;

                     // 75th
                     lb_Hgt75th.Top  := SeriesList.Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                     lb_Hgt75th.Left := SeriesList.Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt75th.Visible := True;

                     //------------------------------------------------------------
                     // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                     //       - 관련 S/R : GRPD1410002 (PD 남효경)
                     //------------------------------------------------------------
                     lb_Hgt85th.Top  := SeriesList.Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s85th', i))) - 5;
                     lb_Hgt85th.Left := SeriesList.Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt85th.Visible := True;

                     // 90th
                     lb_Hgt90th.Top  := SeriesList.Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                     lb_Hgt90th.Left := SeriesList.Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt90th.Visible := True;

                     // 95th
                     lb_Hgt95th.Top  := SeriesList.Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                     lb_Hgt95th.Left := SeriesList.Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt95th.Visible := True;

                     // 97th
                     lb_Hgt97th.Top  := SeriesList.Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                     lb_Hgt97th.Left := SeriesList.Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt97th.Visible := True;
   {$ELSE}
                     // 3Rd
                     lb_Hgt3rd.Top  := Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                     lb_Hgt3rd.Left := Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt3rd.Visible := True;

                     // 5th
                     lb_Hgt5th.Top  := Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                     lb_Hgt5th.Left := Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt5th.Visible := True;

                     // 10th
                     lb_Hgt10th.Top  := Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                     lb_Hgt10th.Left := Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt10th.Visible := True;

                     // 25th
                     lb_Hgt25th.Top  := Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                     lb_Hgt25th.Left := Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt25th.Visible := True;

                     // 50th
                     lb_Hgt50th.Top  := Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                     lb_Hgt50th.Left := Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt50th.Visible := True;

                     // 75th
                     lb_Hgt75th.Top  := Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                     lb_Hgt75th.Left := Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt75th.Visible := True;

                     //------------------------------------------------------------
                     // BMI 85백분위수 (85th) 추가 @ 2014.10.23 LSH
                     //       - 관련 S/R : GRPD1410002 (PD 남효경)
                     //------------------------------------------------------------
                     lb_Hgt85th.Top  := Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s85th', i))) - 5;
                     lb_Hgt85th.Left := Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt85th.Visible := True;

                     // 90th
                     lb_Hgt90th.Top  := Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                     lb_Hgt90th.Left := Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt90th.Visible := True;

                     // 95th
                     lb_Hgt95th.Top  := Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                     lb_Hgt95th.Left := Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt95th.Visible := True;

                     // 97th
                     lb_Hgt97th.Top  := Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                     lb_Hgt97th.Left := Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                     lb_Hgt97th.Visible := True;
   {$ENDIF}

                     lb_Wgt3rd.Visible  := False;
                     lb_Wgt5th.Visible  := False;
                     lb_Wgt10th.Visible := False;
                     lb_Wgt25th.Visible := False;
                     lb_Wgt50th.Visible := False;
                     lb_Wgt75th.Visible := False;
                     lb_Wgt90th.Visible := False;
                     lb_Wgt95th.Visible := False;
                     lb_Wgt97th.Visible := False;
                  end;
               end;
            end;



         end;
      end
      else
      begin
         ShowErrMsg;
      end;


      //------------------------------------------------------
      // 표준 Chart Series별 컬러링
      //------------------------------------------------------
      with chr_PdGrow do
      begin
         if (IsAgeFlag = 'NEONATAL') then
         begin
            if (sType3 = 'F') then
            begin
               // 여아 :  Coloring
   {$IFDEF VER130}
               SeriesList.Series[0].SeriesColor  := $00EEF1FF;  // 97%
               SeriesList.Series[1].SeriesColor  := $00D7DEFF;  // 95%
               SeriesList.Series[2].SeriesColor  := $00C4CEFF;  // 90%
               SeriesList.Series[3].SeriesColor  := $00B0BEFF;  // 75%
               SeriesList.Series[4].SeriesColor  := $00ADA4FF;  // 50%
               SeriesList.Series[5].SeriesColor  := $00A59BFF;  // 25%
               SeriesList.Series[6].SeriesColor  := $009488FF;  // 10%
               SeriesList.Series[7].SeriesColor  := $007E71FF;  // 5%
               SeriesList.Series[8].SeriesColor  := clWhite;    // 3%

               SeriesList.Series[9].SeriesColor  := $00EEF1FF;  // 97%
               SeriesList.Series[10].SeriesColor := $00D7DEFF;  // 95%
               SeriesList.Series[11].SeriesColor := $00C4CEFF;  // 90%
               SeriesList.Series[12].SeriesColor := $00B0BEFF;  // 75%
               SeriesList.Series[13].SeriesColor := $00ADA4FF;  // 50%
               SeriesList.Series[14].SeriesColor := $00A59BFF;  // 25%
               SeriesList.Series[15].SeriesColor := $009488FF;  // 10%
               SeriesList.Series[16].SeriesColor := $007E71FF;  // 5%
               SeriesList.Series[17].SeriesColor := clWhite;    // 3%

               SeriesList.Series[18].SeriesColor := $00EEF1FF;  // 97%
               SeriesList.Series[19].SeriesColor := $00C4CEFF;  // 90%
               SeriesList.Series[20].SeriesColor := $00ADA4FF;  // 50%
               SeriesList.Series[21].SeriesColor := $009488FF;  // 10%
               SeriesList.Series[22].SeriesColor := clWhite;    // 3%
   {$ELSE}
               Series[0].SeriesColor  := $00EEF1FF;  // 97%
               Series[1].SeriesColor  := $00D7DEFF;  // 95%
               Series[2].SeriesColor  := $00C4CEFF;  // 90%
               Series[3].SeriesColor  := $00B0BEFF;  // 75%
               Series[4].SeriesColor  := $00ADA4FF;  // 50%
               Series[5].SeriesColor  := $00A59BFF;  // 25%
               Series[6].SeriesColor  := $009488FF;  // 10%
               Series[7].SeriesColor  := $007E71FF;  // 5%
               Series[8].SeriesColor  := clWhite;    // 3%

               Series[9].SeriesColor  := $00EEF1FF;  // 97%
               Series[10].SeriesColor := $00D7DEFF;  // 95%
               Series[11].SeriesColor := $00C4CEFF;  // 90%
               Series[12].SeriesColor := $00B0BEFF;  // 75%
               Series[13].SeriesColor := $00ADA4FF;  // 50%
               Series[14].SeriesColor := $00A59BFF;  // 25%
               Series[15].SeriesColor := $009488FF;  // 10%
               Series[16].SeriesColor := $007E71FF;  // 5%
               Series[17].SeriesColor := clWhite;    // 3%

               Series[18].SeriesColor := $00EEF1FF;  // 97%
               Series[19].SeriesColor := $00C4CEFF;  // 90%
               Series[20].SeriesColor := $00ADA4FF;  // 50%
               Series[21].SeriesColor := $009488FF;  // 10%
               Series[22].SeriesColor := clWhite;    // 3%
   {$ENDIF}
            end
            else if (sType3 = 'M') then
            begin
               // 남아 : Coloring
   {$IFDEF VER130}
               SeriesList.Series[0].SeriesColor  := $00F9F3EC; // 변경전 $00FEEBE2;  // 97%
               SeriesList.Series[1].SeriesColor  := $00F6EDE3; // 변경전 $00FDD5C1;  // 95%
               SeriesList.Series[2].SeriesColor  := $00F3EEDA; // 변경전 $00FCBEA0;  // 90%
               SeriesList.Series[3].SeriesColor  := $00E8DDB6; // 변경전 $00FBA67D;  // 75%
               SeriesList.Series[4].SeriesColor  := $00DFD49D; // 변경전 $00F98751;  // 50%
               SeriesList.Series[5].SeriesColor  := $00DFC892; // 변경전 $00F86B27;  // 25%
               SeriesList.Series[6].SeriesColor  := $00E2B38D; // 변경전 $00F25509;  // 10%
               SeriesList.Series[7].SeriesColor  := $00DA9B6B; // 변경전 $00D64A07;  // 5%
               SeriesList.Series[8].SeriesColor  := clWhite;    // 3%

               SeriesList.Series[9].SeriesColor  := $00F9F3EC;  // 97%
               SeriesList.Series[10].SeriesColor := $00F6EDE3;  // 95%
               SeriesList.Series[11].SeriesColor := $00F3EEDA;  // 90%
               SeriesList.Series[12].SeriesColor := $00E8DDB6;  // 75%
               SeriesList.Series[13].SeriesColor := $00DFD49D;  // 50%
               SeriesList.Series[14].SeriesColor := $00DFC892;  // 25%
               SeriesList.Series[15].SeriesColor := $00E2B38D;  // 10%
               SeriesList.Series[16].SeriesColor := $00DA9B6B;  // 5%
               SeriesList.Series[17].SeriesColor := clWhite;    // 3%

               SeriesList.Series[18].SeriesColor := $00F9F3EC;  // 97%
               SeriesList.Series[19].SeriesColor := $00F3EEDA;  // 90%
               SeriesList.Series[20].SeriesColor := $00DFD49D;  // 50%
               SeriesList.Series[21].SeriesColor := $00E2B38D;  // 10%
               SeriesList.Series[22].SeriesColor := clWhite;    // 3%
   {$ELSE}
               Series[0].SeriesColor  := $00F9F3EC; // 변경전 $00FEEBE2;  // 97%
               Series[1].SeriesColor  := $00F6EDE3; // 변경전 $00FDD5C1;  // 95%
               Series[2].SeriesColor  := $00F3EEDA; // 변경전 $00FCBEA0;  // 90%
               Series[3].SeriesColor  := $00E8DDB6; // 변경전 $00FBA67D;  // 75%
               Series[4].SeriesColor  := $00DFD49D; // 변경전 $00F98751;  // 50%
               Series[5].SeriesColor  := $00DFC892; // 변경전 $00F86B27;  // 25%
               Series[6].SeriesColor  := $00E2B38D; // 변경전 $00F25509;  // 10%
               Series[7].SeriesColor  := $00DA9B6B; // 변경전 $00D64A07;  // 5%
               Series[8].SeriesColor  := clWhite;    // 3%

               Series[9].SeriesColor  := $00F9F3EC;  // 97%
               Series[10].SeriesColor := $00F6EDE3;  // 95%
               Series[11].SeriesColor := $00F3EEDA;  // 90%
               Series[12].SeriesColor := $00E8DDB6;  // 75%
               Series[13].SeriesColor := $00DFD49D;  // 50%
               Series[14].SeriesColor := $00DFC892;  // 25%
               Series[15].SeriesColor := $00E2B38D;  // 10%
               Series[16].SeriesColor := $00DA9B6B;  // 5%
               Series[17].SeriesColor := clWhite;    // 3%

               Series[18].SeriesColor := $00F9F3EC;  // 97%
               Series[19].SeriesColor := $00F3EEDA;  // 90%
               Series[20].SeriesColor := $00DFD49D;  // 50%
               Series[21].SeriesColor := $00E2B38D;  // 10%
               Series[22].SeriesColor := clWhite;    // 3%
   {$ENDIF}
            end;
         end
         else
         begin
            if (sType3 = 'F') then
            begin
   {$IFDEF VER130}
               // 여아 :  Coloring
               SeriesList.Series[0].SeriesColor  := $00EEF1FF;  // 97%
               SeriesList.Series[1].SeriesColor  := $00D7DEFF;  // 95%
   {$ELSE}
               // 여아 :  Coloring
               Series[0].SeriesColor  := $00EEF1FF;  // 97%
               Series[1].SeriesColor  := $00D7DEFF;  // 95%
   {$ENDIF}


               //---------------------------------------------------------------
               // BMI 85 백분위수 추가관련 Color 분기 @ 2014.10.23 LSH
               //       - 관련 S/R : GRPD1410002 (PD 남효경)
               //---------------------------------------------------------------
               if (IsAgeFlag = 'BMI') or
                  (IsAgeFlag = 'HEADCIR') then
               begin
   {$IFDEF VER130}
                  SeriesList.Series[2].SeriesColor  := $00C4CEFF;  // 90%
                  SeriesList.Series[3].SeriesColor  := $00C4CEFF;  // 85%
                  SeriesList.Series[4].SeriesColor  := $00B0BEFF;  // 75%
                  SeriesList.Series[5].SeriesColor  := $00ADA4FF;  // 50%
                  SeriesList.Series[6].SeriesColor  := $00A59BFF;  // 25%
                  SeriesList.Series[7].SeriesColor  := $009488FF;  // 10%
                  SeriesList.Series[8].SeriesColor  := $007E71FF;  // 5%
                  SeriesList.Series[9].SeriesColor  := clWhite;
   {$ELSE}
                  Series[2].SeriesColor  := $00C4CEFF;  // 90%
                  Series[3].SeriesColor  := $00C4CEFF;  // 85%
                  Series[4].SeriesColor  := $00B0BEFF;  // 75%
                  Series[5].SeriesColor  := $00ADA4FF;  // 50%
                  Series[6].SeriesColor  := $00A59BFF;  // 25%
                  Series[7].SeriesColor  := $009488FF;  // 10%
                  Series[8].SeriesColor  := $007E71FF;  // 5%
                  Series[9].SeriesColor  := clWhite;
   {$ENDIF}
               end
               else
               begin
   {$IFDEF VER130}
                  SeriesList.Series[2].SeriesColor  := $00C4CEFF;  // 90%
                  SeriesList.Series[3].SeriesColor  := $00B0BEFF;  // 75%
                  SeriesList.Series[4].SeriesColor  := $00ADA4FF;  // 50%
                  SeriesList.Series[5].SeriesColor  := $00A59BFF;  // 25%
                  SeriesList.Series[6].SeriesColor  := $009488FF;  // 10%
                  SeriesList.Series[7].SeriesColor  := $007E71FF;  // 5%
                  SeriesList.Series[8].SeriesColor  := clWhite;    // 3%
                  SeriesList.Series[9].SeriesColor  := $00EEF1FF;  // 97%
   {$ELSE}
                  Series[2].SeriesColor  := $00C4CEFF;  // 90%
                  Series[3].SeriesColor  := $00B0BEFF;  // 75%
                  Series[4].SeriesColor  := $00ADA4FF;  // 50%
                  Series[5].SeriesColor  := $00A59BFF;  // 25%
                  Series[6].SeriesColor  := $009488FF;  // 10%
                  Series[7].SeriesColor  := $007E71FF;  // 5%
                  Series[8].SeriesColor  := clWhite;    // 3%
                  Series[9].SeriesColor  := $00EEF1FF;  // 97%
   {$ENDIF}
               end;

   {$IFDEF VER130}
               SeriesList.Series[10].SeriesColor := $00D7DEFF;  // 95%
               SeriesList.Series[11].SeriesColor := $00C4CEFF;  // 90%
               SeriesList.Series[12].SeriesColor := $00B0BEFF;  // 75%
               SeriesList.Series[13].SeriesColor := $00ADA4FF;  // 50%
               SeriesList.Series[14].SeriesColor := $00A59BFF;  // 25%
               SeriesList.Series[15].SeriesColor := $009488FF;  // 10%
               SeriesList.Series[16].SeriesColor := $007E71FF;  // 5%
               SeriesList.Series[17].SeriesColor := clWhite;    // 3%
   {$ELSE}
               Series[10].SeriesColor := $00D7DEFF;  // 95%
               Series[11].SeriesColor := $00C4CEFF;  // 90%
               Series[12].SeriesColor := $00B0BEFF;  // 75%
               Series[13].SeriesColor := $00ADA4FF;  // 50%
               Series[14].SeriesColor := $00A59BFF;  // 25%
               Series[15].SeriesColor := $009488FF;  // 10%
               Series[16].SeriesColor := $007E71FF;  // 5%
               Series[17].SeriesColor := clWhite;    // 3%
   {$ENDIF}
            end
            else if (sType3 = 'M') then
            begin
               // 남아 : Coloring
   {$IFDEF VER130}
               SeriesList.Series[0].SeriesColor  := $00F9F3EC;  // 97%
               SeriesList.Series[1].SeriesColor  := $00F6EDE3;  // 95%
   {$ELSE}
               Series[0].SeriesColor  := $00F9F3EC;  // 97%
               Series[1].SeriesColor  := $00F6EDE3;  // 95%
   {$ENDIF}


               //---------------------------------------------------------------
               // BMI 85 백분위수 추가관련 Color 분기 @ 2014.10.23 LSH
               //       - 관련 S/R : GRPD1410002 (PD 남효경)
               //---------------------------------------------------------------
               if (IsAgeFlag = 'BMI') or
                  (IsAgeFlag = 'HEADCIR') then
               begin
   {$IFDEF VER130}
                  SeriesList.Series[2].SeriesColor  := $00F3EEDA;  // 90%
                  SeriesList.Series[3].SeriesColor  := $00F3EEDA;  // 90%
                  SeriesList.Series[4].SeriesColor  := $00E8DDB6;  // 75%
                  SeriesList.Series[5].SeriesColor  := $00DFD49D;  // 50%
                  SeriesList.Series[6].SeriesColor  := $00DFC892;  // 25%
                  SeriesList.Series[7].SeriesColor  := $00E2B38D;  // 10%
                  SeriesList.Series[8].SeriesColor  := $00DA9B6B;  // 5%
                  SeriesList.Series[9].SeriesColor  := clWhite;
   {$ELSE}
                  Series[2].SeriesColor  := $00F3EEDA;  // 90%
                  Series[3].SeriesColor  := $00F3EEDA;  // 90%
                  Series[4].SeriesColor  := $00E8DDB6;  // 75%
                  Series[5].SeriesColor  := $00DFD49D;  // 50%
                  Series[6].SeriesColor  := $00DFC892;  // 25%
                  Series[7].SeriesColor  := $00E2B38D;  // 10%
                  Series[8].SeriesColor  := $00DA9B6B;  // 5%
                  Series[9].SeriesColor  := clWhite;
   {$ENDIF}
               end
               else
               begin
   {$IFDEF VER130}
                  SeriesList.Series[2].SeriesColor  := $00F3EEDA;  // 90%
                  SeriesList.Series[3].SeriesColor  := $00E8DDB6;  // 75%
                  SeriesList.Series[4].SeriesColor  := $00DFD49D;  // 50%
                  SeriesList.Series[5].SeriesColor  := $00DFC892;  // 25%
                  SeriesList.Series[6].SeriesColor  := $00E2B38D;  // 10%
                  SeriesList.Series[7].SeriesColor  := $00DA9B6B;  // 5%
                  SeriesList.Series[8].SeriesColor  := clWhite;    // 3%
                  SeriesList.Series[9].SeriesColor  := $00F9F3EC;  // 97%
   {$ELSE}
                  Series[2].SeriesColor  := $00F3EEDA;  // 90%
                  Series[3].SeriesColor  := $00E8DDB6;  // 75%
                  Series[4].SeriesColor  := $00DFD49D;  // 50%
                  Series[5].SeriesColor  := $00DFC892;  // 25%
                  Series[6].SeriesColor  := $00E2B38D;  // 10%
                  Series[7].SeriesColor  := $00DA9B6B;  // 5%
                  Series[8].SeriesColor  := clWhite;    // 3%
                  Series[9].SeriesColor  := $00F9F3EC;  // 97%
   {$ENDIF}
               end;

   {$IFDEF VER130}
               SeriesList.Series[10].SeriesColor := $00F6EDE3;  // 95%
               SeriesList.Series[11].SeriesColor := $00F3EEDA;  // 90%
               SeriesList.Series[12].SeriesColor := $00E8DDB6;  // 75%
               SeriesList.Series[13].SeriesColor := $00DFD49D;  // 50%
               SeriesList.Series[14].SeriesColor := $00DFC892;  // 25%
               SeriesList.Series[15].SeriesColor := $00E2B38D;  // 10%
               SeriesList.Series[16].SeriesColor := $00DA9B6B;  // 5%
               SeriesList.Series[17].SeriesColor := clWhite;    // 3%
   {$ELSE}
               Series[10].SeriesColor := $00F6EDE3;  // 95%
               Series[11].SeriesColor := $00F3EEDA;  // 90%
               Series[12].SeriesColor := $00E8DDB6;  // 75%
               Series[13].SeriesColor := $00DFD49D;  // 50%
               Series[14].SeriesColor := $00DFC892;  // 25%
               Series[15].SeriesColor := $00E2B38D;  // 10%
               Series[16].SeriesColor := $00DA9B6B;  // 5%
               Series[17].SeriesColor := clWhite;    // 3%
   {$ENDIF}
            end;
         end;
      end;


   finally
      FreeAndNil(TpGetGrow);

      Screen.Cursor := crDefault;
   end;
end;




//------------------------------------------------------------------------------
// [Axis] 성별-월령별 항목별 표준성장지표 Axis 설정
//
// Date     : 2013.11.20
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.SetStandardAxis(in_Flag,
                                    in_Sex : String);
begin
   // Log
   Memo1.Lines.Add('Call SetStandardAxis(Repaint) : ' + in_Flag + ' / ' + in_Sex);


   // Chart Axis Repaint
   chr_PdGrow.Repaint;

end;


//------------------------------------------------------------------------------
//[구로] 남효경 세로 모니터 사용시 화면 밑으로 보일 수 있게 수정
// 2016.09.07 최영대
//------------------------------------------------------------------------------
procedure TMDRC05F1.FormSetting;
begin

   if Screen.MonitorCount > 1 then
   begin
      if Screen.Monitors[0].MonitorNum = 0 then
      begin
         if Screen.Monitors[0].Width > 1201 then
         begin
            // FormStyle = poDefault로 띄우되 왼쪽 상단 메인환자 정보 밑에 고정시켜 달라하여 좌표 fixed @ 2018.05.31 LSH (PD 남효경 요청)
            self.Left := 0;
            self.Top  := 100;
         end
         else
         begin
            Self.Top   := 510;
            Self.Left  := -35;
         end;
      end;
   end;
end;


//------------------------------------------------------------------------------
// [생성] Form onShow Event Handler
//
// Date     : 2013.11.20
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.FormShow(Sender: TObject);
var
   Key : Word;
begin
   // 구로병원 세로 모니터서 처방화면 밑으로 볼 수 있게 (PD 남효경)
   // FormSetting 함수 사용
   // 2016.09.07 최영대
   // [안암] 이기형 의무부총장 대진에 따른 Pivot 확대 적용 @ 2017.12.27 LSH (PD 남효경)
   if (G_Locate <> 'AS') and (fn_nvl(FsMedDept, G_DeptCd) = 'PD') then
   begin
      FormSetting;
   end;


   // Log
   Memo1.Lines.Add('== Show MainForm ==');
   Memo1.Lines.Add('-------------------');


   //------------------------------------------------------
   // Hidden Info
   //------------------------------------------------------
   with asg_BodyInfo do
   begin
      ColWidths[C_RGTTIME] := 0;
      ColWidths[C_MEDDATE] := 0;
   end;


   //------------------------------------------------------
   // 개발자 Debugging 모드
   //------------------------------------------------------
   if CheckUserBtn('MDRC05_DBG',
                   G_UserId) then
   begin
      Advpn_Log.Collaps   := False;
      Advpn_Log.Visible   := True;
      sbt_Refresh.Visible := True;
      sbt_ZoomIn.Visible  := True;
   end
   else
   begin
      Advpn_Log.Visible   := False;
      sbt_Refresh.Visible := False;
      sbt_ZoomIn.Visible  := False;
   end;


   //------------------------------------------------------
   // Flow-Sheet (EMR) 호출시 입원 측정이력 포함 자동 Check
   //       - 관련 S/R : ASPD1610013 (PD 신정희)
   //       - 2017.01.17 LSH
   //
   // 환자 구분이 [입원]인 경우, onShow시 자동 Check
   //       - 2017.01.26 LSH
   //------------------------------------------------------
   cbx_AdmIncluded.Checked := (FsFromForm = 'FLOWSHEET') or (FsPatCls = 'I');


   //------------------------------------------------------
   // 표준 D/B 기준 인덱스 별 Caption 변경 @ 2018.05.28 LSH
   //          - 관련 S/R : GRPD1803005 (PD 남효경)
   //------------------------------------------------------
   if (FsStandIdx = 'DDET') then
      self.Caption := '[MDRC05F1] 성장발육곡선 Chart 2007'
   else if (FsStandIDx = '2017') then
      self.Caption := '[MDRC05F1] 성장발육곡선 Chart 2017';


   //------------------------------------------------------
   // 성장발육곡선 출력(캡쳐) 버튼 활성화 @ 2020.01.28 LSH
   //          - 관련 S/R : 없음 (PD 이기형 ex-의료원장)
   //------------------------------------------------------
   if CheckUserBtn('MDRC05_PRT', G_UserId) or
      CheckDeptBtn('MDRC05_PRT', md_DeptCd)then
   begin
      fbt_Print.Visible := True;
   end
   else
   begin
      fbt_Print.Visible := False;
   end;


   //------------------------------------------------------
   // 호출 폼에서 받은 환자번호 assign
   //------------------------------------------------------
   fed_PatNo.Text := FsPatNo;
   fed_PatNo.SetFocus;

   Key := 13;


   //------------------------------------------------------
   // 환자선택 유무 (Tag)
   //------------------------------------------------------
   if fed_PatNo.Text <> '' then
      fed_PatNo.Tag := 1;


   //------------------------------------------------------
   // 진료과 조회
   //------------------------------------------------------
   fcb_MedDept.ItemIndex := GetFlatMedDept(fcb_MedDept);


   //------------------------------------------------------
   // 환자정보 조회
   //------------------------------------------------------
   fed_PatNoKeyDown(Sender, Key, []);

end;






//------------------------------------------------------------------------------
// [Multiple Axis] Chart onAfterDraw Event Handler
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowAfterDraw(Sender: TObject);
var
   PosRightAxis, PosLeftAxis : LongInt;
begin
   // Log
   Memo1.Lines.Add('Call onAfterDraw, : ' + IsAgeFlag + '(' + TComponent(Sender).Name + ')');


   //------------------------------------------------------
   // Vertical Axis에 Custom Axis Drawing 추가
   //------------------------------------------------------
   with chr_PdGrow do
   begin
      if (IsAgeFlag = 'NEONATAL') then
      begin

         PosRightAxis := ChartRect.Right;

         LeftAxis.CustomDraw(PosRightAxis + 47,
                             PosRightAxis,
                             PosRightAxis,
                             True);

         PosLeftAxis := ChartRect.Left;

         RightAxis.CustomDraw(PosLeftAxis - 45,
                              PosLeftAxis,
                              PosLeftAxis,
                              True);


         // 신생아 출생주수 Line Drawing
         NeoBornAfterDraw;

      end
      else if (IsAgeFlag = 'ZERO2THIRTYSIX') or
              (IsAgeFlag = 'TWO2EIGHTTEEN')  then
      begin
         PosRightAxis := ChartRect.Right;

         LeftAxis.CustomDraw(PosRightAxis + 50,
                             PosRightAxis,
                             PosRightAxis,
                             True);



         PosLeftAxis := ChartRect.Left;

         RightAxis.CustomDraw(PosLeftAxis - 45,
                              PosLeftAxis,
                              PosLeftAxis,
                              True);




         // 체중/신장 백분위수 표기 추가 @ 2014.05.26 LSH
         DrawPatSeries;


      end
      else if (IsAgeFlag = 'HEADCIR') or
              (IsAgeFlag = 'BMI')     then
      begin
         PosLeftAxis := ChartRect.Left;


         RightAxis.CustomDraw(PosLeftAxis - 18,
                              PosLeftAxis,
                              PosLeftAxis,
                              True);

         // BMI 백분위수 표기 추가 @ 2014.05.26 LSH
         if (IsAgeFlag = 'BMI') and (fcb_Percent.Checked) then
            DrawPatSeries;


      end;

      {
      // 좌측 [체중] Custom Axis Drawing 추가 : 단일 Axis내 체중/신장 Display 되지만 Zoom In/Out 기능 버그로 주석
      LeftAxis.CustomDrawMinMaxStartEnd(PosRightAxis-547,
                                        PosRightAxis,
                                        PosRightAxis,
                                        True,
                                        5,
                                        20,
                                        0.1,
                                        688,
                                        768);

      // 우측 [신장] Custom Axis Drawing 추가 : 단일 Axis내 체중/신장 Display 되지만 Zoom In/Out 기능 버그로 주석
      RightAxis.CustomDrawMinMaxStartEnd(PosLeftAxis+547,
                                         PosLeftAxis,
                                         PosLeftAxis,
                                         True,
                                         150,
                                         190,
                                         0.1,
                                         61,
                                         281);
     }
   end;

end;




//------------------------------------------------------------------------------
// [Axis Label] Chart onGetNextAxisLabel Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowGetNextAxisLabel(Sender: TChartAxis;
  LabelIndex: Integer; var LabelValue: Double; var Stop: Boolean);
begin

   // Log
   Memo1.Lines.Add('Call onGetNextAxisLabel ' + TChartAxis(Sender).Title.Caption);


   //-------------------------------------------------------------
   // Axis Range 수동 Refersh Debugging 처리 @ 2013.12.24 LSH
   //-------------------------------------------------------------
   ResetAxisRange;



   with chr_PdGrow do
   begin

      //--------------------------------------------------------------
      // 신생아 (22주~50주) 성장발육곡선 Chart Axis
      //--------------------------------------------------------------
      if (IsAgeFlag = 'NEONATAL') then
      begin

         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := 50;
            BottomAxis.Minimum              := 22;
            BottomAxis.Increment            := 2;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := False;
            BottomAxis.MinorTickCount       := 2;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := 50;
            TopAxis.Minimum                 := 22;
            TopAxis.Increment               := 2;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 2;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 65;
            LeftAxis.Minimum                := -25;
            LeftAxis.Increment              := 5;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 4;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;


         LeftAxis.Visible  := True;


         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 9;
            RightAxis.Minimum               := 0;
            RightAxis.Increment             := 0.5;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 4;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;



      end
      //--------------------------------------------------------------
      // 0개월 ~ 36개월 성장발육곡선 Chart Axis
      //--------------------------------------------------------------
      else if (IsAgeFlag = 'ZERO2THIRTYSIX') then
      begin

         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := 36;
            BottomAxis.Minimum              := 0;
            BottomAxis.Increment            := 3;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := False;
            BottomAxis.MinorTickCount       := 2;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := 36;
            TopAxis.Minimum                 := 0;
            TopAxis.Increment               := 3;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 2;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 105;
            LeftAxis.Minimum                := -10;
            // xe7 버전 화면에서 좌표 값 맞지 않아 수정  1 => 5 - 2016.01.14 최영대
            LeftAxis.Increment              := 5;
            //LeftAxis.Increment              := 5;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 4;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;


         LeftAxis.Visible  := True;


         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 25;
            RightAxis.Minimum               := 2;
            RightAxis.Increment             := 1;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 4;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;

      end
      //--------------------------------------------------------------
      // 만2세 ~ 18세 성장발육곡선 Chart Axis
      //--------------------------------------------------------------
      else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
      begin

         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := 18;
            BottomAxis.Minimum              := 2;
            BottomAxis.Increment            := 1;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := False;
            BottomAxis.MinorTickCount       := 0;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := 18;
            TopAxis.Minimum                 := 2;
            TopAxis.Increment               := 1;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 0;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min 오류 방지

         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 190;
            LeftAxis.Minimum                := 60;
            // xe7 버전 화면에서 좌표 값 맞지 않아 수정  0.1 => 5 - 2016.01.14 최영대
             LeftAxis.Increment              := 5;
            //LeftAxis.Increment              := 5;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 4;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;


         LeftAxis.Visible  := True;


         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 135;
            RightAxis.Minimum               := 5;
            // xe7 버전 화면에서 좌표 값 맞지 않아 수정  0.1 => 5 - 2016.01.14 최영대
            RightAxis.Increment             := 5;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 4;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;

      end
      //--------------------------------------------------------------
      // 만0세 ~ 6세 두위 백분위 곡선 Chart Axis
      //--------------------------------------------------------------
      else if (IsAgeFlag = 'HEADCIR') then
      begin


         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := fn_decode([FsStandIdx, 'DDET', C_2007_HEADCIR_MAXRANGE, '2017', C_2017_HEADCIR_MAXRANGE, C_2017_HEADCIR_MAXRANGE]);   // 두위 월령범위 변경(2007 vs. 2017)에 따른 분기 @ 2018.05.29 LSH
            BottomAxis.Minimum              := 0;
            BottomAxis.Increment            := 3;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := True;
            BottomAxis.MinorTickCount       := 2;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := fn_decode([FsStandIdx, 'DDET', C_2007_HEADCIR_MAXRANGE, '2017', C_2017_HEADCIR_MAXRANGE, C_2017_HEADCIR_MAXRANGE]);   // 두위 월령범위 변경(2007 vs. 2017)에 따른 분기 @ 2018.05.29 LSH
            TopAxis.Minimum                 := 0;
            TopAxis.Increment               := 3;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 2;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 58;
            LeftAxis.Minimum                := 30;
            LeftAxis.Increment              := 2;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := False;
            LeftAxis.MinorTickCount         := 1;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;

         //------------------------------------------------------
         // 기준 Axis인 Right Axis를 Custom Drawing으로 복사해서
         // 사용하므로 Invisible @ 2013.12.23 LSH
         //------------------------------------------------------
         LeftAxis.Visible := False;


         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 58;
            RightAxis.Minimum               := 30;
            RightAxis.Increment             := 2;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 1;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;

      end
      //--------------------------------------------------------------
      // 만2세 ~ 18세 BMI 백분위 곡선 Chart Axis
      //--------------------------------------------------------------
      else if (IsAgeFlag = 'BMI') then
      begin

         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := 18;
            BottomAxis.Minimum              := 2;
            BottomAxis.Increment            := 1;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := False;
            BottomAxis.MinorTickCount       := 1;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;

         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := 18;
            TopAxis.Minimum                 := 2;
            TopAxis.Increment               := 1;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 1;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min 오류 방지
         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 32;
            LeftAxis.Minimum                := 10;
            LeftAxis.Increment              := 2;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 3;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;

         //------------------------------------------------------
         // 기준 Axis인 Right Axis를 Custom Drawing으로 복사해서
         // 사용하므로 Invisible @ 2013.12.23 LSH
         //------------------------------------------------------
         LeftAxis.Visible := False;

         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 32;
            RightAxis.Minimum               := 10;
            RightAxis.Increment             := 2;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 3;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min 오류 방지
         end;
      end;

   end;
end;





//------------------------------------------------------------------------------
// [Axis Panel] 성별-월령별 Axis Hide Panel 위치 설정
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.SetAxisPanel(in_Flag : String);
begin
   // Log
   Memo1.Lines.Add('Call SetAxisPanel Location: ' + in_Flag);

   //------------------------------------------------------
   // 월령별 표준지표 Axis 구분 Flag Set
   //------------------------------------------------------
   IsAgeFlag := in_Flag;


   //------------------------------------------------------
   // 백분위 Label Initalization
   //------------------------------------------------------
   lb_Neo3rd.Visible  := False;
   lb_Neo10th.Visible := False;
   lb_Neo50th.Visible := False;
   lb_Neo90th.Visible := False;
   lb_Neo97th.Visible := False;

   lb_Hgt3rd.Visible  := False;
   lb_Hgt5th.Visible  := False;
   lb_Hgt10th.Visible := False;
   lb_Hgt25th.Visible := False;
   lb_Hgt50th.Visible := False;
   lb_Hgt75th.Visible := False;
   lb_Hgt85th.Visible := False;     // BMI 85백분위수 추가 @ 2014.10.23 LSH
   lb_Hgt90th.Visible := False;
   lb_Hgt95th.Visible := False;
   lb_Hgt97th.Visible := False;

   lb_Wgt3rd.Visible  := False;
   lb_Wgt5th.Visible  := False;
   lb_Wgt10th.Visible := False;
   lb_Wgt25th.Visible := False;
   lb_Wgt50th.Visible := False;
   lb_Wgt75th.Visible := False;
   lb_Wgt90th.Visible := False;
   lb_Wgt95th.Visible := False;
   lb_Wgt97th.Visible := False;

   //--------------------------------------------------------------
   // 신생아(22주 ~ 50주) 성장발육곡선 Chart Axis
   //--------------------------------------------------------------
   if (IsAgeFlag = 'NEONATAL') then
   begin
      fpn_LeftHgtAxis.Top     := 60; // + C_NEONATAL_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 21;   // XE7 전환시 LabelsSize = 30 적용관련 변경(13);
      fpn_LeftHgtAxis.Height  := 408;
      fpn_LeftHgtAxis.Caption := '신장';
      lb_LeftHgt.Top          := 211 + 147;
      lb_LeftHgt.Left         := 1;
      lb_LeftHgt.Caption      := '두위' + #13#10 + ' cm';

      fpn_LeftWgtAxis.Top     := 471 + C_NEONATAL_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 44;   // XE7 전환시 LabelsSize = 30 적용관련 변경(38);
      fpn_LeftWgtAxis.Height  := 332;
      lb_LeftWgt.Top          := 172; // + C_NEONATAL_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 60;   //  + C_NEONATAL_TOP_OFFSET; // 85;
      fpn_RightHgtAxis.Left   := 608;   // XE7 전환시 LabelsSize = 30 적용관련 변경(612);
      fpn_RightHgtAxis.Height := 210;
      fpn_RightHgtAxis.Caption:= '신장';
      lb_RightHgt.Top         := 110 + 70 + C_NEONATAL_TOP_OFFSET;
      lb_RightHgt.Left        := 0;
      lb_RightHgt.Caption     := '두위' + #13#10 + ' cm';

      fpn_RightWgtAxis.Top    := 300 + C_NEONATAL_TOP_OFFSET;
      fpn_RightWgtAxis.Left   := 629;   // XE7 전환시 LabelsSize = 30 적용관련 변경(635);
      fpn_RightWgtAxis.Height := 505;
      fpn_RightWgtAxis.Width  := 26;
      lb_RightWgt.Top         := 260; // + C_NEONATAL_TOP_OFFSET;
      lb_RightWgt.Left        := 7;

      lb_RightHead.Top        := 999;
      lb_RightHead.Left       := 999;
      lb_RightHead.Visible    := False;

      lb_RightBmi.Top         := 999;
      lb_RightBmi.Left        := 999;
      lb_RightBmi.Visible     := False;

      lb_Age.Caption := '재태주수(주)';

      lb_BornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // 0개월 ~ 36개월 성장발육곡선 Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'ZERO2THIRTYSIX') then
   begin
      fpn_LeftHgtAxis.Top     := 65 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 19;   // XE7 전환시 LabelsSize = 30 적용관련 변경(10);
      fpn_LeftHgtAxis.Height  := 408;
      fpn_LeftHgtAxis.Caption := '신장';
      lb_LeftHgt.Top          := 211; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_LeftHgt.Left         := 7;
      lb_LeftHgt.Caption      := 'cm';

      fpn_LeftWgtAxis.Top     := 474 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 43;   // XE7 전환시 LabelsSize = 30 적용관련 변경(39);
      fpn_LeftWgtAxis.Height  := 332;
      lb_LeftWgt.Top          := 172; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 65 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_RightHgtAxis.Left   := 606;  // XE7 전환시 LabelsSize = 30 적용관련 변경(613);
      fpn_RightHgtAxis.Height := 156;
      fpn_RightHgtAxis.Caption:= '신장';
      lb_RightHgt.Top         := 86; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_RightHgt.Left        := 6;
      lb_RightHgt.Caption     := 'cm';

      fpn_RightWgtAxis.Top    := 230 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_RightWgtAxis.Left   := 636;  // XE7 전환시 LabelsSize = 30 적용관련 변경(642);
      fpn_RightWgtAxis.Height := 591;
      lb_RightWgt.Top         := 304; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_RightWgt.Left        := 7;

      lb_RightHead.Top        := 999;
      lb_RightHead.Left       := 999;
      lb_RightHead.Visible    := False;

      lb_RightBmi.Top         := 999;
      lb_RightBmi.Left        := 999;
      lb_RightBmi.Visible     := False;

      lb_Age.Caption := '월령(개월)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // 신생아 출생주수 확인 Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // 만2세 ~ 18세 성장발육곡선 Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
   begin
      fpn_LeftHgtAxis.Top     := 61 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 19;   // XE7 전환시 LabelsSize = 30 적용관련 변경(15);
      fpn_LeftHgtAxis.Height  := 632;
      fpn_LeftHgtAxis.Caption := '신장';

      lb_LeftHgt.Top          := 323; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_LeftHgt.Left         := 7;
      lb_LeftHgt.Caption      := 'cm';

      fpn_LeftWgtAxis.Top     := 694 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 42;   // XE7 전환시 LabelsSize = 30 적용관련 변경(38);
      fpn_LeftWgtAxis.Height  := 109;
      lb_LeftWgt.Top          := 60; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 63 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_RightHgtAxis.Left   := 605;  // XE7 전환시 LabelsSize = 30 적용관련 변경(610);
      fpn_RightHgtAxis.Height := 252;
      fpn_RightHgtAxis.Caption:= '신장';
      lb_RightHgt.Top         := 131; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_RightHgt.Left        := 6;
      lb_RightHgt.Caption     := 'cm';

      fpn_RightWgtAxis.Top    := 320 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_RightWgtAxis.Left   := 632;
      fpn_RightWgtAxis.Height := 490;
      lb_RightWgt.Top         := 252; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_RightWgt.Left        := 7;

      lb_RightHead.Top        := 999;
      lb_RightHead.Left       := 999;
      lb_RightHead.Visible    := False;

      lb_RightBmi.Top         := 999;
      lb_RightBmi.Left        := 999;
      lb_RightBmi.Visible     := False;

      lb_Age.Caption := '연령(세)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // 신생아 출생주수 확인 Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // 두위 표준지표 (만0세 ~ 6세 )  Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'HEADCIR') then
   begin
      fpn_LeftHgtAxis.Top     := 999;
      fpn_LeftHgtAxis.Left    := 999;
      fpn_LeftHgtAxis.Height  := 632;
      lb_LeftHgt.Top          := 999;
      lb_LeftHgt.Left         := 999;

      fpn_LeftWgtAxis.Top     := 999;
      fpn_LeftWgtAxis.Left    := 999;
      fpn_LeftWgtAxis.Height  := 109;
      lb_LeftWgt.Top          := 999;
      lb_LeftWgt.Left         := 999;

      fpn_RightHgtAxis.Top    := 999;
      fpn_RightHgtAxis.Left   := 999;
      fpn_RightHgtAxis.Height := 252;
      lb_RightHgt.Top         := 999;
      lb_RightHgt.Left        := 999;

      fpn_RightWgtAxis.Top    := 999;
      fpn_RightWgtAxis.Left   := 999;
      fpn_RightWgtAxis.Height := 490;
      lb_RightWgt.Top         := 999;
      lb_RightWgt.Left        := 999;

      lb_RightHead.Top        := 341;
      lb_RightHead.Left       := 640;
      lb_RightHead.Visible    := True;

      lb_RightBmi.Top         := 999;
      lb_RightBmi.Left        := 999;
      lb_RightBmi.Visible     := True;

      lb_Age.Caption := '월령(개월)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // 신생아 출생주수 확인 Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // BMI 표준지표 (만2세~18세) Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'BMI') then
   begin
      fpn_LeftHgtAxis.Top     := 999;
      fpn_LeftHgtAxis.Left    := 999;
      fpn_LeftHgtAxis.Height  := 632;
      lb_LeftHgt.Top          := 999;
      lb_LeftHgt.Left         := 999;

      fpn_LeftWgtAxis.Top     := 999;
      fpn_LeftWgtAxis.Left    := 999;
      fpn_LeftWgtAxis.Height  := 109;
      lb_LeftWgt.Top          := 999;
      lb_LeftWgt.Left         := 999;

      fpn_RightHgtAxis.Top    := 999;
      fpn_RightHgtAxis.Left   := 999;
      fpn_RightHgtAxis.Height := 252;
      lb_RightHgt.Top         := 999;
      lb_RightHgt.Left        := 999;

      fpn_RightWgtAxis.Top    := 999;
      fpn_RightWgtAxis.Left   := 999;
      fpn_RightWgtAxis.Height := 490;
      lb_RightWgt.Top         := 999;
      lb_RightWgt.Left        := 999;

      lb_RightHead.Top        := 999;
      lb_RightHead.Left       := 999;
      lb_RightHead.Visible    := True;

      lb_RightBmi.Top         := 341;
      lb_RightBmi.Left        := 639;
      lb_RightBmi.Visible     := True;

      lb_Age.Caption := '연령(세)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // 신생아 출생주수 확인 Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end;
end;



//------------------------------------------------------------------------------
// [Main Panel] FlatPanel onMouseMove Event Handler
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fpn_PatInfoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   Screen.Cursor := crDefault;
end;


//------------------------------------------------------------------------------
// [Tab Control] FlatTabControl onMouseMove Event Handler
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.ftc_ChartMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   Screen.Cursor := crDefault;
end;


//------------------------------------------------------------------------------
// [좌표보기] Chart onMouseMove Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);

  //------------------------------------------------------
  // This procedure draws the crosshair lines
  //------------------------------------------------------
  Procedure DrawCross(AX,AY:Integer);
  begin
     With chr_PdGrow, Canvas do
     begin
        Pen.Color := CrossHairColor;
        Pen.Style := CrossHairStyle;
        Pen.Mode  := pmXor;
        Pen.Width := 1;
        MoveTo(ax, ChartRect.Top - Height3D);
        LineTo(ax, ChartRect.Bottom - Height3D);
        MoveTo(ChartRect.Left  + Width3D, ay);
        LineTo(ChartRect.Right + Width3D, ay);
     end;
  end;
var
  tmpX, tmpYL, tmpYR : Double;
  tmpXLabel, tmpYLeftLabel, tmpYRightLabel : String;
  i          : Integer;
begin
   //------------------------------------------------------
   // 좌표 보기 모드
   //------------------------------------------------------
   if (fcb_AxisLocate.Checked) then
   begin
      if (OldX <> -1) then
      begin
         // Draw old crosshair
         DrawCross(OldX, OldY);
         OldX := -1;
      end;

      //------------------------------------------------------
      // Check if mouse is inside Chart rectangle
      //------------------------------------------------------
      if PtInRect(chr_PdGrow.ChartRect, Point(X - chr_PdGrow.Width3D,Y + chr_PdGrow.Height3D)  ) then
      begin
         // Draw crosshair at current position
         DrawCross(x,y);


         // Store old position
         OldX  := x;
         OldY  := y;


         // Set label text
         for i := 0 to C_SERIES_CNT - 1 do
         begin
   {$IFDEF VER130}
            with chr_PdGrow.SeriesList.Series[i] do
   {$ELSE}
            with chr_PdGrow.Series[i] do
   {$ENDIF}
            begin

               if (ftc_Chart.ActiveTab = AT_NEONATAL)       or
                  (ftc_Chart.ActiveTab = AT_ZERO2THIRTYSIX) or
                  (ftc_Chart.ActiveTab = AT_TWO2EIGHTTEEN)  then
               begin

                  tmpX  := chr_PdGrow.BottomAxis.CalcPosPoint(X);
                  tmpYL := chr_PdGrow.LeftAxis.CalcPosPoint(Y);
                  tmpYR := chr_PdGrow.RightAxis.CalcPosPoint(Y);

                  tmpXLabel      := lb_Age.Caption;
                  tmpYLeftLabel  := '신장(cm)';
                  tmpYRightLabel := '체중(kg)';

                  lb_AxisLocate.Caption := '[' + tmpXLabel     + '] ' + FormatFloat('#.##', tmpX)   + ' ' +
                                           '[' + tmpYLeftLabel + '] ' + FormatFloat('#.#',  tmpYL)  + ' ' +
                                           '[' + tmpYRightLabel+ '] ' + FormatFloat('#.#',  tmpYR);
               end
               else if (ftc_Chart.ActiveTab = AT_HEADCIR) or
                       (ftc_Chart.ActiveTab = AT_BMI)     then
               begin

                  tmpX  := chr_PdGrow.BottomAxis.CalcPosPoint(X);
                  //tmpYL := chr_PdGrow.LeftAxis.CalcPosPoint(Y);
                  tmpYR := chr_PdGrow.RightAxis.CalcPosPoint(Y);

                  tmpXLabel      := lb_Age.Caption;
                  tmpYLeftLabel  := '';

                  if (ftc_Chart.ActiveTab = AT_HEADCIR) then
                     tmpYRightLabel := '두위(cm)'
                  else if (ftc_Chart.ActiveTab = AT_BMI) then
                     tmpYRightLabel := 'BMI(㎏/㎡)';

                  lb_AxisLocate.Caption := '[' + tmpXLabel     + '] ' + FormatFloat('#.##', tmpX)   + ' ' +
                                           '[' + tmpYRightLabel+ '] ' + FormatFloat('#.#',  tmpYR);
               end;
            end;
         end;
      end;
   end;


   Screen.Cursor := crTeeHand;


end;


//------------------------------------------------------------------------------
// [Zoom-In] Chart onZoom Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowZoom(Sender: TObject);
begin
   try
      // Log
      Memo1.Lines.Add('Call onZoom');


      fpn_LeftWgtAxis.Visible  := False;
      fpn_LeftHgtAxis.Visible  := False;
      fpn_RightWgtAxis.Visible := False;
      fpn_RightHgtAxis.Visible := False;

      //------------------------------------------------------
      // Vertical Axis에 Custom Axis Drawing 추가
      //------------------------------------------------------
      with chr_PdGrow do
      begin
         //
         LeftAxis.Visible   := False;
         RightAxis.Visible  := False;

         lb_Neo3rd.Visible  := False;
         lb_Neo10th.Visible := False;
         lb_Neo50th.Visible := False;
         lb_Neo90th.Visible := False;
         lb_Neo97th.Visible := False;

         lb_Hgt3rd.Visible  := False;
         lb_Hgt5th.Visible  := False;
         lb_Hgt10th.Visible := False;
         lb_Hgt25th.Visible := False;
         lb_Hgt50th.Visible := False;
         lb_Hgt75th.Visible := False;
         lb_Hgt85th.Visible := False;     // BMI 85백분위수 추가 @ 2014.10.23 LSH
         lb_Hgt85th.Top     := 999;       // Zoom-UnZoom 이벤트시 하단에 보여지는 부분 제거위해 추가 @ 2016.01.27 LSH
         lb_Hgt85th.Left    := 999;

         lb_Hgt90th.Visible := False;
         lb_Hgt95th.Visible := False;
         lb_Hgt97th.Visible := False;

         lb_Wgt3rd.Visible  := False;
         lb_Wgt5th.Visible  := False;
         lb_Wgt10th.Visible := False;
         lb_Wgt25th.Visible := False;
         lb_Wgt50th.Visible := False;
         lb_Wgt75th.Visible := False;
         lb_Wgt90th.Visible := False;
         lb_Wgt95th.Visible := False;
         lb_Wgt97th.Visible := False;
      end;
   except

   end;
end;


//------------------------------------------------------------------------------
// [Zoom-Out] Chart onUndoZoom Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowUndoZoom(Sender: TObject);
begin
   try
      // Log
      Memo1.Lines.Add('Call onUndoZoom');


      fpn_LeftWgtAxis.Visible  := True;
      fpn_LeftHgtAxis.Visible  := True;
      fpn_RightWgtAxis.Visible := True;
      fpn_RightHgtAxis.Visible := True;

      //------------------------------------------------------
      // Vertical Axis에 Custom Axis Drawing 추가
      //------------------------------------------------------
      with chr_PdGrow do
      begin
         //
         LeftAxis.Visible   := True;
         RightAxis.Visible  := True;

         if (IsAgeFlag = 'NEONATAL') then
         begin
            lb_Neo3rd.Visible  := True;
            lb_Neo10th.Visible := True;
            lb_Neo50th.Visible := True;
            lb_Neo90th.Visible := True;
            lb_Neo97th.Visible := True;

            lb_Hgt3rd.Visible  := True;
            lb_Hgt5th.Visible  := False;
            lb_Hgt10th.Visible := True;
            lb_Hgt25th.Visible := False;
            lb_Hgt50th.Visible := True;
            lb_Hgt75th.Visible := False;
            lb_Hgt85th.Visible := False;     // BMI 85백분위수 추가 @ 2014.10.23 LSH
            lb_Hgt90th.Visible := True;
            lb_Hgt95th.Visible := False;
            lb_Hgt97th.Visible := True;

            lb_Wgt3rd.Visible  := True;
            lb_Wgt5th.Visible  := False;
            lb_Wgt10th.Visible := True;
            lb_Wgt25th.Visible := False;
            lb_Wgt50th.Visible := True;
            lb_Wgt75th.Visible := False;
            lb_Wgt90th.Visible := True;
            lb_Wgt95th.Visible := False;
            lb_Wgt97th.Visible := True;
         end
         else if (IsAgeFlag = 'BMI') or
                 (IsAgeFlag = 'HEADCIR') then
         begin
            lb_Hgt3rd.Visible  := True;
            lb_Hgt5th.Visible  := True;
            lb_Hgt10th.Visible := True;
            lb_Hgt25th.Visible := True;
            lb_Hgt50th.Visible := True;
            lb_Hgt75th.Visible := True;
            lb_Hgt85th.Visible := True;      // BMI 85백분위수 추가 @ 2014.10.23 LSH
            lb_Hgt90th.Visible := True;
            lb_Hgt95th.Visible := True;
            lb_Hgt97th.Visible := True;

            lb_Wgt3rd.Visible  := False;
            lb_Wgt5th.Visible  := False;
            lb_Wgt10th.Visible := False;
            lb_Wgt25th.Visible := False;
            lb_Wgt50th.Visible := False;
            lb_Wgt75th.Visible := False;
            lb_Wgt90th.Visible := False;
            lb_Wgt95th.Visible := False;
            lb_Wgt97th.Visible := False;
         end
         else
         begin
            lb_Hgt3rd.Visible  := True;
            lb_Hgt5th.Visible  := True;
            lb_Hgt10th.Visible := True;
            lb_Hgt25th.Visible := True;
            lb_Hgt50th.Visible := True;
            lb_Hgt75th.Visible := True;
            lb_Hgt85th.Visible := True;     // BMI 85백분위수 추가 @ 2014.10.23 LSH
            lb_Hgt90th.Visible := True;
            lb_Hgt95th.Visible := True;
            lb_Hgt97th.Visible := True;

            lb_Wgt3rd.Visible  := True;
            lb_Wgt5th.Visible  := True;
            lb_Wgt10th.Visible := True;
            lb_Wgt25th.Visible := True;
            lb_Wgt50th.Visible := True;
            lb_Wgt75th.Visible := True;
            lb_Wgt90th.Visible := True;
            lb_Wgt95th.Visible := True;
            lb_Wgt97th.Visible := True;
         end;
      end;
   except

   end;
end;


//------------------------------------------------------------------------------
// [컬럼정렬] AdvStringGrid onGetAlignment Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
   //------------------------------------------------------
   // Horizontal Alignment
   //------------------------------------------------------
   if (ARow = 0) or
      ((ARow > 0) and (ACol in [C_CHECK,
                                C_RGTDATE,
                                C_MEDDEPT,
                                C_YEAR,
                                C_MONTH,
                                C_TOTMONTH,
                                C_WEIGHT,
                                C_HEIGHT,
                                C_BMI,
                                C_HEADCIR
                                ])) then
      HAlign := taCenter;

   //------------------------------------------------------
   // Vertical Alignment
   //------------------------------------------------------
   VAlign := vtaCenter;
end;


//------------------------------------------------------------------------------
// [조회] 부서명 (+부서코드) List 조회 함수
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.GetFlatMedDept(FlatCombo : TFlatComboBox) : Integer;
var
   iRowCnt, i, j : Integer;
   tmpDeptCd : String;
begin

   // Log
   Memo1.Lines.Add('Call GetFlatMedDept');


   //------------------------------------------------------
   // Initailize Return Value
   //------------------------------------------------------
   GetFlatMedDept := -1;


   //------------------------------------------------------
   // Default [PD]로 환아측정이력 조회하기 원하는 부서 Assign
   //------------------------------------------------------
   if CheckDeptBtn('MDRC05_DPT', G_DeptCd) then
      tmpDeptCd := 'PD'
   else
      tmpDeptCd := fn_nvl(FsMedDept, G_DeptCd);


   Screen.Cursor := crHourglass;


   try
      mdExCode := HmdExCode.Create;


      iRowCnt    := mdExCode.SelDeptNm('1',G_LOCATE);


      // SYSTEM ERROR
      if iRowCnt = -1 then
      begin
         mdExCode.Free;
         ShowErrMsg();
         Exit;
      end;


      // 조회건수 없음
      if iRowCnt = 0 then
      begin
         mdExCode.Free;
         Exit;
      end;


      // 코드 처리
      j := 0;

      with FlatCombo do
      begin
         Items.Clear;

         Items.add('');

         for i := 0 to iRowCnt - 1 do
         begin
            Items.add(mdExCode.sDeptCd[i] + ' [' + mdExCode.sDeptNm[i] + ']');

            inc(j);

            if mdExCode.sDeptCd[i] = tmpDeptCd then
               GetFlatMedDept := j;
         end;
      end;


      mdExCode.Free;


   finally
      screen.Cursor  :=  crDefault;
   end;
end;



//------------------------------------------------------------------------------
// [조회] 신체측정 이력 조회
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.SelBodyInfo;
var
   TpGetBdInf : TTpSvc;
   i, NowRow,  iRowCnt : Integer;
   sFlag, sType1, sType2, sType3, sType4, sType5, sType6 : String;
begin
   // Log
   Memo1.Lines.Add('Call SelBodyInfo');


   try
      //------------------------------------------------------
      // 측정이력 List 초기화
      //------------------------------------------------------
      asg_BodyInfo.ClearRows(1, asg_BodyInfo.RowCount);
      asg_BodyInfo.RowCount := 1;

   except
      // 원인미상의 Grid Out of Index 오류 방지
   end;


   //------------------------------------------------------
   // 과별 vs. 타과기록 포함 여부 조회조건
   //------------------------------------------------------
   if (cbx_OtherDept.Checked = False) then
      sFlag := '3'
   else if (cbx_OtherDept.Checked = True) then
      sFlag := '4';


   sType1 := sFlag;
   sType2 := Trim(fed_PatNo.Text);
   sType3 := fn_nvl(fn_decode([UpperCase((CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))), 'PD', 'PD', '']), fn_nvl(FsMedDept, G_DeptCd));

   // 입원시 측정이력 연동 @ 2017.01.17 LSH
   if cbx_AdmIncluded.Checked then
      sType4 := 'I'
   else
      sType4 := fn_nvl(FsPatCls,  md_PatCls);

   sType5 := fn_nvl(FsMedDate, md_AdmDate);        // 입원시 측정이력 연동관련 입원일 추가 @ 2017.01.17 LSH



   TpGetBdInf := TTpSvc.Create;
   TpGetBdInf.Init(nil);



   Screen.Cursor := crHourglass;



   try
      TpGetBdInf.CountField  := 'S_STRING15';
      TpGetBdInf.ShowMsgFlag := False;


      if TpGetBdInf.GetSvc('MD_PDBOD_L1',
                          ['S_TYPE1'    , sType1
                         , 'S_TYPE2'    , sType2
                         , 'S_TYPE3'    , sType3
                         , 'S_TYPE4'    , sType4
                         , 'S_TYPE5'    , sType5
                         , 'S_TYPE6'    , sType6
                          ],
                          [
                           'S_STRING14' , 'sMedDept'
                         , 'S_STRING15' , 'sRgtDate'
                         , 'S_STRING16' , 'sRgtTime'
                         , 'S_STRING17' , 'sMedDate'
                         , 'S_STRING18' , 'sMedTime'
                         , 'S_STRING19' , 'sBodyTemp'
                         , 'S_STRING20' , 'sHeight'
                         , 'S_STRING21' , 'sWeight'
                         , 'S_STRING22' , 'sHeadCir'
                         , 'S_STRING23' , 'sWaistCir'
                         , 'S_STRING24' , 'sHipCir'
                         , 'S_STRING25' , 'sRemark'
                         , 'S_STRING26' , 'sPulse'
                         , 'S_STRING27' , 'sResp'
                         , 'S_STRING28' , 'sBldPreHi'
                         , 'S_STRING29' , 'sBldPreLo'
                         , 'S_STRING30' , 'sSpO2'
                         , 'S_STRING31' , 'sNeck'
                         , 'S_STRING32' , 'sDelDate'
                         , 'S_STRING33' , 'sEditId'
                          ])
      then
      begin
         if TpGetBdInf.RowCount = 0 then
         begin
            stb_Message.Panels[0].Text := '등록된 측정이력 자료가 없습니다.';

            Exit;
         end;

         with asg_BodyInfo do
         begin
            iRowCnt  := TpGetBdInf.RowCount;

            NowRow   := 0;

            for i := 0 to iRowCnt - 1 do
            begin
               //------------------------------------------------------------
               // 입원시 측정이력(C_MEDDATE is not null & C_MEDTIME is null)
               // 우측 Grid에 나오지 않도록 변경 @ 2014.07.08 LSH
               //    - 관련 S/R : GRPD1406003 (PD 남효경)
               //    - 입원환자 측정이력 D/B 저장은 가능함.
               //------------------------------------------------------------
               // 재원이후 측정한 이력이 표시되지 않는 현상으로 수정. - 2014.09.12 dkchoi
               {
               // 현재 Row-Index 감소
               if (NowRow > 0) then
                  NowRow := NowRow - 1
               else
                  NowRow := NowRow;
               }

               // 최종 RowCount도 감소
               //RowCount := RowCount - 1;

               //------------------------------------------------------------
               // [입원이력 포함] unChecked시 입원 측정이력 연동 제외 적용
               //          - 관련 S/R : ASPD1610013 (PD 신정희)
               //          - 2017.01.17 LSH
               //------------------------------------------------------------
               if  (
                     (not cbx_AdmIncluded.Checked) and
                     (Trim(TpGetBdInf.GetOutputDataS('sMedDate', i)) <> '') and
                     (Trim(TpGetBdInf.GetOutputDataS('sMedTime', i)) = '')
                   ) or
                   (
                     // 체중 및 신장 미측정 (모두 0)인 경우, 측정이력 List 표기 제외 @ 2016.09.26 LSH (PD 남효경)
                     (StrToFloatDef(TpGetBdInf.GetOutputDataS('sWeight', i), 0) = 0) and
                     (StrToFloatDef(TpGetBdInf.GetOutputDataS('sHeight', i), 0) = 0)
                   ) then
               begin
                  Continue;
               end;


               // 재원이후 측정한 이력이 표시되지 않는 현상으로 수정. - 2014.09.12 dkchoi
               If Trim(Cells[C_RGTDATE, FixedRows]) = '' Then
               Begin
                  RowCount := FixedRows + 1;
               End
               Else
               Begin
                  RowCount := RowCount + 1;
               End;

               NowRow := Rowcount - FixedRows - 1;


               Cells[C_CHECK,    NowRow+FixedRows] := '';
               Cells[C_RGTDATE,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sRgtDate', i);
               Cells[C_MEDDEPT,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sMedDept', i);
               Cells[C_YEAR,     NowRow+FixedRows] := GetTransAge('YEAR',    TpGetBdInf.GetOutputDataS('sRgtDate', i), varBirtdate);
               Cells[C_MONTH,    NowRow+FixedRows] := GetTransAge('MONTH',   TpGetBdInf.GetOutputDataS('sRgtDate', i), varBirtdate);
               Cells[C_TOTMONTH, NowRow+FixedRows] := GetTransAge('TOTMON',  TpGetBdInf.GetOutputDataS('sRgtDate', i), varBirtdate);
               Cells[C_WEIGHT,   NowRow+FixedRows] := GetTransData('WEIGHT', TpGetBdInf.GetOutputDataS('sWeight',  i), Cells[C_YEAR, NowRow+FixedRows]);
               Cells[C_HEIGHT,   NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sHeight',  i);
               Cells[C_HEADCIR,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sHeadCir', i);
               Cells[C_BMI,      NowRow+FixedRows] := CalcBmi(TpGetBdInf.GetOutputDataS('sHeight',  i), Cells[C_WEIGHT, NowRow+FixedRows]);
               Cells[C_REMARK,   NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sRemark',  i);
               Cells[C_RGTTIME,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sRgtTime', i);
               Cells[C_MEDDATE,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sMedDate', i);
               Cells[C_MEDTIME,  NowRow+FixedRows] := TpGetBdInf.GetOutputDataS('sMedTime', i);

               //------------------------------------------------------
               // Check 박스 Set.
               //------------------------------------------------------
               AddCheckBox(C_CHECK, NowRow+FixedRows, False, True);


               // 재원이후 측정한 이력이 표시되지 않는 현상으로 수정. - 2014.09.12 dkchoi
               {
               //------------------------------------------------------
               // 현재 Row-Index 증가
               //------------------------------------------------------
               Inc(NowRow);

               //------------------------------------------------------
               // RowCount 정리
               //------------------------------------------------------
               RowCount := NowRow + FixedRows;
               }
            end;

            stb_Message.Panels[0].Text := IntToStr(NowRow + 1) + '건의 측정이력이 [조회]되었습니다.';

         end;
      end
      else
      begin
         if TpGetBdInf.RowCount < 0 then
         begin
            stb_Message.Panels[0].Text := GetTxMsg;

            Exit;
         end;
      end;

   finally
      FreeAndNil(TpGetBdInf);

      Screen.Cursor := crDefault;
   end;
end;



//------------------------------------------------------------------------------
// [함수] 환아 나이 변환(년/개월/총개월수) 함수
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.GetTransAge(in_Flag,
                               in_FromDate,
                               in_BirtDate : String) : String;
var
   v_Year, v_Month, v_Day, i_Year, i_Month, i_Day, d_Year, d_Month, d_Day, d_TotMonth : Integer;
   tmpTransDay : Real;
begin

   // Log
   //Memo1.Lines.Add('Call GetTransAge : ' + in_Flag);

   //------------------------------------------------------
   // 반환값 초기화
   //------------------------------------------------------
   Result := '';

   //------------------------------------------------------
   // 날짜계산 변수 assign
   //------------------------------------------------------
   v_Year  := StrToInt(CopyByte(in_FromDate, 1, 4));   // YYYY-MM-DD
   v_Month := StrToInt(CopyByte(in_FromDate, 6, 2));
   v_Day   := StrToInt(CopyByte(in_FromDate, 9, 2));

   i_Year  := StrToInt(CopyByte(in_BirtDate, 1, 4));   // YYYYMMDD
   i_Month := StrToInt(CopyByte(in_BirtDate, 5, 2));
   i_Day   := StrToInt(CopyByte(in_BirtDate, 7, 2));

   //------------------------------------------------------
   // 년도 차이 계산
   //------------------------------------------------------
	d_Year := v_Year - i_Year;


   //------------------------------------------------------
   // 개월 차이 계산
   //------------------------------------------------------
	if (i_Month > v_Month) or
      (
         ( i_Month = v_Month ) and
         ( i_Day > v_Day )
      )  then
   begin
 	   d_Year  := d_Year - 1;
 	   v_Month := v_Month + 12;
   end;

   //------------------------------------------------------
 	// 일수 차이 계산
   //------------------------------------------------------
 	if i_Day <= v_Day then
   begin
 		d_Month := v_Month - i_Month;
      d_Day   := v_Day - i_Day;
   end
   else if i_Day > v_Day then
   begin
      d_Month := v_Month - i_Month - 1;
      d_Day   := v_Day + 30 - i_Day;
   end;

   //------------------------------------------------------
   // 총 개월수 계산
   //------------------------------------------------------
   if d_Year > 0 then
      d_TotMonth  := d_Year * 12 + d_Month
   else
      d_TotMonth  := d_Month;

   //------------------------------------------------------
   // 일수를 월 단위로 환산 (소수점 첫째자리)
   //------------------------------------------------------
   tmpTransDay := RTrunc_Pos(RRound_Pos(d_Day * 0.03, 1), 1);

   //------------------------------------------------------
   // 결과 Data 반환
   //------------------------------------------------------
 	if (in_Flag = 'YEAR') then
      Result := IntToStr(d_Year)
   else if (in_Flag = 'MONTH') then
      Result := IntToStr(d_Month)
   else if (in_Flag = 'TOTMON') then
      Result := FloatToStr(d_TotMonth + tmpTransDay);

end;



//------------------------------------------------------------------------------
// [함수] 신체측정 종류별 Data 단위 변환
//         - 신생아 성장발육곡선 입원이력 연동관련 환아 연령정보(in_YearInfo)
//           추가 @ 2017.01.18 LSH (ASPD1610013, PD 신정희)
//
// Date     : 2013.12.19
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.GetTransData(in_Flag,
                                in_DataVal,
                                in_YearInfo : String) : String;
var
   tmpTransVal : Real;
begin

   // Log
   //Memo1.Lines.Add('Call GetTransData : ' + in_Flag);

   //------------------------------------------------------
   // 반환값 초기화
   //------------------------------------------------------
   Result := '';

   //------------------------------------------------------
   // 유효값에 대한 변환 시작
   //------------------------------------------------------
   if (in_DataVal <> '') and
      ((in_DataVal > '0') or
       (CopyByte(in_DataVal, 1, 1) = '.')) then
   begin
      if (in_Flag = 'WEIGHT') then
      begin
         //------------------------------------------------------
         // [체중] Gram --> KiloGram으로 변환
         //
         //       - 신생아 입원이력 연동관련 체중 4자리(예: 1100 g)
         //         에서 3자리 (예: 980 g) 체크 전환 @ 2017.01.17 LSH (ASPD1610013, PD 신정희)
         //
         //       - 환아 연령정보가 2세초과 여부 Check 하여
         //         g <-> Kg 변환 적용 @ 2017.01.18 LSH
         //------------------------------------------------------
         if (PosByte('.', Trim(in_DataVal)) = 0) and
            (LengthByte(Trim(in_DataVal))  >= 3) then
         begin
            // 2세 미만 환아의 3자리 이상 몸무게만 gram 환산 적용 @ 2017.01.18 LSH
            if (StrToIntDef(in_YearInfo, 0) < 2) then
               tmpTransVal := StrToFloat(in_DataVal) * 0.001
            else
               tmpTransVal := StrToFloat(in_DataVal);
         end
         else
         begin
            if CopyByte(in_DataVal, 1, 1) = '.' then
            begin
               tmpTransVal := StrToFloat('0' + in_DataVal);
            end
            else
            begin
               tmpTransVal := StrToFloat(in_DataVal);
            end;
         end;
      end;
   end;

   //------------------------------------------------------
   // 결과 Data 반환
   //------------------------------------------------------
 	if (in_Flag = 'WEIGHT') then
      Result := FloatToStr(tmpTransVal);


end;



//------------------------------------------------------------------------------
// [함수] BMI 자동 계산
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.CalcBmi(in_Height,
                           in_Weight : String) : String;
var
   iHeight, iWeight, iResult : Extended;
begin
   // Log
   //Memo1.Lines.Add('Call CalcBmi');


   //------------------------------------------------------
   // 반환값 Initialize
   //------------------------------------------------------
   Result := '0';


   if (Not ChkReal(in_Weight)) or
      (Not ChkReal(in_Height)) then
   begin
      Exit;
   end;


   iHeight := StrToFloat(in_Height);
   iWeight := StrToFloat(in_Weight);

   //------------------------------------------------------
   // BMI(체질량지수) 계산
   //------------------------------------------------------
   if iHeight <> 0 then
      iResult :=  Round(( iWeight / ((iHeight/100) * (iHeight/100))) * 10) / 10 // Height를 cm --> m로 환산 후 계산 + 소수점 둘째자리 반올림
   else
      iResult := 0 ;


   //------------------------------------------------------
   // 반환값 처리
   //------------------------------------------------------
   Result := FormatFloat('#0.######',iResult);

end;


//------------------------------------------------------------------------------
// [조회] FlatButton onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_SearchClick(Sender: TObject);
begin
   // Log
   Memo1.Lines.Add('Call Search onClick');

   if (Trim(fed_PatNo.Text) = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('환자번호 입력후, Enter키를 눌러주세요.'),
                 '환자번호 입력 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   // 교정연령 환산보기 시 환자 기준정보(입원일 등) 메인화면 선택 필요 안내 Pop-up
   if (fcb_ConvertWks.Checked) and
      (FsMedDate = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('[교정연령] 환산보기는 메인화면(왼쪽상단)에 환자정보 선택 후 조회 가능합니다.'),
                 '교정연령 환산보기 방법 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   //------------------------------------------------------
   // 신체 측정내역 조회
   //------------------------------------------------------
   SelBodyInfo;

   //------------------------------------------------------
   // 환아 측정이력 Draw
   //------------------------------------------------------
   DrawPatSeries;

   //----------------------------------------------------------------
   // 백분위 패널 On시, 표준정규분포 백분위수 계산(Z-Score) Refresh
   //----------------------------------------------------------------
   if apn_NormsDist.Visible then
      CalcZScore2Grid;
end;


//------------------------------------------------------------------------------
// [조회] FlatEditBox onKeyDown Event Handler
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_PatNoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
   //---------------------------------------------------------------------------
   //  함수개요 : 오라클함수중 LPAD와 같은 기능을 한다.
   //             원하는 SIZE만큼 왼쪽을 원하는 문자열로 채운다.
   //  인 자 값 : 1.ASourceStr(String) : 대상문자열
   //             2.PadLen(String)     : 채울 size
   //             3.PadStr(String)     : 채울문자
   //  리턴구분 : LPAD한 String
   //  사 용 예 : A := LPAD('123',7,'0') --> '0000123'
   //  함수출처 : SQCOMCLS.pas
   //---------------------------------------------------------------------------
   function LPad(ASourceStr : String;
                 PadLen     : Integer;
                 PadStr     : String): String;
   var
      i : Integer;
      ResultStr : String;
   begin
      ResultStr := ASourceStr;

      for i := 1 to (PadLen - LengthByte(ASourceStr)) do
         ResultStr := CopyByte(PadStr,1,1) + ResultStr;

      Result := ResultStr;
   end;
begin
   // Log
   Memo1.Lines.Add('PatNo onKeyDown Event!');


   //------------------------------------------------------
   // Enter 입력시 검색
   //------------------------------------------------------
   if (Key <> 13) or (Trim(fed_PatNo.Text) = '') then
   begin
      Exit;
   end;


   fed_PatNo.Tag := 0;



   if (Key = 13) and
      (Trim(fed_PatNo.Text) <> '')then
   begin
      //-------------------------------------------------------------------
      // 메인화면에 선택된 환자정보와 현 Chart내 환자정보 일치여부
      //       - Flow-Sheet(EMR) 신생아 성장발육곡선 연동관련
      //         진료 메인 PATNO 관계없이 Chart 연동되도록 예외 처리 @ 2017.01.18 LSH (ASPD1610013, PD 신정희)
      //-------------------------------------------------------------------
      if (md_PatNo <> '') and
         (md_PatNo <> LPad(Trim(fed_PatNo.Text), 8, '0')) and
         (FindForm('MEI700F1') = nil) then
      begin
         MessageBox(Self.Handle,
                    PChar('진료 메인화면(좌측상단) 환자정보와 현 Chart내 환자정보가 일치하지 않습니다.' + #13#10 + #13#10 +
                          '환자정보를 재확인후, 입력 바랍니다.'),
                    '선택한 환자정보 불일치 알림',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;



      //------------------------------------------------------
      // 환자정보 조회
      //------------------------------------------------------
      if GetPatNameFlag(fed_PatNo, fed_PatNo, fed_PatName, fed_SexAge, '1') then
      begin
         //------------------------------------------------------
         // Flow-Sheet (EMR) 호출시 환자정보 변경 Disabled 적용
         //       - 관련 S/R : ASPD1610013 (PD 신정희)
         //       - 2017.01.18 LSH
         //------------------------------------------------------
         fed_PatNo.Enabled       := (FsFromForm <> 'FLOWSHEET');
         cbx_AdmIncluded.Enabled := (FsFromForm <> 'FLOWSHEET');

         //------------------------------------------------------
         // 만24개월 미만 환아는 Default 0~36개월 성장곡선 Chart
         //------------------------------------------------------
         if (PosByte('일',   Trim(fed_SexAge.Text)) > 0) or
            ((PosByte('개월', Trim(fed_SexAge.Text)) > 0) and
             (CopyByte(Trim(fed_SexAge.Text), 3, PosByte('개월', Trim(fed_SexAge.Text)) - 1) < '24')
            ) then
         begin
            // Log
            Memo1.Lines.Add('After GetPatName, 0~36개월 Tab Changed');

            ftc_Chart.ActiveTab := AT_ZERO2THIRTYSIX;
         end
         //------------------------------------------------------
         // 만24개월 이상 환아는 Default 2~18세 성장곡선 Chart
         //------------------------------------------------------
         else if (PosByte('Y',   Trim(fed_SexAge.Text)) > 0) or
                 (PosByte('세',  Trim(fed_SexAge.Text)) > 0) then
         begin
            // Log
            Memo1.Lines.Add('After GetPatName, 2~18세 Tab Changed');


            ftc_Chart.ActiveTab := AT_TWO2EIGHTTEEN;
         end
         else
         begin
            ftc_Chart.ActiveTab := AT_ZERO2THIRTYSIX;
         end;
      end;
   end;


   {
   //-------------------------------------------------------
   // 환자 기본정보 조회
   //-------------------------------------------------------
   GetBasPatNo(Trim(fed_PatNo.Text),
               varPatname,
               varResno1,
               varResno2,
               varBirtdate,
               varSex,
               varTelno1,
               varTelno2,
               varTelno3,
               varEmail,
               varZipcd,
               varAddress,
               varBldtype,
               varScanyn,
               varResno3,
               varZpaddress,
               varAddress2);



   //---------------------------------------------------------
   // 신체 측정내역 조회
   //---------------------------------------------------------
   SelBodyInfo;



   //---------------------------------------------------------
   // 환아 측정이력 Draw
   //---------------------------------------------------------
   DrawPatSeries;
   }

end;



//------------------------------------------------------------------------------
// [조회] FlatEditBox onChange Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_PatNoChange(Sender: TObject);
begin
   // Log
   Memo1.Lines.Add('PatNo onChanged !');

   if (fed_PatNo.Tag = 0) and
      (LengthByte(Trim(fed_PatNo.Text)) < 8) then
   begin
      fed_PatName.Text := '';
      fed_SexAge.Text  := '';
   end;
end;




//------------------------------------------------------------------------------
// [조회] FlatEditBox onEnter Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_PatNoEnter(Sender: TObject);
begin
   // Log
   Memo1.Lines.Add('PatNo onEnter !');

   fed_PatNo.Tag := 1;
end;



procedure TMDRC05F1.ftc_ChartTabChanged(Sender: TObject);
begin
   // 표준정규누적분포 백분위 계산관련 Tab-Changed시 해제 @ 2014.05.26 LSH
   if (fcb_Percent.Checked) then
      fcb_Percent.Checked := False;


   case ftc_Chart.ActiveTab of

      AT_NEONATAL :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 신생아');

            //------------------------------------------------------
            // 신생아 성장곡선 교정연령 환산보기 Check-Box Set-On.
            //          - 관련 S/R : ASPD1610013 (PD 신정희)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 20;
            fcb_ConvertWks.Left     := 531;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // 출생주수 초기화
            //------------------------------------------------------
            varBornWks := 0;
            varBornDay := 0;

            //------------------------------------------------------
            // 성별-주수별 Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('NEONATAL');

            //------------------------------------------------------
            // 성별-주수별 Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('NEONATAL',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));

            //------------------------------------------------------
            // 성별-주수별 항목별 표준성장지표 조회
            //------------------------------------------------------
            GetStandardMarking('7',
                               'NBINF',
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');

            // XE7 전환시 FormShow시 Axis 틀어지는 부분 개선위해 초기화 적용 @ 2016.01.27 LSH
            with chr_PdGrow do
            begin
               try
                  BottomAxis.Automatic            := False;
                  BottomAxis.Maximum              := 50;
                  BottomAxis.Minimum              := 22;
                  BottomAxis.Increment            := 2;
                  BottomAxis.StartPosition        := 0;
                  BottomAxis.EndPosition          := 100;
                  BottomAxis.LabelStyle           := talValue;
                  BottomAxis.MinorTicks.Visible   := False;
                  BottomAxis.MinorTickCount       := 2;
                  BottomAxis.MinorTickLength      := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  TopAxis.Automatic               := False;
                  TopAxis.Maximum                 := 50;
                  TopAxis.Minimum                 := 22;
                  TopAxis.Increment               := 2;
                  TopAxis.StartPosition           := 0;
                  TopAxis.EndPosition             := 100;
                  TopAxis.LabelStyle              := talValue;
                  TopAxis.MinorTicks.Visible      := False;
                  TopAxis.MinorTickCount          := 2;
                  TopAxis.MinorTickLength         := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  LeftAxis.Automatic              := False;
                  LeftAxis.Maximum                := 65;
                  LeftAxis.Minimum                := -25;
                  LeftAxis.Increment              := 5;
                  LeftAxis.StartPosition          := 0;
                  LeftAxis.EndPosition            := 100;
                  LeftAxis.LabelStyle             := talValue;
                  LeftAxis.MinorTicks.Visible     := True;
                  LeftAxis.MinorTickCount         := 4;
                  LeftAxis.MinorTickLength        := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               LeftAxis.Visible  := True;


               try
                  RightAxis.Automatic             := False;
                  RightAxis.Maximum               := 9;
                  RightAxis.Minimum               := 0;
                  RightAxis.Increment             := 0.5;
                  RightAxis.StartPosition         := 0;
                  RightAxis.EndPosition           := 100;
                  RightAxis.LabelStyle            := talValue;
                  RightAxis.MinorTicks.Visible    := True;
                  RightAxis.MinorTickCount        := 4;
                  RightAxis.MinorTickLength       := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;
            end;

         end;

      AT_ZERO2THIRTYSIX :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 0~36개월');

            //------------------------------------------------------
            // 0~36개월 성장곡선 교정연령 환산보기 Check-Box Set-Off.
            //          - 관련 S/R : ASPD1610013 (PD 신정희)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // 성별-월령별 Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('ZERO2THIRTYSIX');



            //------------------------------------------------------
            // 성별-월령별 Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('ZERO2THIRTYSIX',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));



            //------------------------------------------------------
            // 성별-월령별 항목별 표준성장지표 조회
            //------------------------------------------------------
            GetStandardMarking('1',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');

            // XE7 전환시 FormShow시 Axis 틀어지는 부분 개선위해 초기화 적용 @ 2016.01.27 LSH
            with chr_PdGrow do
            begin
               try
                  BottomAxis.Automatic            := False;
                  BottomAxis.Maximum              := 36;
                  BottomAxis.Minimum              := 0;
                  BottomAxis.Increment            := 3;
                  BottomAxis.StartPosition        := 0;
                  BottomAxis.EndPosition          := 100;
                  BottomAxis.LabelStyle           := talValue;
                  BottomAxis.MinorTicks.Visible   := False;
                  BottomAxis.MinorTickCount       := 2;
                  BottomAxis.MinorTickLength      := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  TopAxis.Automatic               := False;
                  TopAxis.Maximum                 := 36;
                  TopAxis.Minimum                 := 0;
                  TopAxis.Increment               := 3;
                  TopAxis.StartPosition           := 0;
                  TopAxis.EndPosition             := 100;
                  TopAxis.LabelStyle              := talValue;
                  TopAxis.MinorTicks.Visible      := False;
                  TopAxis.MinorTickCount          := 2;
                  TopAxis.MinorTickLength         := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  LeftAxis.Automatic              := False;
                  LeftAxis.Maximum                := 105;
                  LeftAxis.Minimum                := -10;
                  // xe7 버전 화면에서 좌표 값 맞지 않아 수정  1 => 5 - 2016.01.14 최영대
                  LeftAxis.Increment              := 5;
                  //LeftAxis.Increment              := 5;
                  LeftAxis.StartPosition          := 0;
                  LeftAxis.EndPosition            := 100;
                  LeftAxis.LabelStyle             := talValue;
                  LeftAxis.MinorTicks.Visible     := True;
                  LeftAxis.MinorTickCount         := 4;
                  LeftAxis.MinorTickLength        := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               LeftAxis.Visible  := True;


               try
                  RightAxis.Automatic             := False;
                  RightAxis.Maximum               := 25;
                  RightAxis.Minimum               := 2;
                  RightAxis.Increment             := 1;
                  RightAxis.StartPosition         := 0;
                  RightAxis.EndPosition           := 100;
                  RightAxis.LabelStyle            := talValue;
                  RightAxis.MinorTicks.Visible    := True;
                  RightAxis.MinorTickCount        := 4;
                  RightAxis.MinorTickLength       := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;
            end;

         end;

      AT_TWO2EIGHTTEEN :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 2~18세');

            //------------------------------------------------------
            // 2~18세 성장곡선 교정연령 환산보기 Check-Box Set-Off.
            //          - 관련 S/R : ASPD1610013 (PD 신정희)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // 성별-월령별 Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('TWO2EIGHTTEEN');


            //------------------------------------------------------
            // 성별-월령별 Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('TWO2EIGHTTEEN',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));



            //------------------------------------------------------
            // 성별-월령별 항목별 표준성장지표 조회
            //------------------------------------------------------
            GetStandardMarking('2',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');




            // XE7 전환시 FormShow시 Axis 틀어지는 부분 개선위해 초기화 적용 @ 2016.01.27 LSH
            with chr_PdGrow do
            begin
               try
                  BottomAxis.Automatic            := False;
                  BottomAxis.Maximum              := 18;
                  BottomAxis.Minimum              := 2;
                  BottomAxis.Increment            := 1;
                  BottomAxis.StartPosition        := 0;
                  BottomAxis.EndPosition          := 100;
                  BottomAxis.LabelStyle           := talValue;
                  BottomAxis.MinorTicks.Visible   := False;
                  BottomAxis.MinorTickCount       := 0;
                  BottomAxis.MinorTickLength      := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  TopAxis.Automatic               := False;
                  TopAxis.Maximum                 := 18;
                  TopAxis.Minimum                 := 2;
                  TopAxis.Increment               := 1;
                  TopAxis.StartPosition           := 0;
                  TopAxis.EndPosition             := 100;
                  TopAxis.LabelStyle              := talValue;
                  TopAxis.MinorTicks.Visible      := False;
                  TopAxis.MinorTickCount          := 0;
                  TopAxis.MinorTickLength         := 0;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               try
                  LeftAxis.Automatic              := False;
                  LeftAxis.Maximum                := 190;
                  LeftAxis.Minimum                := 60;
                  // xe7 버전 화면에서 좌표 값 맞지 않아 수정  0.1 => 5 - 2016.01.14 최영대
                   LeftAxis.Increment              := 5;
                  //LeftAxis.Increment              := 5;
                  LeftAxis.StartPosition          := 0;
                  LeftAxis.EndPosition            := 100;
                  LeftAxis.LabelStyle             := talValue;
                  LeftAxis.MinorTicks.Visible     := True;
                  LeftAxis.MinorTickCount         := 4;
                  LeftAxis.MinorTickLength        := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;


               LeftAxis.Visible  := True;


               try
                  RightAxis.Automatic             := False;
                  RightAxis.Maximum               := 135;
                  RightAxis.Minimum               := 5;
                  // xe7 버전 화면에서 좌표 값 맞지 않아 수정  0.1 => 5 - 2016.01.14 최영대
                  RightAxis.Increment             := 5;
                  RightAxis.StartPosition         := 0;
                  RightAxis.EndPosition           := 100;
                  RightAxis.LabelStyle            := talValue;
                  RightAxis.MinorTicks.Visible    := True;
                  RightAxis.MinorTickCount        := 4;
                  RightAxis.MinorTickLength       := 2;
               except
                  // Axis Max ~ Min 오류 방지
               end;
            end;

         end;

      AT_HEADCIR :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 두위');

            //------------------------------------------------------
            // 0~36개월 두위곡선 교정연령 환산보기 Check-Box Set-Off.
            //          - 관련 S/R : ASPD1610013 (PD 신정희)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;


            //------------------------------------------------------
            // 성별-월령별 Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('HEADCIR');

            //------------------------------------------------------
            // 성별-월령별 Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('HEADCIR',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));


            //------------------------------------------------------
            // 성별-월령별 항목별 두위 백분위 표준지표 조회
            //------------------------------------------------------
            GetStandardMarking('5',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               'HEADCIR');

         end;

      AT_BMI :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : BMI');

            //------------------------------------------------------
            // 2~18세 BMI곡선 교정연령 환산보기 Check-Box Set-Off.
            //          - 관련 S/R : ASPD1610013 (PD 신정희)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // 성별-연령별 Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('BMI');

            //------------------------------------------------------
            // 성별-연령별 Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('BMI',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));

            //------------------------------------------------------
            // 성별-연령별 항목별 BMI 백분위 표준지표 조회
            //------------------------------------------------------
            GetStandardMarking('6',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               'BMI');
         end;
   end;


   //-------------------------------------------------------
   // 환자 기본정보 조회
   //-------------------------------------------------------
   GetBasPatNo(Trim(fed_PatNo.Text),
               varPatname,
               varResno1,
               varResno2,
               varBirtdate,
               varSex,
               varTelno1,
               varTelno2,
               varTelno3,
               varEmail,
               varZipcd,
               varAddress,
               varBldtype,
               varScanyn,
               varResno3,
               varZpaddress,
               varAddress2);


   //---------------------------------------------------------
   // 신체 측정내역 조회
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // 환아 측정이력 Draw
   //---------------------------------------------------------
   DrawPatSeries;


end;


//------------------------------------------------------------------------------
// [수치보기] FlatCheckBox onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fcb_NumberClick(Sender: TObject);
begin
   //------------------------------------------------------------------
   // 환아 신체측정 백분위 도표 전환보기 @ 2014.05.22 LSH
   //------------------------------------------------------------------
   { -- Grid 표기가 아닌, Chart상 표기전환에 따른 주석 @ 2014.05.26 LSH
   if CheckDeptBtn('MDRC05_PER', md_DeptCd) then
   begin
      with chr_PdGrow do
      begin
         //------------------------------------------------------
         // Set Mark Style
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Style     := smsValue;
         series[C_SERIES_IDX_PATWGT].Marks.Style     := smsValue;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Style := smsValue;
         series[C_SERIES_IDX_PATBMI].Marks.Style     := smsValue;

         //------------------------------------------------------
         // Data 수치 표기
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATWGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := fcb_Number.Checked;
         series[C_SERIES_IDX_PATBMI].Marks.Visible     := fcb_Number.Checked;
      end;
   end
   else
   }
   begin
      if fcb_Number.Checked then
         fcb_Percent.Checked := False;

      with chr_PdGrow do
      begin
         //------------------------------------------------------
         // Set Mark Style
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Style     := smsValue;
         series[C_SERIES_IDX_PATWGT].Marks.Style     := smsValue;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Style := smsValue;
         series[C_SERIES_IDX_PATBMI].Marks.Style     := smsValue;

         //------------------------------------------------------
         // Data 수치 표기
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATWGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := fcb_Number.Checked;
         series[C_SERIES_IDX_PATBMI].Marks.Visible     := fcb_Number.Checked;
      end;
   end;
end;


//------------------------------------------------------------------------------
// [%보기] FlatCheckBox onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fcb_PercentClick(Sender: TObject);
begin
   //------------------------------------------------------------------
   // 환아 신체측정 백분위 도표 전환보기 @ 2014.05.22 LSH
   //------------------------------------------------------------------
   if CheckDeptBtn('MDRC05_PER', G_DeptCd) then
   begin
      if fcb_Percent.Checked then
         fcb_Number.Checked := False;

      // 백분위수 표기 조회
      fbt_SearchClick(Sender);


      // Grid 표기가 아닌, Chart상 표기전환에 따른 주석 @ 2014.05.26 LSH
      // Grid 표기 재요청에 따른 주석해제 @ 2014.07.08 LSH
      if (not fcb_Percent.Checked) then
      begin
         apn_NormsDist.Visible   := False;
      end
      else
      begin
         apn_NormsDist.Top       := 70;   //<-84;
         apn_NormsDist.Left      := 1110; //<-1114;
         apn_NormsDist.Visible   := True;

         //---------------------------------------------------------
         // 표준정규분포 백분위수 계산(Z-Score) 및 Grid 표기
         //---------------------------------------------------------
         CalcZScore2Grid;
      end;
   end
   else
   begin
      if fcb_Percent.Checked then
         fcb_Number.Checked := False;

      with chr_PdGrow do
      begin
         //------------------------------------------------------
         // Set Mark Style
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Style     := smsPercent;
         series[C_SERIES_IDX_PATWGT].Marks.Style     := smsPercent;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Style := smsPercent;
         series[C_SERIES_IDX_PATBMI].Marks.Style     := smsPercent;

         //------------------------------------------------------
         // Data % 표기
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Visible     := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATWGT].Marks.Visible     := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATBMI].Marks.Visible     := fcb_Percent.Checked;
      end;
   end;
end;


//------------------------------------------------------------------------------
// [생성] Form onCreate Event Handler
//
// Date     : 2013.11.20
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.FormCreate(Sender: TObject);
begin
   // Log
   Memo1.Lines.Add('== Create MainForm ==');

   //------------------------------------------------------
   // Initialize variables of Cross-Hair
   //------------------------------------------------------
   OldX           := -1;

   CrossHairColor := clYellow;
   CrossHairStyle := psSolid;

end;


//------------------------------------------------------------------------------
// [좌표보기] FlatCheckBox onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fcb_AxisLocateClick(Sender: TObject);
begin
   if (fcb_AxisLocate.Checked = True) then
      lb_AxisLocate.Visible   := True
   else if (fcb_AxisLocate.Checked = False) then
      lb_AxisLocate.Visible   := False;
end;



//------------------------------------------------------------------------------
// [측정추가/수정] FlatSpeedButton onClick Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fsbt_AddClick(Sender: TObject);
begin

   // Log
   Memo1.Lines.Add('Call 측정 Add onClick');

   if (Trim(fed_PatNo.Text) = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('환자번호 입력후, Enter키를 눌러주세요.'),
                 '환자번호 입력 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;



   stb_Message.Panels[0].Text := '';



   //-----------------------------------------------------------------
   // 수정 모드
   //-----------------------------------------------------------------
   if (asg_BodyInfo.Cells[C_CHECK, asg_BodyInfo.Row] = 'Y') then
   begin
      if (asg_BodyInfo.Cells[C_MEDDEPT, asg_BodyInfo.Row] <> CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))  then
      begin
         MessageBox(Self.Handle,
                    PChar('타과에서 측정한 Data는 수정이 불가능합니다.'),
                    '타 진료과 신체측정 수정제한 알림',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;

      if (asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row] = '') then
      begin
         MessageBox(Self.Handle,
                    PChar('본 OCS 화면에서 입력한 신체측정 Data만 수정이 가능합니다.'),
                    '타 시스템 신체측정 수정제한 알림',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;

      //-----------------------------------------------------------------
      // Caption
      //-----------------------------------------------------------------
      apn_PdBodAdd.Caption.Text := '신체측정 수정';


      with asg_PdBodAdd do
      begin
         ClearCols(1, ColCount);
         RowCount  := 8;

         Cells[1, 0] := asg_BodyInfo.Cells[C_RGTDATE, asg_BodyInfo.Row];
         Cells[1, 1] := CopyByte(asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row], 12, 8);
         Cells[1, 2] := Trim(fcb_MedDept.Text);
         Cells[1, 3] := asg_BodyInfo.Cells[C_WEIGHT, asg_BodyInfo.Row];
         Cells[1, 4] := asg_BodyInfo.Cells[C_HEIGHT, asg_BodyInfo.Row];
         Cells[1, 5] := asg_BodyInfo.Cells[C_HEADCIR,asg_BodyInfo.Row];
         Cells[1, 6] := asg_BodyInfo.Cells[C_REMARK, asg_BodyInfo.Row];
         Cells[1, 7] := '필수항목 입력후 이 칸에 등록버튼이 생성됨.';
      end;
   end
   else
   //-----------------------------------------------------------------
   // 신규 모드
   //-----------------------------------------------------------------
   begin
      // Caption
      apn_PdBodAdd.Caption.Text := '신체측정 신규추가';

      with asg_PdBodAdd do
      begin
         ClearCols(1, ColCount);
         RowCount  := 8;

         Cells[1, 0] := FormatDateTime('yyyy-mm-dd', Date);
         Cells[1, 1] := FormatDateTime('hh:nn:ss',   Now);
         Cells[1, 2] := Trim(fcb_MedDept.Text);
         Cells[1, 3] := '';
         Cells[1, 4] := '';
         Cells[1, 5] := '';
         Cells[1, 6] := '';
         Cells[1, 7] := '필수항목 입력후 이 칸에 등록버튼이 생성됨.';
      end;
   end;

   //-----------------------------------------------------------------
   // Location
   //-----------------------------------------------------------------
   apn_PdBodAdd.Top       := 307;
   apn_PdBodAdd.Left      := 471;
   apn_PdBodAdd.Collaps   := True;
   apn_PdBodAdd.Visible   := True;
   apn_PdBodAdd.Collaps   := False;

end;


//------------------------------------------------------------------------------
// [초기화] AdvStringGrid onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoClick(Sender: TObject);
begin
   stb_Message.Panels[0].Text := '';
end;


//------------------------------------------------------------------------------
// [초기화] Chart onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.chr_PdGrowClick(Sender: TObject);
begin
   apn_PdBodAdd.Collaps := True;
   apn_PdBodAdd.Visible := False;

   stb_Message.Panels[0].Text := '';

end;



//------------------------------------------------------------------------------
// [컬럼정렬] AdvStringGrid onGetAlignment Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
   //-----------------------------------------------------------------
   // Horizontal Alignment
   //-----------------------------------------------------------------
   if (ACol = 0) then
      HAlign := taCenter;

   //-----------------------------------------------------------------
   // Vertical Alignment
   //-----------------------------------------------------------------
   VAlign := vtaCenter;
end;



//------------------------------------------------------------------------------
// [컬럼Type] AdvStringGrid onGetEditorType Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
   with asg_PdBodAdd do
   begin
      if (ARow = 0) and (ACol = 1) then
            AEditor := edDateEdit;

      if (ARow = 1) and (ACol = 1) then
            AEditor := edTimeEdit;
   end;
end;


//------------------------------------------------------------------------------
// [LF방지] AdvStringGrid onKeyPress Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddKeyPress(Sender: TObject; var Key: Char);
begin
   //--------------------------------------------------------
   // 엔터 입력시, 다음 Cell 진행여부 분기
   //--------------------------------------------------------
   if (Key = #13) then
   begin
      if asg_PdBodAdd.Row = 6 then
         asg_PdBodAdd.Navigation.AdvanceOnEnter := False
      else
         asg_PdBodAdd.Navigation.AdvanceOnEnter := True;
   end;
end;


procedure TMDRC05F1.Button1Click(Sender: TObject);
var
   FForm : TForm;
begin
   // 권한체크(실습학생 출력 불가) 2012.11.05 wcw
   if CheckAuthority('PRINT', '', '', '', self.Name) = False then Exit;

   // 차트 및 측정정보 (전체 frame) 이미지 저장
   SaveComponentImg(Sender);


   // 프린트 상태 Check
   if (IsNotPrinterReady) then exit;



end;

//------------------------------------------------------------------------------
// [버튼생성] AdvStringGrid onEditingDone Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddEditingDone(Sender: TObject);
begin
   with asg_PdBodAdd do
   begin
      if (Trim(Cells[Col, 0]) <> '') and
         (Trim(Cells[Col, 1]) <> '') and
         (Trim(Cells[Col, 2]) <> '') and
         (
            (Trim(Cells[Col, 3]) <> '') or
            (Trim(Cells[Col, 4]) <> '') or
            (Trim(Cells[Col, 5]) <> '') or
            (Trim(Cells[Col, 6]) <> '')
         )
      then
      begin
         AddButton(Col,
                   7,
                   ColWidths[Col]-5,
                   20,
                   '위 측정이력을 등록하시려면 여기를 누르세요.',
                   haBeforeText,
                   vaCenter);
      end
      else
         RemoveButton(Col, 7);
   end;
end;


//------------------------------------------------------------------------------
// [수정권한] AdvStringGrid onCanEditCell Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
   //---------------------------------------------------------------------
   // 1. Check (Frame 항목은 제외)
   //---------------------------------------------------------------------
   if (ACol < 1) then
   begin
      Exit;
   end;

   //---------------------------------------------------------------------
   // 2. Edit 제한
   //---------------------------------------------------------------------
   if (PosByte('신규', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      if (ACol = 1)    and                                  // Frame 상단 제외
         (  (ARow = 2) or                                   // 진료과 정보
            (ARow = 7)                                      // 등록 Button
         ) then
      begin
         CanEdit := False;
      end
      else
         CanEdit := True;
   end
   else if (PosByte('수정', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      if (ACol = 1)    and                                  // Frame 상단 제외
         (  (ARow = 0) or                                   // 측정일자 정보
            (ARow = 1) or                                   // 측정시간 정보
            (ARow = 2) or                                   // 진료과   정보
            (ARow = 7)                                      // 등록 Button
         ) then
      begin
         CanEdit := False;
      end
      else
         CanEdit := True;

   end;
end;


//------------------------------------------------------------------------------
// [저장] AdvStrinGrid onButtonClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddButtonClick(Sender: TObject; ACol,
  ARow: Integer);
var
   iChoice     : Integer;
   TpPdBodAdd  : TTpSvc;
   j, iCnt     : Integer;
   tmpMedDate, tmpMedTime  : String;
   sRgtDate, sRgtTime : String;
   vType,
   vPatNo,
   vMedDept,
   vMedTime,
   vRgtDate,
   vRgtTime,
   vMedDate,
   vWeight,
   vHeight,
   vHeadCir,
   vRemark,
   vDelDate,
   vEditId,
   vEditIp : Variant;
begin

   // Log
   Memo1.Lines.Add('Call 측정이력 onButtonClick');

   //-------------------------------------------------------------------
   // Check
   //    - 임상실습학생 OCS 접근권한(저장/수정/삭제/출력/엑셀) 제한
   //-------------------------------------------------------------------
   if CheckAuthority('SAVE', '', '', '', self.Name) = False then Exit;




   //-------------------------------------------------------------------
   // 환자 진료일자(또는 입원일자) 정보 assign (옵션)
   //-------------------------------------------------------------------
   if (PosByte('신규', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      // 외래 접수이력(MEDDATE & MEDTIME) 또는 입원이력(ADMDATE) 물고있는 환자인 경우
      if (FsMedDate <> '') then
      begin
         tmpMedDate := FsMedDate;      // EMR 연계 및 타 시스템 연동위한 Global var. 전환 @ 2017.01.17 LSH
         tmpMedTime := FsMedTime;      // EMR 연계 및 타 시스템 연동위한 Global var. 전환 @ 2017.01.17 LSH
      end
      // 외래 접수이력 또는 입원이력 없이 [처방결과조회] - [성장발육곡선 Chart] 통해 측정이력 등록시
      // 측정일을 [외래 진료일]로, 측정시간을 [외래 진료시간]으로 등록/적용 @ 2017.02.24 LSH (PD 남효경 요청)
      else
      begin
         tmpMedDate := asg_PdBodAdd.Cells[1, 0];
         tmpMedTime := asg_PdBodAdd.Cells[1, 0] + ' ' + asg_PdBodAdd.Cells[1, 1];
      end;
   end
   else if (PosByte('수정', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      for j := 1 to asg_BodyInfo.RowCount - 1 do
      begin
         if (asg_BodyInfo.Cells[C_CHECK, j] = 'Y') then
         begin
            tmpMedDate := asg_BodyInfo.Cells[C_MEDDATE, j];
            tmpMedTime := asg_BodyInfo.Cells[C_MEDTIME, j]
         end;
      end;
   end
   else
   begin
      tmpMedDate := '';
      tmpMedTime := '';
   end;




   with asg_PdBodAdd do
   begin
      if (Trim(Cells[Col, 0]) = '') or
         (Trim(Cells[Col, 1]) = '') or
         (Trim(Cells[Col, 2]) = '')
      then
      begin
         MessageBox(Self.Handle,
                    PChar('측정일자/시간/진료과 항목은 필수입력 항목입니다.'),
                    '신체측정 이력 등록전 필수입력 확인',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;
   end;




   //-------------------------------------------------------------------
   // 최종 등록 여부 확인
   //-------------------------------------------------------------------
   iChoice := MessageBox(Self.Handle,
                         PChar('작성하신 측정이력을 등록하시겠습니까?'),
                         '신체측정 등록 확인',
                         MB_YESNO + MB_ICONQUESTION);


   if iChoice = IDNO then Exit;


   iCnt := 0;



   //-------------------------------------------------------------------
   // 측정일자/측정시간 Assign
   //-------------------------------------------------------------------
   sRgtDate := asg_PdBodAdd.Cells[1, 0];
   sRgtTime := asg_PdBodAdd.Cells[1, 0] + ' ' + asg_PdBodAdd.Cells[1, 1];





   //-------------------------------------------------------------------
   // 2. Create Variables
   //-------------------------------------------------------------------
   with asg_PdBodAdd do
   begin
      for j := ColCount - 1 to ColCount -1 do
      begin
         //------------------------------------------------------------------
         // Append Variables
         //------------------------------------------------------------------
         AppendVariant(vType,       '1'        );
         AppendVariant(vPatNo,      Trim(fed_PatNo.Text));
         AppendVariant(vMedDept,    CopyByte(Cells[j, 2], 1, PosByte('[', Cells[j, 2]) - 2));
         AppendVariant(vRgtDate,    sRgtDate   );
         AppendVariant(vRgtTime,    sRgtTime   );
         AppendVariant(vMedDate,    tmpMedDate );
         AppendVariant(vMedTime,    tmpMedTime );
         AppendVariant(vWeight,     Cells[j, 3]);
         AppendVariant(vHeight,     Cells[j, 4]);
         AppendVariant(vHeadCir,    Cells[j, 5]);
         AppendVariant(vRemark,     Cells[j, 6]);
         AppendVariant(vDelDate,    ''         );
         AppendVariant(vEditId,     G_UserId  );
         AppendVariant(vEditIp,     G_UserIp   );

         Inc(iCnt);
      end;
   end;


   if iCnt <= 0 then
      Exit;


   //-------------------------------------------------------------------
   // 3. Insert by TpSvc
   //-------------------------------------------------------------------
   TpPdBodAdd := TTpSvc.Create;
   TpPdBodAdd.Init(Self);


   Screen.Cursor := crHourGlass;


   try
      if TpPdBodAdd.PutSvc('MD_PDBOD_M1',
                          ['S_TYPE1'   , vType
                         , 'S_STRING1' , vPatNo            // 환자번호
                         , 'S_STRING2' , vMedDept          // 진료과
                         , 'S_STRING3' , vRgtDate          // 측정일자
                         , 'S_STRING4' , vRgtTime          // 측정일시
                         , 'S_STRING5' , vMedDate          // 진료(입원)일자
                         , 'S_STRING6' , vMedTime          // 진료(입원)일자
                         , 'S_STRING8' , vHeight           // 신장
                         , 'S_STRING9' , vWeight           // 체중
                         , 'S_STRING10', vHeadCir          // 두위
                         , 'S_STRING13', vRemark           // 특기사항
                         , 'S_STRING20', vDelDate          // 삭제일자
                         , 'S_STRING21', vEditId           // 수정자 ID
                         , 'S_STRING22', vEditIp           // 수정자 IP
                         ] ) then
      begin
         stb_Message.Panels[0].Text := '측정이력이 정상적으로 [등록]되었습니다.';
      end
      else
      begin
         ShowMessage(GetTxMsg);
      end;





   finally
      FreeAndNil(TpPdBodAdd);

      apn_PdBodAdd.Collaps := True;
      apn_PdBodAdd.Visible := False;

      Screen.Cursor  := crDefault;
   end;


   //---------------------------------------------------------
   // 4. 측정이력 재조회
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // 5. 환아 측정이력 Draw
   //---------------------------------------------------------
   DrawPatSeries;

end;



//------------------------------------------------------------------------------
// [수정권한] AdvStringGrid onCanEditCell Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
   //---------------------------------------------------------------------
   // 1. Check (Frame 항목은 제외)
   //---------------------------------------------------------------------
   if (ARow = 0) then
   begin
      Exit;
   end;

   //---------------------------------------------------------------------
   // 2. Edit 제한
   //---------------------------------------------------------------------
   if (ARow > 0)    and                                  // Frame 상단 제외
      (ACol = C_CHECK)                                   // Check-Box Button
   then
   begin
      CanEdit := True;
   end
   else
      CanEdit := False;
end;


//------------------------------------------------------------------------------
// [차트Draw] 환아 측정이력 Charting 표기
//
// Date     : 2013.11.26
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.DrawPatSeries;
var
   i, j : Integer;
begin
   // Log
   Memo1.Lines.Add('Call DrawPatSeries : ' + IsAgeFlag);


   {$IFDEF VER130}
   with chr_PdGrow.SeriesList do
   {$ELSE}
   with chr_PdGrow do
   {$ENDIF}
   begin

      if (IsAgeFlag = 'NEONATAL')       or
         (IsAgeFlag = 'ZERO2THIRTYSIX') or
         (IsAgeFlag = 'TWO2EIGHTTEEN')  then
      begin


         Series[C_SERIES_IDX_PATWGT].Clear;
         Series[C_SERIES_IDX_PATHGT].Clear;
         Series[C_SERIES_IDX_PATHEADCIR].Clear;
         Series[C_SERIES_IDX_PATBMI].Clear;



         if (IsAgeFlag = 'NEONATAL') and
            ((varBornWks = 0)         or
             (Trim(fed_PatNo.Text) = '')) then
         begin
            //------------------------------------------------------------------
            // 신생아 간호정보조사지 출생주수 정보 조회
            // 본원 출생이력 없으면, 출생주수 확인 Panel-On.
            //------------------------------------------------------------------
            if (not GetNeoBornWks(Trim(fed_PatNo.Text),
                                  varBornWks,
                                  varBornDay)) then
            begin
               apn_NeoBornWks.Top       := 307;
               apn_NeoBornWks.Left      := 431;
               apn_NeoBornWks.Collaps   := True;
               apn_NeoBornWks.Visible   := True;
               apn_NeoBornWks.Collaps   := False;

               fed_Wks.Text := '';
               fed_Day.Text := '';

               try
                  fed_Wks.SetFocus;

               except
                  // Invisible Comp. Focus 오류 방지
               end;

               Exit;
            end;
         end;



         for i := C_WEIGHT to C_HEADCIR do
         begin

            with asg_BodyInfo do
            begin
               for j := RowCount - 1 downto 1 do
               begin
                  //------------------------------------------------------------
                  // 입원시 측정이력(C_MEDDATE is not null & C_MEDTIME is null)
                  // Charting에 나오지 않도록 변경 @ 2014.02.07 LSH
                  //    - 구로 PD 남효경 요청
                  //------------------------------------------------------------
                  if (Cells[C_MEDDATE, j] <> '') and
                     (Cells[C_MEDTIME, j] = '') then
                  begin
                     //---------------------------------------------------------
                     // [입원이력 포함] unChecked시 입원 측정이력 연동 제외 적용
                     //          - 관련 S/R : ASPD1610013 (PD 신정희)
                     //          - 2017.01.17 LSH
                     //---------------------------------------------------------
                     if (not cbx_AdmIncluded.Checked) then
                     begin
                        Continue;
                     end;
                  end;


                  if (IsAgeFlag = 'NEONATAL') then
                  begin
                     if (i = C_HEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [신장] 환아 측정이력
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);


                        // [신장] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [신장] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;
                     end;


                     if (i = C_WEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [체중] 환아 측정이력
                        Series[C_SERIES_IDX_PATWGT].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [체중] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [체중] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;
                     end;


                     if (i = C_HEADCIR) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [두위] 환아 측정이력
                        Series[C_SERIES_IDX_PATHEADCIR].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                              StrToFloat(Cells[C_HEADCIR, j]),
                                                              '',
                                                              chr_PdGrow.Series[C_SERIES_IDX_PATHEADCIR].SeriesColor);

                        // [두위] Vertical Axis
                        Series[C_SERIES_IDX_PATHEADCIR].VertAxis  := aLeftAxis;

                        // [두위] Horizontal Axis
                        Series[C_SERIES_IDX_PATHEADCIR].HorizAxis := aBothHorizAxis;
                     end;
                  end
                  else if (IsAgeFlag = 'ZERO2THIRTYSIX') then
                  begin
                     if (i = C_HEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [신장] 환아 측정이력
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);

                        // [신장] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [신장] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // 백분위수 계산 및 Text Drawing @ 2014.05.26 LSH
                        //------------------------------------------------------
                        if (fcb_Percent.Checked) then
                           DrawNormsBanner(Series[C_SERIES_IDX_PATHGT],
                                           'HEIGHT',
                                           StrToFloat(Cells[C_YEAR,j]),
                                           StrToFloat(Cells[C_MONTH,j]),
                                           StrToFloat(Cells[C_TOTMONTH,j]),
                                           StrToFloat(Cells[C_HEIGHT, j]),
                                           chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);

                     end;

                     if (i = C_WEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [체중] 환아 측정이력
                        Series[C_SERIES_IDX_PATWGT].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [체중] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [체중] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // 백분위수 계산 및 Text Drawing @ 2014.05.26 LSH
                        //------------------------------------------------------
                        if (fcb_Percent.Checked) then
                           DrawNormsBanner(Series[C_SERIES_IDX_PATWGT],
                                           'WEIGHT',
                                           StrToFloat(Cells[C_YEAR,j]),
                                           StrToFloat(Cells[C_MONTH,j]),
                                           StrToFloat(Cells[C_TOTMONTH,j]),
                                           StrToFloat(Cells[C_WEIGHT, j]),
                                           chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                     end;
                  end
                  else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
                  begin
                     //---------------------------------------------------------
                     // 2~18세 성장발육 Chart 대상중 18세 초과 측정정보 백분위 표기 제외
                     //          - 요청 : PD 남효경
                     //          - D/B에는 18세까지 밖에 LMS 정보 없으므로, Skip.
                     //          - 2016.09.08 LSH
                     //
                     // 신생아 및 소아 입원 측정이력 연동관련 2~18세 아닌경우, 백분위 표기 제한
                     //          - 관련 S/R : ASPD1610013 (PD 신정희)
                     //          - 2017.01.17 LSH
                     //---------------------------------------------------------
                     {
                     if
                        (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and
                        (StrToIntDef(Cells[C_MONTH, j], 0) >  0)  then
                     }
                     if (
                           (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and   // 만 18세 초과이거나
                           (StrToIntDef(Cells[C_MONTH, j], 0) >  0)
                        ) or
                        (StrToIntDef(Cells[C_YEAR, j], 0) <  2) then       // 만 2세 미만인 경우, 표기 제한
                     begin
                        Continue;
                     end;

                     if (i = C_HEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [신장] 환아 측정이력
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(Cells[C_TOTMONTH, j]) / 12,
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);


                        // [신장] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [신장] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // 백분위수 계산 및 Text Drawing @ 2014.05.26 LSH
                        //------------------------------------------------------
                        if (fcb_Percent.Checked) then
                           DrawNormsBanner(Series[C_SERIES_IDX_PATHGT],
                                           'HEIGHT',
                                           StrToFloat(Cells[C_YEAR,j]),
                                           StrToFloat(Cells[C_MONTH,j]),
                                           StrToFloat(Cells[C_TOTMONTH,j]) / 12,
                                           StrToFloat(Cells[C_HEIGHT, j]),
                                           chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);
                     end;


                     if (i = C_WEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [체중] 환아 측정이력
                        Series[C_SERIES_IDX_PATWGT].AddXy((StrToFloat(Cells[C_TOTMONTH, j]) / 12),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [체중] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [체중] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // 백분위수 계산 및 Text Drawing @ 2014.05.26 LSH
                        //------------------------------------------------------
                        if (fcb_Percent.Checked) then
                           DrawNormsBanner(Series[C_SERIES_IDX_PATWGT],
                                           'WEIGHT',
                                           StrToFloat(Cells[C_YEAR,j]),
                                           StrToFloat(Cells[C_MONTH,j]),
                                           StrToFloat(Cells[C_TOTMONTH,j]) / 12,
                                           StrToFloat(Cells[C_WEIGHT, j]),
                                           chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);
                     end;

                  end;
               end;
            end;
         end;
      end
      else if (IsAgeFlag = 'HEADCIR') or
              (IsAgeFlag = 'BMI')     then
      begin
         Series[C_SERIES_IDX_PATWGT].Clear;
         Series[C_SERIES_IDX_PATHGT].Clear;
         Series[C_SERIES_IDX_PATHEADCIR].Clear;
         Series[C_SERIES_IDX_PATBMI].Clear;


         for i := C_HEADCIR to C_BMI do
         begin

            with asg_BodyInfo do
            begin
               for j := 1 to RowCount - 1 do
               begin
                  if (Trim(Cells[i, j]) <> '')  and
                     (Trim(Cells[i, j]) <> '0') and
                     (Trim(Cells[i, j]) <> '00.0') then
                  begin
                     if (IsAgeFlag = 'HEADCIR') then
                     begin
                        // [두위] 환아 측정이력
                        Series[C_SERIES_IDX_PATHEADCIR].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                              StrToFloat(Cells[C_HEADCIR, j]),
                                                              '',
                                                              chr_PdGrow.Series[C_SERIES_IDX_PATHEADCIR].SeriesColor);

                        // [두위] Vertical Axis
                        Series[C_SERIES_IDX_PATHEADCIR].VertAxis  := aRightAxis;

                        // [두위] Horizontal Axis
                        Series[C_SERIES_IDX_PATHEADCIR].HorizAxis := aBothHorizAxis;
                     end
                     else if (IsAgeFlag = 'BMI') then
                     begin
                        //------------------------------------------------------
                        // 2~18세 성장발육 Chart 대상중 18세 초과 측정정보 백분위 표기 제외
                        //          - 요청 : PD 남효경
                        //          - D/B에는 18세까지 밖에 LMS 정보 없으므로, Skip.
                        //          - 2016.09.08 LSH
                        //
                        // 신생아 및 소아 입원 측정이력 연동관련 2~18세 아닌경우, 백분위 표기 제한
                        //          - 관련 S/R : ASPD1610013 (PD 신정희)
                        //          - 2017.01.17 LSH
                        //------------------------------------------------------
                        {
                        if
                           (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and
                           (StrToIntDef(Cells[C_MONTH, j], 0) >  0)  then
                        }

                        if (
                              (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and   // 만 18세 초과이거나
                              (StrToIntDef(Cells[C_MONTH, j], 0) >  0)
                           ) or
                           (StrToIntDef(Cells[C_YEAR, j], 0) <  2) then       // 만 2세 미만인 경우, 표기 제한
                        begin
                           Continue;
                        end;


                        // [BMI] 환아 측정이력
                        Series[C_SERIES_IDX_PATBMI].AddXy(StrToFloat(Cells[C_TOTMONTH, j]) / 12,
                                                          StrToFloat(Cells[C_BMI, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATBMI].SeriesColor);

                        // Log
                        Memo1.Lines.Add('BMI Drawing 좌표 : ' + FloatToStr(StrToFloat(Cells[C_TOTMONTH, j]) / 12) + ' , ' + Cells[C_BMI, j]);

                        // [BMI] Vertical Axis
                        Series[C_SERIES_IDX_PATBMI].VertAxis  := aRightAxis;

                        // [BMI] Horizontal Axis
                        Series[C_SERIES_IDX_PATBMI].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // 백분위수 계산 및 Text Drawing @ 2014.05.26 LSH
                        //------------------------------------------------------
                        if (fcb_Percent.Checked) then
                           DrawNormsBanner(Series[C_SERIES_IDX_PATBMI],
                                           'BMI',
                                           StrToFloat(Cells[C_YEAR,j]),
                                           StrToFloat(Cells[C_MONTH,j]),
                                           StrToFloat(Cells[C_TOTMONTH,j]) / 12,
                                           StrToFloat(Cells[C_BMI, j]),
                                           chr_PdGrow.Series[C_SERIES_IDX_PATBMI].SeriesColor);
                     end

                  end;
               end;
            end;
         end;
      end;
   end;


   //-------------------------------------------------------------------
   // 신생아 출생주수 Line Drawing
   //-------------------------------------------------------------------
   if (IsAgeFlag = 'NEONATAL') then
      NeoBornAfterDraw;


   //-------------------------------------------------------------------
   // Data 수치 표기
   //-------------------------------------------------------------------

   chr_PdGrow.series[C_SERIES_IDX_PATHGT].Marks.Visible     := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATWGT].Marks.Visible     := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATBMI].Marks.Visible     := (fcb_Number.Checked);
end;


//------------------------------------------------------------------------------
// [삭제] FlatButton onClick Event Handler
//
// Date     : 2013.11.26
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_DeleteClick(Sender: TObject);
var
   iChoice     : Integer;
   TpPdBodDel  : TTpSvc;
   i, iCnt     : Integer;
   vType,
   vPatNo,
   vMedDept,
   vRgtDate,
   vRgtTime,
   vDelDate,
   vEditId,
   vEditIp : Variant;
begin
   // Log
   Memo1.Lines.Add('Call 측정이력 Del onClick');

   //-------------------------------------------------------------------
   // 1-1. Check
   //    - 임상실습학생 OCS 접근권한(저장/수정/삭제/출력/엑셀) 제한
   //-------------------------------------------------------------------
   if CheckAuthority('SAVE', '', '', '', self.Name) = False then Exit;




   if (Trim(fed_PatNo.Text) = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('환자번호 입력후, Enter키를 눌러주세요.'),
                 '환자번호 입력 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;


   //-----------------------------------------------------------------
   // 삭제 모드 유효성 Check
   //-----------------------------------------------------------------
   if (asg_BodyInfo.Cells[C_CHECK,   asg_BodyInfo.Row] = 'Y') and
      (asg_BodyInfo.Cells[C_MEDDEPT, asg_BodyInfo.Row] <> CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))  then
   begin
      MessageBox(Self.Handle,
                 PChar('타과에서 측정한 Data는 삭제가 불가능합니다.'),
                 '타 진료과 신체측정 삭제제한 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   if (asg_BodyInfo.Cells[C_CHECK,   asg_BodyInfo.Row] = 'Y') and
      (asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row] = '')  then
   begin
      MessageBox(Self.Handle,
                 PChar('본 OCS 화면에서 입력한 신체측정 Data만 삭제가 가능합니다.'),
                 '타 시스템 신체측정 삭제제한 알림',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;


   //-----------------------------------------------------------------
   // 최종 등록 여부 확인
   //-----------------------------------------------------------------
   iChoice := MessageBox(Self.Handle,
                         PChar('선택하신 측정이력을 삭제하시겠습니까?'),
                         '신체측정 삭제 확인',
                         MB_YESNO + MB_ICONQUESTION);


   if iChoice = IDNO then Exit;



   iCnt := 0;


   //-------------------------------------------------------------------
   // 2. Create Variables
   //-------------------------------------------------------------------
   with asg_BodyInfo do
   begin
      for i := 1 to RowCount -1 do
      begin
         if (Cells[C_CHECK, i] = 'Y') and
            (asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row] <> '') then
         begin
            //------------------------------------------------------------------
            // Append Variables
            //------------------------------------------------------------------
            AppendVariant(vType,       '1'        );
            AppendVariant(vPatNo,      Trim(fed_PatNo.Text));
            AppendVariant(vMedDept,    Cells[C_MEDDEPT, i]);
            AppendVariant(vRgtDate,    Cells[C_RGTDATE, i]);
            AppendVariant(vRgtTime,    Cells[C_RGTTIME, i]);
            AppendVariant(vDelDate,    FormatDateTime('yyyy-mm-dd', DATE));
            AppendVariant(vEditId,     G_UserId  );
            AppendVariant(vEditIp,     G_UserIp   );

            Inc(iCnt);
         end;
      end;
   end;


   if iCnt <= 0 then
      Exit;


   //-------------------------------------------------------------------
   // 3. Insert by TpSvc
   //-------------------------------------------------------------------
   TpPdBodDel := TTpSvc.Create;
   TpPdBodDel.Init(Self);


   Screen.Cursor := crHourGlass;




   try
      if TpPdBodDel.PutSvc('MD_PDBOD_M1',
                          ['S_TYPE1'   , vType
                         , 'S_STRING1' , vPatNo            // 환자번호
                         , 'S_STRING2' , vMedDept          // 진료과
                         , 'S_STRING3' , vRgtDate          // 측정일자
                         , 'S_STRING4' , vRgtTime          // 측정일시
                         , 'S_STRING20', vDelDate          // 삭제일자
                         , 'S_STRING21', vEditId           // 수정자 ID
                         , 'S_STRING22', vEditIp           // 수정자 IP
                         ] ) then
      begin
         stb_Message.Panels[0].Text := '측정이력이 정상적으로 [삭제]되었습니다.';
      end
      else
      begin
         ShowMessage(GetTxMsg);
      end;





   finally
      FreeAndNil(TpPdBodDel);

      apn_PdBodAdd.Collaps := True;
      apn_PdBodAdd.Visible := False;

      Screen.Cursor  := crDefault;
   end;




   //---------------------------------------------------------
   // 4. 측정이력 재조회
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // 5. 환아 측정이력 Draw
   //---------------------------------------------------------
   DrawPatSeries;

end;

//------------------------------------------------------------------------------
// [이미지View] FlatButton onClick Event Handler
//
// Date     : 2013.11.27
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_NeoChartClick(Sender: TObject);
var
   FForm : TForm;
begin
   //---------------------------------------------------------
   // 진료 FTP 이미지 뷰어 (BPL) 호출
   //---------------------------------------------------------
   FForm := BplFormCreate('MDN990F1');


   //---------------------------------------------------------
   // 신생아용 (2008 Fenton WHO 표준)
   //---------------------------------------------------------
   SetBplStrProp(FForm.Name, 'Prop_FromForm', 'MDN635F2');     // 신생아 간호정보조사지 호출 모드
   SetBplStrProp(FForm.Name, 'Prop_ImgName' , 'FENTON2008');   // FTP 이미지 이름

   MComFormShow(FForm);
end;



//------------------------------------------------------------------------------
// [종료] FlatButton onClick Event Handler
//
// Date     : 2013.11.27
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_CloseClick(Sender: TObject);
begin
   Close;
end;


//------------------------------------------------------------------------------
// [이력수정] AdvStringGrid onDblClick Event Handler
//
// Date     : 2013.11.27
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoDblClick(Sender: TObject);
begin
   if (asg_BodyInfo.Cells[C_CHECK, asg_BodyInfo.Row] = 'Y') then
      fsbt_AddClick(Sender);
end;


//------------------------------------------------------------------------------
// [Hint표기] AdvStringGrid onMouseMove Event Handler
//
// Date     : 2013.11.28
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   NowCol, NowRow : Integer;
begin
   //-----------------------------------------------------------------
   // 현 Mouse 포인터 좌표 받아오기
   //-----------------------------------------------------------------
   asg_BodyInfo.MouseToCell(X,
                            Y,
                            NowCol,
                            NowRow);

   //-----------------------------------------------------------------
   // 특기사항 Hint
   //-----------------------------------------------------------------
   if NowCol = C_REMARK then
   begin
      asg_BodyInfo.Hint     := asg_BodyInfo.Cells[C_REMARK, NowRow];
      asg_BodyInfo.ShowHint := True;
   end
   else
      asg_BodyInfo.ShowHint := False;
end;




//------------------------------------------------------------------------------
// NeoNatal 재태주령 계산 함수
//    - 출생일자, 기준 기록일자를 받아서 재태주령을 계산.
//    - 신생아 입원 측정이력 연동관련 교정주령 계산로직 추가 @ 2017.01.17 LSH (ASPD1610013, PD 신정희)
//
// Author : Lee, Se-Ha
// Date   : 2013.12.05
//------------------------------------------------------------------------------
function TMDRC05F1.CalcNeoWks(in_BornDate,
                              in_RgtDate : String) : String;
var
   iBornYear, iBornMon, iBornDay, iNowDay, iNowMon, iNowYear : Integer;
   iBornCnt , iNowCnt, diffDay, iTmpTransWks, iTmpTransDay : Integer;
   tmpResult, iTmpTransDay2 : Real;
   Month     : array[1..13] of Integer;

   iDiffDay1, iDiffDay2, iTmpPeriod, iAddingWks, iAddingDay, iAddedWks, iAddedDay : Integer;      // 교정주수 계산위한 var. 추가 @ 2017.01.17 LSH
   dDiffDayFloat : Double;

   fixed_BornDate : String;
   trans_BornDate, trans_RgtDate : TDateTime;
begin
   //-----------------------------------------------------------------
   // 초기 Return Value Null 처리
   //-----------------------------------------------------------------
   diffDay  := 0;

   Result   := IntToStr(diffDay);


   //-----------------------------------------------------------------
   // 월별 누적일수
   //-----------------------------------------------------------------
   Month[1]  := 0;
   Month[2]  := 31;
   Month[3]  := 59;
   Month[4]  := 90;
   Month[5]  := 120;
   Month[6]  := 151;
   Month[7]  := 181;
   Month[8]  := 212;
   Month[9]  := 243;
   Month[10] := 273;
   Month[11] := 304;
   Month[12] := 334;
   Month[13] := 365;

   //-----------------------------------------------------------------
   // 시작일자, 종료일자 변수 assign
   //-----------------------------------------------------------------
   iBornYear := StrToInt(CopyByte(in_BornDate, 1, 4));
   iBornMon  := StrToInt(CopyByte(in_BornDate, 5, 2));
   iBornDay  := StrToInt(CopyByte(in_BornDate, 7, 2));
   iNowYear  := StrToInt(CopyByte(in_RgtDate,  1, 4));
   iNowMon   := StrToInt(CopyByte(in_RgtDate,  5, 2));
   iNowDay   := StrToInt(CopyByte(in_RgtDate,  7, 2));


   //------------------------------------
   // 1. 출생년도 = 기록년도
   //------------------------------------
   if (iBornYear = iNowYear) then
   begin
      // 1-1. 출생월 = 기록월
      if (iBornMon = iNowMon) then
      begin
         iBornCnt := iBornDay;
         iNowCnt  := iNowDay;
      end
      // 1-2. 출생월 < 기록월
      else if (iBornMon < iNowMon) then
      begin
         iBornCnt := (Month[iBornMon]) + iBornDay;
         iNowCnt  := (Month[iNowMon])  + iNowDay;
      end
      else
      begin

         //----------------------------------------------------------------
         // 출생일시는 6/1일 새벽인데, 기록일자는 5/31인 case 발생
         //  - 그냥 '예외처리' 개념으로 로직 추가 @ 2012.06.01
         //----------------------------------------------------------------
         if (iNowMon = iBornMon - 1) and
            (iBornDay = 1) then
         begin
            // Return
            Result := IntToStr(diffDay);

            Exit;
         end
         else
         begin
            MessageBox(self.Handle,
                       '종료월(기록,입원)이 시작월(출생)보다 작습니다. 기록일자를 재 선택 바랍니다.',
                       '교정연령 계산 실패',
                       MB_OK + MB_ICONWARNING
                       );

            Exit;
         end;
      end;
   end
   //------------------------------------
   // 2. 출생년도 < 기록년도
   //------------------------------------
   else if (iBornYear < iNowYear) then
   begin
      // 2-1. 출생월 = 기록월
      if (iBornMon = iNowMon) then
      begin
         iBornCnt := iBornDay;
         iNowCnt  := (iNowYear - iBornYear) * 365 + iNowDay;
      end
      // 2-2. 출생월 > 기록월
      else if (iBornMon > iNowMon) then
      begin
         // 기록월이 2월이후
         if (iNowMon > 1) then
         begin
            iBornCnt := (Month[iBornMon]) + iBornDay;
            iNowCnt  := (iNowYear - iBornYear) * 365 + (Month[iNowMon])  + iNowDay;
         end
         // 기록월이 1월
         else if (iNowMon = 1) then
         begin
            iBornCnt := (Month[iBornMon])   + iBornDay;
            iNowCnt  := (Month[iNowMon+12]) + iNowDay;
         end;
      end
      // 2-3. 출생월 < 기록월
      else if (iBornMon < iNowMon) then
      begin
         iBornCnt := (Month[iBornMon]) + iBornDay;
         iNowCnt  := (iNowYear - iBornYear) * 365 + (Month[iNowMon])  + iNowDay;
      end;

   end
   //------------------------------------
   // 3. 출생년도 > 기록년도
   //------------------------------------
   else
   begin
      MessageBox(self.Handle,
                 '종료년도(기록,입원)가 종료년도(출생)보다 작습니다. 기록일자를 재 선택 바랍니다.',
                 '재태연령 계산 실패',
                 MB_OK + MB_ICONWARNING
                 );

      Exit;
   end;

   //-----------------------------------------------------------------
   // 순 경과일수(차이)
   //-----------------------------------------------------------------
   diffDay  := iNowCnt - iBornCnt;


   //-------------------------------------------------------
   // 윤년 계산 추가
   //-------------------------------------------------------
   if (isYunYear(iNowYear) or isYunYear(iBornYear)) and                       // 종료년도(기록,입원)) 또는 시작년도(출생)가 윤년이면서,
      (((iNowYear > iBornYear) and (iNowMon > 2)) or                          // 종료년도(기록,입원)가 시작년도(출생)보다 같거나 크고 종료월(기록,입원)이 2월이후 또는
       ((iNowYear = iBornYear) and (iNowMon > 2) and (iBornMon <= 2))) then   // 종료월(기록,입원)이 2월이후이고 시작월(출생)이 1~2월이면, ++

      diffDay := diffDay + 1;



   //-----------------------------------------------------------------
   // 출생일 ~ 기준 기록일 까지의 순 경과일수
   //-----------------------------------------------------------------
   iTmpTransWks := (diffDay div 7);
   iTmpTransDay := (diffDay mod 7) + varBornDay;


   //-----------------------------------------------------------------
   // 일수가 7이 넘어가면, 주수 + 1
   //-----------------------------------------------------------------
   if iTmpTransDay >= 7 then
   begin
      iTmpTransWks := iTmpTransWks + 1;
      iTmpTransDay := iTmpTransDay - 7;
   end
   else
   begin
      iTmpTransWks := iTmpTransWks;
      iTmpTransDay := iTmpTransDay;
   end;


   //-----------------------------------------------------------------
   // 교정주령 환산보기 Checked시 교정주수 + 교정일수 추가 계산
   //          - 관련 S/R : ASPD1610013 (PD 신정희)
   //          - 2017.01.17 LSH
   //-----------------------------------------------------------------
   if (fcb_ConvertWks.Checked) then
   begin
      // 출생일자 ~ 입원일자 순 경과일수
      iDiffDay1  := GetDiffDay(in_BornDate, FsMedDate);

      // 개정된 출생일자 (원 출생일자 + 입원기간까지 순 경과일수)
      fixed_BornDate := FormatDateTime('yyyymmdd', StrToDate(ConvertSDate(in_BornDate)) + iDiffDay1);

      trans_BornDate  := EncodeDate(strToint(CopyByte(fixed_BornDate,1,4)),
                                    strToint(CopyByte(fixed_BornDate,5,2)),
                                    strToint(CopyByte(fixed_BornDate,7,2)));


      trans_RgtDate  := EncodeDate(strToint(CopyByte(in_RgtDate,1,4)),
                                   strToint(CopyByte(in_RgtDate,5,2)),
                                   strToint(CopyByte(in_RgtDate,7,2)));

      dDiffDayFloat  := (trans_RgtDate - trans_BornDate);

      iDiffDay2 := StrToInt(FloatToStr(dDiffDayFloat));

      // 출생일부터 ~ 입원시점이 고려된 선택된 기록일 까지의 순 경과일수
      iTmpPeriod  := iDiffDay1 + iDiffDay2;

      // 재태주령에 더해져야할 week 카운트
      iAddingWks    := iTmpPeriod div 7;

      // 재태주령에 더해져야할 day 카운트
      iAddingDay    := iTmpPeriod mod 7;


      // 재태주령 day와 추가될 day의 합이 7을 넘으면,
      // 재태주령 week 카운트에 해당 week 카운트를 더해준다.
      if (iTmpTransDay + iAddingDay >= 7) then
      begin
         iAddedWks := iAddingWks + 1;

         try
            iAddedDay := (iTmpTransDay + iAddingDay) mod 7;

         except
            on e : Exception do
            begin
               showmessage(e.Message + ' : NICU 교정연령 7일미만(추가) 계산 예외처리');
            end;
         end;
      end
      else
      begin
         iAddedWks  := iAddingWks;

         try
            iAddedDay := (iTmpTransDay + iAddingDay) mod 7;

         except
            on e : Exception do
            begin
               showmessage(e.Message + ' : NICU 교정연령 7일이상(추가) 계산 예외처리');
            end;
         end;
      end;

      // 교정된 Week 및 Day 를 기존 재태주령 buffer var.에 added.
      iTmpTransWks := iTmpTransWks + iAddedWks;
      iTmpTransDay := iTmpTransDay + iAddedDay;

      // 교정주수 Label 표기 추가 (조금 더 고민해보자..)
      //lb_BornWks.Caption := lb_BornWks.Caption + ' [교정] ' + IntToStr(varBornWks + iAddedWks) + ' + ' + IntToStr(varBornDay + iAddedDay);

   end;


   //-----------------------------------------------------------------
   // 일수(Day)를 소수점으로 환산하여,
   // 출생주수(Wks + Day)별 X축 Drawing 좌표 Set.
   //-----------------------------------------------------------------
   iTmpTransDay2 := (0.01 * (iTmpTransDay mod 7) * 100 / 7);


   //-----------------------------------------------------------------
   // 최종 환산 주수 (Day가 소수점 환산된 Wks)
   //-----------------------------------------------------------------
   tmpResult := varBornWks + iTmpTransWks + iTmpTransDay2;


   //-----------------------------------------------------------------
   // 재태연(주)령
   //-----------------------------------------------------------------
   try
      Result := FloatToStr(tmpResult);

   except
      on e : Exception do
      begin
         MessageBox(Self.Handle,
                    PChar('[Exception Msg] : ' + e.Message),
                    'NeoNatal 재태연령 계산 예외처리',
                    MB_OK + MB_ICONINFORMATION);
      end;
   end;
end;



//------------------------------------------------------------------------------
// 윤년 계산
// - Neo 재태연령 계산위한 윤년 여부(Y/N) 체크
//
// Author : Lee, Se-Ha
// Date   : 2013.12.05
//------------------------------------------------------------------------------
function TMDRC05F1.IsYunYear(in_Year : Integer) : Boolean;
begin
   //-----------------------------------------------------------------
   // 초기값
   //-----------------------------------------------------------------
   Result := False;

   //-----------------------------------------------------------------
   // 4자리수 연도 입력받았으면, 윤년여부 Check
   //-----------------------------------------------------------------
   if LengthByte(IntToStr(in_Year)) = 4 then
   begin

      if (in_Year mod 4 = 0) and (in_Year mod 100 <> 0) or
         (in_Year Mod 400 = 0) then
         Result := True
      else
         Result := False;
   end;
end;


//------------------------------------------------------------------------------
// 신생아 간호정보조사지 출생주수 조회 함수
//
// Author : Lee, Se-Ha
// Date   : 2013.12.17
//------------------------------------------------------------------------------
function TMDRC05F1.GetNeoBornWks(in_PatNo : String;
                                 var varBornWks, varBornDay : Integer) : Boolean;
var
   TpGetNeo : TTpSvc;
   sType1, sType2, sType3, sType4 : String;
begin
   //---------------------------------------------------
   // Set Default Return Value
   //---------------------------------------------------
   Result := False;

   lb_BornWks.Caption := '출생주수 :';
   lb_BornWks.Visible := False;



   //---------------------------------------------------
   // Set Input Variables
   //---------------------------------------------------
   sType1 := '$';
   sType2 := in_PatNo;
   sType3 := '';
   sType4 := '';


   //---------------------------------------------------
   // Create TpSvc Object
   //---------------------------------------------------
   TpGetNeo := TTpSvc.Create;
   TpGetNeo.Init(nil);



   Screen.Cursor := crHourglass;


   try
      TpGetNeo.CountField  := 'S_CODE1';
      TpGetNeo.ShowMsgFlag := False;

      if TpGetNeo.GetSvc( 'MD_CHECK_L6',
                         ['S_TYPE1'  , sType1
                         ,'S_TYPE2'  , sType2
                         ,'S_TYPE3'  , sType3
                         ,'S_TYPE4'  , sType4   ],
                         ['S_CODE1'  , 'sCode1'
                         ,'S_CODE2'  , 'sCode2'
                         ,'S_CODE3'  , 'sCode3'
                         ,'S_CODE4'  , 'sCode4'
                         ,'S_CODE5'  , 'sCode5' ])
      then
      begin
         if TpGetNeo.RowCount > 0 then
         begin
            //---------------------------------------------------------
            //  True 반환
            //---------------------------------------------------------
            varBornWks := StrToInt(TpGetNeo.GetOutputDataS('sCode1', 0));
            varBornDay := StrToInt(TpGetNeo.GetOutputDataS('sCode2', 0));

            Result := True;
         end;
      end
      else
      begin
         ShowErrMsg;
      end;


      //---------------------------------------------------------
      // 출생주수 표기
      //---------------------------------------------------------
      lb_BornWks.Caption := '출생주수 : ' + IntToStr(varBornWks) + '주' + IntToStr(varBornDay) + '일 (' + ConvertSDate(varBirtdate) + ')';


   finally
      FreeAndNil(TpGetNeo);
      Screen.Cursor := crDefault;
   end;

end;



//------------------------------------------------------------------------------
// [출생주수] FlatEditBox onKeyDown Event Handler
//
// Date   : 2013.12.16
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_DayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   //---------------------------------------------------------
   // Enter 입력시 검색
   //---------------------------------------------------------
   if (Key <> 13) or
      (Trim(fed_Day.Text) = '') or
      (Trim(fed_Day.Text) >= '7') then
   begin
      Exit;
   end;


   if (Key = 13) and
      (Trim(fed_Day.Text) <> '')then
   begin
      varBornWks := StrToInt(Trim(fed_Wks.Text));
      varBornDay := StrToInt(Trim(fed_Day.Text));

      lb_BornWks.Caption := '출생주수 : ' + Trim(fed_Wks.Text) + '주' + Trim(fed_Day.Text) + '일 (' + ConvertSDate(varBirtdate) + ')';
      lb_BornWks.Visible := False;
   end;


   //---------------------------------------------------------
   // 초기화
   //---------------------------------------------------------
   fed_Wks.Text := '';
   fed_Day.Text := '';


   //---------------------------------------------------------
   // 신생아 출생주수 확인 Panel Close
   //---------------------------------------------------------
   apn_NeoBornWks.Collaps := True;
   apn_NeoBornWks.Visible := False;


   //---------------------------------------------------------
   // 환아 측정이력 Draw
   //---------------------------------------------------------
   DrawPatSeries;
end;


//------------------------------------------------------------------------------
// [출생주수] FlatEditBox onChange Event Handler
//
// Date   : 2013.12.16
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_WksChange(Sender: TObject);
begin
   //------------------------------------------------
   // 2자리 숫자 입력시, Day로 Set Focus
   //------------------------------------------------
   if LengthByte(Trim(fed_Wks.Text)) >= 2 then
      fed_Day.SetFocus;
end;


//------------------------------------------------------------------------------
// 신생아 성장곡선 출생주수 Line Draw
//
// Date   : 2013.12.18
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.NeoBornAfterDraw;
var
   XBornPosition  : Longint;
   tmpWks, tmpDay : Integer;
   XTransDay      : Real;
begin
   with chr_PdGrow do
   begin
      if ((fed_Wks.Text <> '') and (varBornWks = 0)) or
         ((fed_Wks.Text = '')  and (varBornWks > 0)) then
      begin
         if varBornWks > 0 then
         begin
            tmpWks := varBornWks;
            tmpDay := varBornDay;
         end
         else
         begin
            tmpWks := StrToInt(fed_Wks.Text);
            tmpDay := StrToInt(fed_Day.Text);
         end;


         //-----------------------------------------------------------------
         // 일수(Day)를 주수(소수점)로 환산하여,
         // 출생주수(Wks + Day)별 X축 Drawing 좌표 Set.
         //-----------------------------------------------------------------
         XTransDay := (0.01 * (tmpDay mod 7) * 100 / 7);
         XBornPosition := BottomAxis.CalcXPosValue(tmpWks + XTransDay);


         //-----------------------------------------------------------------
         // Set Pen and Draw the line
         //-----------------------------------------------------------------
         Canvas.Pen.Width := 3;
         Canvas.Pen.Style := psSolid;
         Canvas.Pen.Color := clMaroon;
         Canvas.MoveTo(XBornPosition, ChartRect.Bottom);
         Canvas.LineTo(XBornPosition, ChartRect.Top);

         //-----------------------------------------------------------------
         // Change font
         //-----------------------------------------------------------------
         Canvas.Font.Name   := 'Tahoma';
         Canvas.Font.Height := -12;       // <-- Express Font Size in "Height", NOT "Size"
         Canvas.Font.Color  := clMaroon;
         Canvas.Font.Style  := [fsBold];


         //-----------------------------------------------------------------
         // Set Background
         //-----------------------------------------------------------------
         Canvas.Brush.Style := bsSolid;


         //-----------------------------------------------------------------
         // 조산아인 경우 Output Text의 X 좌표가 음수(화면 왼쪽으로 짤림)가
         // 되기 때문에, 강제로 Position에 Offset 적용 @ 2017.01.17 LSH
         //-----------------------------------------------------------------
         if XBornPosition - 80 < 100 then
            XBornPosition := 200;


         //-----------------------------------------------------------------
         // Output Text
         //-----------------------------------------------------------------
         Canvas.TextOut(XBornPosition - 80 ,
                        ChartRect.Bottom + 20,
                        lb_BornWks.Caption);
      end;
   end;
end;


//------------------------------------------------------------------------------
// [Debug] 개발자용 Refresh 기능
//
// Date   : 2013.12.23
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.sbt_RefreshClick(Sender: TObject);
begin
   // log
   Memo1.Lines.Add('---------------');
   Memo1.Lines.Add('Refresh ');


   //-----------------------------------------------------------------
   // 성별-월령별 Axis Panel Location
   //-----------------------------------------------------------------
   SetAxisPanel(IsAgeFlag);

   //-----------------------------------------------------------------
   // 성별-월령별 Chart Axis Set
   //-----------------------------------------------------------------
   SetStandardAxis(IsAgeFlag,
                   CopyByte(Trim(fed_SexAge.Text), 1, 1));


   //-----------------------------------------------------------------
   // 성별-월령별 항목별 표준성장지표 조회
   //-----------------------------------------------------------------
   if IsAgeFlag = 'NEONATAL' then
      GetStandardMarking('7',
                         'NBINF',
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '')
   else if IsAgeFlag = 'ZERO2THIRTYSIX' then
      GetStandardMarking('1',
                         'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용(PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '')
   else if IsAgeFlag = 'TWO2EIGHTTEEN' then
      GetStandardMarking('2',
                         'P' + fn_nvl(FsStandIdx, '2017'),           // 표준 D/B 기준 인덱스 적용(PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '');

   //-----------------------------------------------------------------
   // 환아 측정이력 Draw
   //-----------------------------------------------------------------
   DrawPatSeries;

end;

//------------------------------------------------------------------------------
// [Debug] Chart Axis Range 초기화
//
// Date     : 2013.12.26
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.ResetAxisRange;
begin
   // Log
   Memo1.Lines.Add('Reset Axis Range(Init)');

   //-----------------------------------------------------------------
   // Tab Changed 이벤트 발생시 Axis Range 수동 Refersh Debugging
   //-----------------------------------------------------------------
   with chr_PdGrow do
   begin
      LeftAxis.Maximum      := C_VERTAXIS_MAX_INIT;
      LeftAxis.Minimum      := C_VERTAXIS_MIN_INIT;

      RightAxis.Maximum     := C_VERTAXIS_MAX_INIT;
      RightAxis.Minimum     := C_VERTAXIS_MIN_INIT;

      TopAxis.Maximum       := C_HORIZAXIS_MAX_INIT;
      TopAxis.Minimum       := C_HORIZAXIS_MIN_INIT;

      BottomAxis.Maximum    := C_HORIZAXIS_MAX_INIT;
      BottomAxis.Minimum    := C_HORIZAXIS_MIN_INIT;
   end;
end;


procedure TMDRC05F1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := Cafree;
end;

procedure TMDRC05F1.FormDestroy(Sender: TObject);
begin
   MDRC05F1 := nil;
end;

procedure TMDRC05F1.sbt_ZoomInClick(Sender: TObject);
begin
   chr_PdGrow.AnimatedZoom := True;
   chr_PdGrow.ZoomPercent( 125 );
end;


//------------------------------------------------------------------------------
// [함수] 표준정규 누적분포 계산 (환아 신체측정 data 백분위수 표기)
//       - MS Excel의 Normsdist() 계산공식 참조함.
//
// Date   : 2014.05.22
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.NormsDist(in_ZScore : Extended ) : Extended;
var
   b1, b2, b3, b4, b5, p, t1, t2, t3, t4, t5, dArea, xx : Extended;
begin
   // Constant 정의
	b1 := 0.31938153;
	b2 := -0.356563782;
	b3 := 1.781477937;
	b4 := -1.821255978;
	b5 := 1.330274429;
	p  := 0.2316419;


   // Z-Score 절대값 반환
	xx := Abs(in_ZScore);


   // 입력값 유효성 Check
   if (xx = 0) then
   begin
      Result := 0;
      Exit;
   end;


   // Normsdist() 내부 Constant 생성
	t1 := 1.0 / (1.0 + p * xx);
	t2 := t1 * t1;
	t3 := t2 * t1;
	t4 := t3 * t1;
	t5 := t4 * t1;

   // 표준정규 누적분포 계산
	dArea := INVSQRT2PI * Exp(-0.5 * xx * xx) * (b1 * t1 + b2 * t2 + b3 * t3 + b4 * t4 +b5 * t5);


	if (in_ZScore > 0.0) then
		dArea := 1.0 - dArea;

	Result := dArea;

end;



//------------------------------------------------------------------------------
// 표준정규분포 백분위수 계산함수 호출 및 Panel-on
//
// Date   : 2014.05.23
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.CalcZScore2Dist(in_Gubun : String; in_Year, in_Month, in_Item : Extended) : String;
var
   i : Integer;
   TpGetLMS : TTpSvc;
   sType1, sType2, sType3, sType4, sType5, sType6 : String;
   tmpZ_Wgt, tmpZ_Hgt, tmpZ_Bmi : String;
begin

   sType1 := '8';
   sType2 := 'P' + fn_nvl(FsStandIdx, '2017');           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
   sType3 := CopyByte(Trim(fed_SexAge.Text), 1, 1);
   sType4 := FloatToStr(in_Year);
   sType5 := FloatToStr(in_Month);


   TpGetLMS := TTpSvc.Create;
   TpGetLMS.Init(nil);



   Screen.Cursor := crHourglass;



   try
      TpGetLMS.CountField  := 'S_STRING2';
      TpGetLMS.ShowMsgFlag := False;

      if TpGetLMS.GetSvc('MD_PDBOD_L1',
                        ['S_TYPE1'    , sType1
                       , 'S_TYPE2'    , sType2
                       , 'S_TYPE3'    , sType3
                       , 'S_TYPE4'    , sType4
                       , 'S_TYPE5'    , sType5
                        ],
                        [
                         'S_STRING2'  , 'sItem'
                       , 'S_STRING34' , 'sLesti'
                       , 'S_STRING35' , 'sMesti'
                       , 'S_STRING36' , 'sSesti'
                       ])
      then
      begin
         // 체중 Z-Score 계산
         if (in_Gubun = 'WEIGHT') and
            (in_Item > 0) then
         begin
            // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 0))) = 0 then
            begin
               try
                  tmpZ_Wgt := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 0))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 0))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end
            else
            begin
               try
                  tmpZ_Wgt := FloatToStr(
                                             (Power((in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 0))), StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 0))) - 1) /
                                             (StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 0)) * StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 0)))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end;
         end
         else
            tmpZ_Wgt := '0';

         // 신장 Z-Score 계산
         if (in_Gubun = 'HEIGHT') and
            (in_Item > 0) then
         begin
            // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 1))) = 0 then
            begin
               try
                  tmpZ_Hgt := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 1))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 1))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end
            else
            begin
               try
                  tmpZ_Hgt := FloatToStr(
                                             (Power((in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 1))), StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 1))) - 1) /
                                             (StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 1)) * StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 1)))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end;
         end
         else
            tmpZ_Hgt := '0';

         // BMI Z-Score 계산
         if (in_Gubun = 'BMI') and
            (in_Item > 0) then
         begin
            // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2))) = 0 then
            begin
               try
                  tmpZ_Bmi := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 2))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 2))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end
            else
            begin
               try
                  tmpZ_Bmi := FloatToStr(
                                             (Power((in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 2))), StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2))) - 1) /
                                             (StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2)) * StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 2)))
                                         );
               except
                  // Floating 계산 예외처리
               end;
            end;
         end
         else
            tmpZ_Bmi := '0';


      end;

   finally
      FreeAndNil(TpGetLMS);

      Screen.Cursor := crDefault;
   end;


   // Return Value
   if (in_Gubun = 'HEIGHT') then
      Result := FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloat(tmpZ_Hgt)), 0)) + 'p'
   else if (in_Gubun = 'WEIGHT') then
      Result := FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloat(tmpZ_Wgt)), 0)) + 'p'
   else if (in_Gubun = 'BMI') then
      Result := FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloat(tmpZ_Bmi)), 0)) + 'p';

end;






//------------------------------------------------------------------------------
// 표준정규분포 백분위수 계산함수 호출 및 Panel-on To Grid
//
// Date   : 2014.07.08
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.CalcZScore2Grid;
var
   i : Integer;
   TpGetLMS : TTpSvc;
   sType1, sType2, sType3, sType4, sType5, sType6 : String;
   tmpZ_Wgt, tmpZ_Hgt, tmpZ_Bmi : String;
begin

   with asg_BodyInfo do
   begin
      // 백분위 표기 Grid RowCount
      asg_NormsDist.RowCount := RowCount;


      for i := 1 to RowCount - 1 do
      begin
         sType1 := '8';
         sType2 := 'P' + fn_nvl(FsStandIdx, '2017');           // 표준 D/B 기준 인덱스 적용 (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
         sType3 := CopyByte(Trim(fed_SexAge.Text), 1, 1);
         sType4 := Cells[C_YEAR,  i];
         sType5 := Cells[C_MONTH, i];

         //---------------------------------------------------------------------
         // 2~18세 성장발육 Chart 대상중 18세 초과 측정정보 백분위 표기 제외
         //          - 요청 : PD 남효경
         //          - D/B에는 2~18세까지 밖에 LMS 정보 없으므로, Skip.
         //          - 2016.09.08 LSH
         //
         // 신생아 입원 측정이력 연동관련 18세 미만 아닌경우, Z-Score 백분위 표기 제한
         //          - 관련 S/R : ASPD1610013 (PD 신정희)
         //          - 2017.01.17 LSH
         //---------------------------------------------------------------------
         {
         if (StrToIntDef(sType4, 0) >= 18) and
            (StrToIntDef(sType5, 0) >  0)  then
         }
         if (
               (StrToIntDef(sType4, 0) >= 18) and  // 만 18세 이상이면 표기 제한
               (StrToIntDef(sType5, 0) >  0)
            )  then
         begin
            Continue;
         end;

         TpGetLMS := TTpSvc.Create;
         TpGetLMS.Init(nil);


         Screen.Cursor := crHourglass;



         try
            TpGetLMS.CountField  := 'S_STRING2';
            TpGetLMS.ShowMsgFlag := False;

            if TpGetLMS.GetSvc('MD_PDBOD_L1',
                              ['S_TYPE1'    , sType1
                             , 'S_TYPE2'    , sType2
                             , 'S_TYPE3'    , sType3
                             , 'S_TYPE4'    , sType4
                             , 'S_TYPE5'    , sType5
                             , 'S_TYPE6'    , sType6
                              ],
                              [
                               'S_STRING2'  , 'sItem'
                             , 'S_STRING34' , 'sLesti'
                             , 'S_STRING35' , 'sMesti'
                             , 'S_STRING36' , 'sSesti'
                             ])
            then
            begin

               //  Grid 표기가 아닌, Chart상 표기로 전환관계로 주석처리 @ 2014.05.26 LSH
               //  Grid 표기 재요청 관련 주석해제 @ 2014.07.08 LSH
               // 체중 Z-Score 계산
               if (Cells[C_WEIGHT, i] > '0') then
               begin
                  // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 0), 0)) = 0 then
                  begin
                     try
                        tmpZ_Wgt := FloatToStr(
                                                   ln(StrToFloat(Cells[C_WEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 0), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 0), 0)
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end
                  else
                  begin
                     try
                        tmpZ_Wgt := FloatToStr(
                                                   (Power((StrToFloat(Cells[C_WEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 0), 0)), StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 0), 0)) - 1) /
                                                   (StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 0), 0) * StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 0), 0))
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end;
               end
               else
                  tmpZ_Wgt := '0';

               // 신장 Z-Score 계산
               if (Cells[C_HEIGHT, i] > '0') then
               begin
                  // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 1), 0)) = 0 then
                  begin
                     try
                        tmpZ_Hgt := FloatToStr(
                                                   ln(StrToFloat(Cells[C_HEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 1), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 1), 0)
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end
                  else
                  begin
                     try
                        tmpZ_Hgt := FloatToStr(
                                                   (Power((StrToFloat(Cells[C_HEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 1), 0)), StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 1), 0)) - 1) /
                                                   (StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 1), 0) * StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 1), 0))
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end;
               end
               else
                  tmpZ_Hgt := '0';

               // BMI Z-Score 계산 (2세부터 LMS 추정치 연산가능)
               if (Cells[C_YEAR, i] > '1') and
                  (Cells[C_BMI, i] > '0') then
               begin
                  // L-Value가 0인 경우 계산식 분기 @ 2016.02.11 LSH (PD 남효경)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 2), 0)) = 0 then
                  begin
                     try
                        tmpZ_Bmi := FloatToStr(
                                                   ln(StrToFloat(Cells[C_BMI, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 2), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 2), 0)
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end
                  else
                  begin
                     try
                        tmpZ_Bmi := FloatToStr(
                                                   (Power((StrToFloat(Cells[C_BMI, i])/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 2))), StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2))) - 1) /
                                                   (StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2)) * StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 2)))
                                               );
                     except
                        // Floating 계산 예외처리
                     end;
                  end;
               end
               else
                  tmpZ_Bmi := '0';

            end;

         finally
            FreeAndNil(TpGetLMS);

            Screen.Cursor := crDefault;
         end;



         //  Grid 표기가 아닌, Chart상 표기로 전환관계로 주석처리 @ 2014.05.26 LSH
         //  Grid 표기 재요청 관련 주석해제 @ 2014.07.08 LSH
         // 표준정규누적분포(백분위, f(z)) 계산
         try
            asg_NormsDist.Cells[0, i] :=  FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Wgt, 0)), 0)) + 'p | ' +
                                          FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Hgt, 0)), 0)) + 'p | ' +
                                          FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Bmi, 0)), 0)) + 'p';
         except
            // Floating 계산 예외처리
         end;
      end;
   end;
end;


//------------------------------------------------------------------------------
// 백분위수 계산 및 Text Banner Drawing
//
// Date     : 2014.05.26
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.DrawNormsBanner(in_Series : TChartSeries;
                                    in_Gubun  : String;
                                    in_Year,
                                    in_Month,
                                    in_TotMon,
                                    in_Item   : Extended;
                                    in_Color  : TColor);
var
   x, y  : Integer;
   sText : String;
   rT    : TRect;
begin
   with chr_PdGrow do
   begin
      // 실제 Chart상 좌표 얻기
      x := in_Series.CalcXPosValue(in_TotMon);
      y := in_Series.CalcYPosValue(in_Item);


      // 값 위치에 표시될 Marker 크기, 위치 설정
      // 값 위치에 표실될 MARKER 크기, 위치 수정  @ 2016.01.22 lSH
      {
      rT.Left     := x - 2;
      rT.Right    := x + 2;
      rT.Top      := y - 2;
      rT.Bottom   := y + 2;
      }
      rT.Left     := x - 45;
      rT.Top      := y - 30;
      rT.Width    := 30;
      rT.Height   := 15;

      // 값 주변에 정보 표시
      Canvas.Pen.Color   := clNavy;
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := clNavy;

      // 폰트 색상, 글꼴, 크기 지정
      chr_PdGrow.Canvas.Font.Name   := 'Arial';
      chr_PdGrow.Canvas.Font.Color  := clWhite;
      chr_PdGrow.Canvas.Font.Size   := 9;
      chr_PdGrow.Canvas.Font.Style  := [fsBold];

      // XE7 전환시 Canvas내 Brush 속성 그려주기 위해 추가 @ 2016.01.22 lSH
      Canvas.FillRect(rT);

      // 텍스트 출력
      try
         sText := CalcZScore2Dist(in_Gubun,
                                  in_Year,
                                  in_Month,
                                  in_Item);

      except
         // 표준정규누적분포 계산시 발생하는 floating point 에러 Skip
      end;

      chr_PdGrow.Canvas.TextOut(x - 30, y - 30, sText);


      // 언더바와 값 Maker 사이에 선긋기
      chr_PdGrow.Canvas.Pen.Color := clNavy;
      chr_PdGrow.Canvas.MoveTo(x, y);
      chr_PdGrow.Canvas.LineTo(x - 15, y - 15);
   end;
end;



procedure TMDRC05F1.asg_NormsDistGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
   HAlign := taCenter;
   VAlign := vtaCenter;
end;

// save to file from panel - kjs
procedure TMDRC05F1.SaveComponentImg(Sender: TObject);
var
   vImg: Graphics.TBitmap;
begin
   vImg := Graphics.TBitmap.Create;
   try
      // 차트 (좌) + 측정정보 (우) 캡쳐
      CaptureWinCtrlImage(fpn_Framework, vImg);
      vImg.SaveToFile(G_HOMEDIR + 'Temp\MDRC05F1_CAP.bmp');
   finally
      vImg.Free;
   end;
end;



procedure TMDRC05F1.CaptureWinCtrlImage(AWinControl: TWinControl;
  AImg: TGraphic);
var
   vBmp: Graphics.TBitmap;
   vControlDC: HDC;
begin
   // if the TWinControl has not been initialized, raise error
   if not AWinControl.HandleAllocated then
      raise Exception.Create('The control''s window handle has not been allocated');

   // Get Device Context of the TWinControl
   vControlDC := GetWindowDC(AWinControl.Handle);

   try
      // create our temporary TBitmap
      vBmp := Graphics.TBitmap.Create;

      try
         vBmp.PixelFormat := pf24bit;

         // adjust the temporary TBitmap dimension to match
         // the TWinControl's
         vBmp.Height := AWinControl.Height;
         vBmp.Width  := AWinControl.Width;

         // draw the content of the TWinControl to the temporary bitmap
         BitBlt(vBmp.Canvas.Handle, 0, 0, vBmp.Width, vBmp.Height, vControlDC, 0, 0, SRCCOPY);

         // copy the image in the temporary bitmap to the given graphic instance
         AImg.Assign(vBmp);

      finally
         vBmp.Free;
      end;
   finally
      // release the Device Context
      ReleaseDC(AWinControl.Handle, vControlDC);
   end;
end;


procedure TMDRC05F1.fbt_PrintClick(Sender: TObject);
var
   FForm_Preview : TForm;
begin
   // 차트 및 측정정보 (전체 frame) 이미지 저장
   SaveComponentImg(Sender);

   // 출력(QReport) 폼 생성 및 이미지 불러오기
   // 권한체크(실습학생 출력 불가)
   if CheckAuthority('PRINT', '', '', '', self.Name) = False then Exit;

   // 프린트 상태 Check
   if (IsNotPrinterReady) then Exit;


   try
      if MDRC05F1_P01 <> nil then
         MDRC05F1_P01.Close;

      Application.CreateForm(TMDRC05F1_P01, MDRC05F1_P01);

      MDRC05F1_P01.qrimg_GrowthChart.Picture.Bitmap.LoadFromFile(G_HOMEDIR + 'TEMP\MDRC05F1_CAP.bmp');
      MDRC05F1_P01.qrImg_Hospital.Picture.LoadFromFile(G_HOMEDIR + 'EXE\RES\HSIG_KR2_' + G_LOCATE + '.JPG');

      // 개인정보보호 출력물관리
      MDRC05F1_P01.qr_ChartMain.ReportTitle := '[MDRC05F1_P01] 성장발육곡선';   // 정보의 정확성을 위해 ReportTitle을 추가
      fn_SetReportID(MDRC05F1_P01.qr_ChartMain);                                // 출력 ID

      {-- 미리보기 확장성 고려
      if cbx_Preview.Checked then
      begin
         FForm := BplFormCreate('PTP001F1');
         SetBplStrProp('PTP001F1','prop_Caption',Self.Caption);
         SetBplClassProp('PTP001F1','prop_Report',MDS110F2_P01.qr_01);

         FForm.ShowModal;
      end
      else
      begin
         MDS110F2_P01.qr_01.Print;
      end;
      }


      // 태스트용 미리보기 (BPL) 연동
      FForm_Preview := BplFormCreate('PTP001F1');

      SetBplStrProp(FForm_Preview.Name,   'prop_Caption', Self.Caption);
      SetBplClassProp(FForm_Preview.Name, 'prop_Report',  MDRC05F1_P01.qr_ChartMain);

      FForm_Preview.ShowModal;



      //MDRC05F1_P01.qr_ChartMain.PrePare;
      //MDRC05F1_P01.qr_ChartMain.Preview;

   finally
      MDRC05F1_P01.Free;
   end;

end;

initialization
   RegisterClass(TMDRC05F1);

finalization
   UnRegisterClass(TMDRC05F1);

end.
