{===============================================================================
   Program ID    : MDRC05U1
   Program Name  : �Ҿ� �������� Charting �� �����̷� ����
   Program Desc. : �Ҿ�û�ҳ� ����ܰ躰(�Ż���, 0~36����, 2�� ~ 18��)
                   ǥ�ص�ǥ Charting �� ȯ���� V/S �ڵ� Graph + �����̷� ����

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
   // ǥ�����Դ������� ��� : 1/sqrt(2*pi)
   INVSQRT2PI = 0.3989422804014327;

   // Vert - Horiz Axis �ʱ�ȭ �⺻��
   C_VERTAXIS_MAX_INIT   = 200;
   C_VERTAXIS_MIN_INIT   = 0;
   C_HORIZAXIS_MAX_INIT  = 100;
   C_HORIZAXIS_MIN_INIT  = 0;


   // �������� Grid Column ����
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

   C_SERIES_CNT      = 25; // ǥ����ǥ Series (2007) �� Count
   C_SERIES_2017_CNT = 37; // 2017 ǥ�� D/B Series �� Count �߰� @ 2018.05.30 LSH

   // ȯ�� �����̷� Line Series index
   C_SERIES_IDX_PATHGT     = 23;
   C_SERIES_IDX_PATWGT     = 24;
   C_SERIES_IDX_PATHEADCIR = 25;
   C_SERIES_IDX_PATBMI     = 26;


   // flat Tab-Contrl Active Tab �ε���
   AT_NEONATAL         = 0;
   AT_ZERO2THIRTYSIX   = 1;
   AT_TWO2EIGHTTEEN    = 2;
   AT_HEADCIR          = 3;
   AT_BMI              = 4;

   // 2007 vs. 2017 ���� ǥ�� D/B ���ɹ��� ���濡 ���� Const. @ 2018.05.29 LSH
   C_2007_HEADCIR_MAXRANGE = 81;
   C_2017_HEADCIR_MAXRANGE = 72;

   // ��Ʈĸ�� �� ���� Panel �����ϸ鼭 ���� axis ��鸲 ������ offset @ 2020.01.22 LSH
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

    // ������Ʈ ĸ�� ���� ���(from ������P) �߰� @ 2020.01.14 LSH
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
    FsPatCls   : String;         // �Կ��� �����̷� �������� ���� Flag @ 2017.01.17 LSH
    FsMedDate  : String;         // ����(�Կ�)���� (yyyymmdd) @ 2017.01.17 LSH
    FsMedTime  : String;         // �ܷ� �����ð� (yyyymmddhh24miss) @ 2017.01.17 LSH
    FsFromForm : String;         // �Կ� �����̷� �ڵ����� Check ���� Flag @ 2017.01.17 LSH
    FsMedDept  : String;         // ȯ�� �� ����� @ 2017.01.18 LSH
    FsStandIdx : String;         // ���� D/B ǥ�� �ε��� (2007/2017/..) @ 2018.05.28 LSH

    //-------------------------------------------------------------------
    // ����-���ɺ� �׸� ǥ�ؼ�����ǥ(D/B) Chart ǥ��
    //-------------------------------------------------------------------
    procedure GetStandardMarking(in_Flag,
                                 in_Gubun,
                                 in_Sex,
                                 in_Item : String);

    //-------------------------------------------------------------------
    // ����-���ɺ� �׸� ǥ�ؼ�����ǥ(D/B) Axis ����
    //-------------------------------------------------------------------
    procedure SetStandardAxis(in_Flag,
                              in_Sex : String);

    //-------------------------------------------------------------------
    // ����-���ɺ� Axis Hide Panel ��ġ ����
    //-------------------------------------------------------------------
    procedure SetAxisPanel(in_Flag : String);

    //-------------------------------------------------------------------
    // �μ��� ��ȸ (FlatCombo)
    //-------------------------------------------------------------------
    function GetFlatMedDept(FlatCombo : TFlatComboBox) : Integer;

    //-------------------------------------------------------------------
    // ��ü���� �̷� ��ȸ
    //-------------------------------------------------------------------
    procedure SelBodyInfo;

    //-------------------------------------------------------------------
    // Ư�����غ� ����(��, ����, �Ѱ�����) ��� �Լ�
    //-------------------------------------------------------------------
    function GetTransAge(in_Flag,
                         in_FromDate,
                         in_BirtDate : String) : String;

    //-------------------------------------------------------------------
    // ��ü���� ������ Data ������ȯ �Լ�
    //         - �Ż��� �������� �Կ��̷� ��������
    //           ȯ�� ��������(in_YearInfo) �߰� @ 2017.01.18 LSH (ASPD1610013, PD ������)
    //-------------------------------------------------------------------
    function GetTransData(in_Flag,
                          in_DataVal,
                          in_YearInfo : String) : String;

    //-------------------------------------------------------------------
    // BMI (ü��������) ��� �Լ�
    //-------------------------------------------------------------------
    function CalcBmi(in_Height,
                     in_Weight : String) : String;

    //-------------------------------------------------------------------
    // ȯ�� �����̷� Series Draw
    //-------------------------------------------------------------------
    procedure DrawPatSeries;

    //-------------------------------------------------------------------
    // �Ż��� ���¿��� ������� ���� ����(Y/N) üũ
    //-------------------------------------------------------------------
    function IsYunYear(in_Year : Integer) : Boolean;

    //-------------------------------------------------------------------
    // NeoNatal ���¿��� ��� �Լ�
    //  - �������, ���� ������ڸ� �޾Ƽ� ���¿����� ���.
    //-------------------------------------------------------------------
    function CalcNeoWks(in_BornDate,
                        in_RgtDate : String) : String;

    //-------------------------------------------------------------------
    // �Ż��� ��ȣ���������� ����ּ� ��ȸ �Լ�
    //-------------------------------------------------------------------
    function GetNeoBornWks(in_PatNo : String;
                           var varBornWks, varBornDay : Integer) : Boolean;

    //-------------------------------------------------------------------
    // �Ż��� ���� ����ּ� Line Draw
    //-------------------------------------------------------------------
    procedure NeoBornAfterDraw;

    //-------------------------------------------------------------------
    // [�����] Chart Axis Range �ʱ�ȭ
    //-------------------------------------------------------------------
    procedure ResetAxisRange;

    //-------------------------------------------------------------------
    // [�Լ�] ǥ�����Դ������� (ȯ�� ��ü���� data ������� ǥ��) ���
    //      - 2014.05.22 LSH
    //-------------------------------------------------------------------
    function NormsDist(in_ZScore : Extended ) : Extended;

    //-------------------------------------------------------------------
    // ǥ�����Ժ��� z-Score �� ����� ��� @ 2014.05.23 LSH
    //-------------------------------------------------------------------
    function CalcZScore2Dist(in_Gubun : String;
                             in_Year,
                             in_Month,
                             in_Item  : Extended) : String;


    //-------------------------------------------------------------------
    // ������� Text Drawing @ 2014.05.26 LSH
    //-------------------------------------------------------------------
    procedure DrawNormsBanner(in_Series : TChartSeries;
                              in_Gubun  : String;
                              in_Year,
                              in_Month,
                              in_TotMon,
                              in_Item   : Extended;
                              in_Color  : TColor);

    //-------------------------------------------------------------------
    // ǥ�����Ժ��� ������� ��� �� Panel-on To Grid @ 2014.07.08 LSH
    //-------------------------------------------------------------------
    procedure CalcZScore2Grid;

    //-------------------------------------------------------------------
    // [����] ó��ȭ�鿡�� ��ǥŬ���� ȭ�� ��ǥ �Է� - 2016.09.07 �ֿ���
    //-------------------------------------------------------------------
    procedure FormSetting;


  public
    { Public declarations }

    //-------------------------------------------------------------------
    // Cross-Hair (��ǥ����) ���� ���� var.
    //-------------------------------------------------------------------
    OldX,OldY        :  Longint;
    CrossHairColor   :  TColor;
    CrossHairStyle   :  TPenStyle;

    // 2016.09.07 �ֿ���
//    Form_OffSet      :  Boolean;

  published
    property prop_PatNo    : String read FsPatNo    write FsPatNo;     // ȯ�ڹ�ȣ Prop var.
    property prop_PatCls   : String read FsPatCls   write FsPatCls;    // �Կ��� �����̷� �������� Flag @ 2017.01.17 LSH
    property prop_MedDate  : String read FsMedDate  write FsMedDate;   // ����(�Կ�)���� @ 2017.01.17 LSH
    property prop_MedTime  : String read FsMedTime  write FsMedTime;   // �ܷ� �����ð� @ 2017.01.17 LSH
    property prop_FromForm : String read FsFromForm write FsFromForm;  // �Կ� �����̷� �ڵ����� ���� Check ���� Flag @ 2017.01.17 LSH
    property prop_MedDept  : String read FsMedDept  write FsMedDept;   // ȯ�� �� ����� @ 2017.01.18 LSH
    property prop_StandIdx : String read FsStandIdx write FsStandIdx;  // ���� D/B ǥ�� �ε��� (2007/2017/..) @ 2018.05.28 LSH

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
   MDRC05U1_P01;     // ��¾��(QR) �߰� @ 2020.01.14 LSH

{$R *.DFM}


//------------------------------------------------------------------------------
// [��ȸ] ����-���ɺ� �׸� ǥ�ؼ�����ǥ ��ȸ
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
   // Axis ����� Label Location ���� Debugging ó�� @ 2013.12.24 LSH
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
                      , 'S_STRING37' , 's85th'     // BMI 85������� �߰� @ 2014.10.23 LSH
                      , 'S_STRING38' , 's1st'      // 2017 ǥ�� D/B 1 ������� �߰� @ 2018.05.29 LSH
                      , 'S_STRING39' , 's15th'     // 2017 ǥ�� D/B 15 ������� �߰� @ 2018.05.29 LSH
                      , 'S_STRING40' , 's99th'     // 2017 ǥ�� D/B 99 ������� �߰� @ 2018.05.29 LSH
                       ])
      then
      begin
         with chr_PdGrow do
         begin

            // Series �� Clear
            // XE7 ���ݿ�. ȫâ��.
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
                  // �Ż��� ü��
                  //------------------------------------------------------
                  if (TpGetGrow.GetOutputDataS('sItem', i) = 'WEIGHT') then
                  begin
   // XE7 ���ݿ�. ȫâ��.
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

                     // [ü��] Vertical Axis
                     for k := C_SERIES_CNT - 7 to C_SERIES_CNT - 3 do
                     begin
   {$IFDEF VER130}
                        // [ü��] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aRightAxis;
                        // [ü��] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [ü��] Vertical Axis
                        Series[k].VertAxis  := aRightAxis;
                        // [ü��] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;



                     // [ü��] ����� Label Location
                     if (i = (TpGetGrow.RowCount - 1)) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Weight(' + IsAgeFlag + ') Chart & Set 100���� label --> ' + IntToStr(i) + '��° Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Wgt3rd X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt3rd Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Wgt10th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt10th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Wgt50th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt50th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Wgt90th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt90th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Wgt97th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Wgt97th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

   {$IFDEF VER130}
                        // ü�� 3Rd
                        lb_Wgt3rd.Top  := SeriesList.Series[C_SERIES_CNT - 3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := SeriesList.Series[C_SERIES_CNT - 3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt3rd.Top  := Series[C_SERIES_CNT - 3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := Series[C_SERIES_CNT - 3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt3rd.Visible := True;

                        // ü�� 5th
                        lb_Wgt5th.Visible := False;

                        // ü�� 10th
   {$IFDEF VER130}
                        lb_Wgt10th.Top  := SeriesList.Series[C_SERIES_CNT - 4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) ;
                        lb_Wgt10th.Left := SeriesList.Series[C_SERIES_CNT - 4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt10th.Top  := Series[C_SERIES_CNT - 4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) ;
                        lb_Wgt10th.Left := Series[C_SERIES_CNT - 4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt10th.Visible := True;

                        // ü�� 25th
                        lb_Wgt25th.Visible := False;

                        // ü�� 50th
   {$IFDEF VER130}
                        lb_Wgt50th.Top  := SeriesList.Series[C_SERIES_CNT - 5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Wgt50th.Left := SeriesList.Series[C_SERIES_CNT - 5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt50th.Top  := Series[C_SERIES_CNT - 5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Wgt50th.Left := Series[C_SERIES_CNT - 5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt50th.Visible := True;

                        // ü�� 75th
                        lb_Wgt75th.Visible := False;

                        // ü�� 90th
   {$IFDEF VER130}
                        lb_Wgt90th.Top  := SeriesList.Series[C_SERIES_CNT - 6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Wgt90th.Left := SeriesList.Series[C_SERIES_CNT - 6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Wgt90th.Top  := Series[C_SERIES_CNT - 6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Wgt90th.Left := Series[C_SERIES_CNT - 6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Wgt90th.Visible := True;

                        // ü�� 95th
                        lb_Wgt95th.Visible := False;

                        // ü�� 97th
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
                  // �Ż��� ����
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
                           // [����] Vertical Axis
                           SeriesList.Series[k].VertAxis  := aLeftAxis;
                           // [����] Horizontal Axis
                           SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                           // [����] Vertical Axis
                           Series[k].VertAxis  := aLeftAxis;
                           // [����] Horizontal Axis
                           Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                        end;
                     end;


                     // [����] ����� Label Location
                     if (i = (TpGetGrow.RowCount * 2 / 3)  - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing HeadCir(' + IsAgeFlag + ') Chart & Set 100���� label --> ' + IntToStr(i) + '��° Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Neo3rd X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo3rd Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Neo10th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo10th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Neo50th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo50th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Neo90th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo90th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Neo97th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Neo97th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

                        // ���� 3Rd
   {$IFDEF VER130}
                        lb_Neo3rd.Top  := SeriesList.Series[C_SERIES_CNT - 8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))- 0.5);
                        lb_Neo3rd.Left := SeriesList.Series[C_SERIES_CNT - 8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo3rd.Top  := Series[C_SERIES_CNT - 8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))- 0.5);
                        lb_Neo3rd.Left := Series[C_SERIES_CNT - 8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo3rd.Visible := True;

                        // ���� 10th
   {$IFDEF VER130}
                        lb_Neo10th.Top  := SeriesList.Series[C_SERIES_CNT - 10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Neo10th.Left := SeriesList.Series[C_SERIES_CNT - 10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo10th.Top  := Series[C_SERIES_CNT - 10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Neo10th.Left := Series[C_SERIES_CNT - 10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo10th.Visible := True;

                        // ���� 50th
   {$IFDEF VER130}
                        lb_Neo50th.Top  := SeriesList.Series[C_SERIES_CNT - 12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) ;
                        lb_Neo50th.Left := SeriesList.Series[C_SERIES_CNT - 12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo50th.Top  := Series[C_SERIES_CNT - 12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) ;
                        lb_Neo50th.Left := Series[C_SERIES_CNT - 12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo50th.Visible := True;

                        // ���� 90th
   {$IFDEF VER130}
                        lb_Neo90th.Top  := SeriesList.Series[C_SERIES_CNT - 14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))- 0.5);
                        lb_Neo90th.Left := SeriesList.Series[C_SERIES_CNT - 14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ELSE}
                        lb_Neo90th.Top  := Series[C_SERIES_CNT - 14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))- 0.5);
                        lb_Neo90th.Left := Series[C_SERIES_CNT - 14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 4);
   {$ENDIF}
                        lb_Neo90th.Visible := True;

                        // ���� 97th
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
                  // �Ż��� ����
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
                     // [����] Vertical Axis
                     for k := 0 to C_SERIES_CNT - 17 do
                     begin
                        if (k = 0) or
                           ((k mod 2) = 0) then
                        begin
   {$IFDEF VER130}
                           // [����] Vertical Axis
                           SeriesList.Series[k].VertAxis  := aLeftAxis;
                           // [����] Horizontal Axis
                           SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                           // [����] Vertical Axis
                           Series[k].VertAxis  := aLeftAxis;
                           // [����] Horizontal Axis
                           Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                        end
                     end;


                     // [����] ����� Label Location
                     if (i = (Trunc(TpGetGrow.RowCount / 3)) - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Height(' + IsAgeFlag + ') Chart & Set 100���� label --> ' + IntToStr(i) + '��° Row value(3rd) = ' + TpGetGrow.GetOutputDataS('sFromAge',i) + ' , ' + TpGetGrow.GetOutputDataS('s3rd', i));
                        {
                        Memo1.Lines.Add('lb_Hgt3rd X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt3rd Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));
                        Memo1.Lines.Add('lb_Hgt10th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt10th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)))));
                        Memo1.Lines.Add('lb_Hgt50th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt50th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)))));
                        Memo1.Lines.Add('lb_Hgt90th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt90th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)))));
                        Memo1.Lines.Add('lb_Hgt97th X��ǥ : ' + FloatToStr(BottomAxis.CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)))));
                        Memo1.Lines.Add('lb_Hgt97th Y��ǥ : ' + FloatToStr(LeftAxis.CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i)))));
                        }

                        // ���� 3Rd
   {$IFDEF VER130}
                        lb_Hgt3rd.Top  := SeriesList.Series[C_SERIES_CNT - 17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)));
                        lb_Hgt3rd.Left := SeriesList.Series[C_SERIES_CNT - 17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt3rd.Top  := Series[C_SERIES_CNT - 17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)));
                        lb_Hgt3rd.Left := Series[C_SERIES_CNT - 17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt3rd.Visible := True;

                        // ���� 5th
                        lb_Hgt5th.Visible := False;

                        // ���� 10th
   {$IFDEF VER130}
                        lb_Hgt10th.Top  := SeriesList.Series[C_SERIES_CNT - 19].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Hgt10th.Left := SeriesList.Series[C_SERIES_CNT - 19].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt10th.Top  := Series[C_SERIES_CNT - 19].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i)));
                        lb_Hgt10th.Left := Series[C_SERIES_CNT - 19].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt10th.Visible := True;

                        // ���� 25th
                        lb_Hgt25th.Visible := False;

                        // ���� 50th
   {$IFDEF VER130}
                        lb_Hgt50th.Top  := SeriesList.Series[C_SERIES_CNT - 21].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Hgt50th.Left := SeriesList.Series[C_SERIES_CNT - 21].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt50th.Top  := Series[C_SERIES_CNT - 21].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i)));
                        lb_Hgt50th.Left := Series[C_SERIES_CNT - 21].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt50th.Visible := True;

                        // ���� 75th
                        lb_Hgt75th.Visible := False;

                        // ���� 90th
   {$IFDEF VER130}
                        lb_Hgt90th.Top  := SeriesList.Series[C_SERIES_CNT - 23].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Hgt90th.Left := SeriesList.Series[C_SERIES_CNT - 23].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ELSE}
                        lb_Hgt90th.Top  := Series[C_SERIES_CNT - 23].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i)));
                        lb_Hgt90th.Left := Series[C_SERIES_CNT - 23].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i)) - 1);
   {$ENDIF}
                        lb_Hgt90th.Visible := True;

                        // ���� 95th
                        lb_Hgt95th.Visible := False;

                        // ���� 97th
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

                     // [����] Vertical Axis
                     for k := 0 to C_SERIES_CNT - 17 do
                     begin
   {$IFDEF VER130}
                        // [����] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aLeftAxis;
                        // [����] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [����] Vertical Axis
                        Series[k].VertAxis  := aLeftAxis;
                        // [����] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;


                     // [����] ����� Label Location
                     if (i = Trunc((TpGetGrow.RowCount / 2)) - 1) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Height(' + IsAgeFlag + ') Chart & Set 100���� label');

   {$IFDEF VER130}
                        Memo1.Lines.Add('lb_Hgt3rd X��ǥ : ' + FloatToStr(SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15));
                        Memo1.Lines.Add('lb_Hgt3rd Y��ǥ : ' + FloatToStr(SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));

                        //------------------------------------------------------
                        // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                        //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
                        //------------------------------------------------------
                        lb_Hgt85th.Visible := False;

                        // ���� 3Rd
                        lb_Hgt3rd.Top  := SeriesList.Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                        lb_Hgt3rd.Left := SeriesList.Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt3rd.Visible := True;

                        // ���� 5th
                        lb_Hgt5th.Top  := SeriesList.Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Hgt5th.Left := SeriesList.Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt5th.Visible := True;

                        // ���� 10th
                        lb_Hgt10th.Top  := SeriesList.Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Hgt10th.Left := SeriesList.Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt10th.Visible := True;

                        // ���� 25th
                        lb_Hgt25th.Top  := SeriesList.Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Hgt25th.Left := SeriesList.Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt25th.Visible := True;

                        // ���� 50th
                        lb_Hgt50th.Top  := SeriesList.Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Hgt50th.Left := SeriesList.Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt50th.Visible := True;

                        // ���� 75th
                        lb_Hgt75th.Top  := SeriesList.Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Hgt75th.Left := SeriesList.Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt75th.Visible := True;

                        // ���� 90th
                        lb_Hgt90th.Top  := SeriesList.Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Hgt90th.Left := SeriesList.Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt90th.Visible := True;

                        // ���� 95th
                        lb_Hgt95th.Top  := SeriesList.Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Hgt95th.Left := SeriesList.Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt95th.Visible := True;

                        // ���� 97th
                        lb_Hgt97th.Top  := SeriesList.Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Hgt97th.Left := SeriesList.Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt97th.Visible := True;
   {$ELSE}
                        Memo1.Lines.Add('lb_Hgt3rd X��ǥ : ' + FloatToStr(Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15));
                        Memo1.Lines.Add('lb_Hgt3rd Y��ǥ : ' + FloatToStr(Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));

                        //------------------------------------------------------
                        // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                        //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
                        //------------------------------------------------------
                        lb_Hgt85th.Visible := False;


                        // ���� 3Rd
                        lb_Hgt3rd.Top  := Series[8].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) - 1 ;
                        lb_Hgt3rd.Left := Series[8].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt3rd.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 5th
                        lb_Hgt5th.Top  := Series[7].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Hgt5th.Left := Series[7].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt5th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 10th
                        lb_Hgt10th.Top  := Series[6].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Hgt10th.Left := Series[6].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt10th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 25th
                        lb_Hgt25th.Top  := Series[5].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Hgt25th.Left := Series[5].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt25th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 50th
                        lb_Hgt50th.Top  := Series[4].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Hgt50th.Left := Series[4].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt50th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 75th
                        lb_Hgt75th.Top  := Series[3].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Hgt75th.Left := Series[3].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt75th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 90th
                        lb_Hgt90th.Top  := Series[2].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Hgt90th.Left := Series[2].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt90th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 95th
                        lb_Hgt95th.Top  := Series[1].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Hgt95th.Left := Series[1].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt95th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ���� 97th
                        lb_Hgt97th.Top  := Series[0].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Hgt97th.Left := Series[0].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Hgt97th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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
                     // Multiple Axis Ȯ�强 ��� �ּ�ó�� @ 2013.11.21 LSH
                     //------------------------------------------------------
                     {
                     // [ü��] Custom Axis ���� �߰�
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

                     // LeftAxis [ü��] �߰�
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
                        // [ü��] Vertical Axis
                        SeriesList.Series[k].VertAxis  := aRightAxis;
                        // [ü��] Horizontal Axis
                        SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                        // [ü��] Vertical Axis
                        Series[k].VertAxis  := aRightAxis;
                        // [ü��] Horizontal Axis
                        Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                     end;


                     // [ü��] ����� Label Location
                     if (i = (TpGetGrow.RowCount - 1)) then
                     begin
                        // Log
                        Memo1.Lines.Add('After Drawing Weight(' + IsAgeFlag + ') Chart & Set 100���� label');

   {$IFDEF VER130}
                        Memo1.Lines.Add('lb_Wgt3rd X��ǥ : ' + FloatToStr(SeriesList.Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 50));
                        Memo1.Lines.Add('lb_Wgt3rd Y��ǥ : ' + FloatToStr(SeriesList.Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));


                        // ü�� 3Rd
                        lb_Wgt3rd.Top  := SeriesList.Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := SeriesList.Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt3rd.Visible := True;

                        // ü�� 5th
                        lb_Wgt5th.Top  := SeriesList.Series[16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Wgt5th.Left := SeriesList.Series[16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt5th.Visible := True;

                        // ü�� 10th
                        lb_Wgt10th.Top  := SeriesList.Series[15].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Wgt10th.Left := SeriesList.Series[15].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt10th.Visible := True;

                        // ü�� 25th
                        lb_Wgt25th.Top  := SeriesList.Series[14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Wgt25th.Left := SeriesList.Series[14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt25th.Visible := True;

                        // ü�� 50th
                        lb_Wgt50th.Top  := SeriesList.Series[13].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Wgt50th.Left := SeriesList.Series[13].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt50th.Visible := True;

                        // ü�� 75th
                        lb_Wgt75th.Top  := SeriesList.Series[12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Wgt75th.Left := SeriesList.Series[12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt75th.Visible := True;

                        // ü�� 90th
                        lb_Wgt90th.Top  := SeriesList.Series[11].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Wgt90th.Left := SeriesList.Series[11].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt90th.Visible := True;


                        // ü�� 95th
                        lb_Wgt95th.Top  := SeriesList.Series[10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Wgt95th.Left := SeriesList.Series[10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt95th.Visible := True;


                        // ü�� 97th
                        lb_Wgt97th.Top  := SeriesList.Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Wgt97th.Left := SeriesList.Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt97th.Visible := True;

   {$ELSE}
                        Memo1.Lines.Add('lb_Wgt3rd X��ǥ : ' + FloatToStr(Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 50));
                        Memo1.Lines.Add('lb_Wgt3rd Y��ǥ : ' + FloatToStr(Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i)))));


                        // ü�� 3Rd
                        lb_Wgt3rd.Top  := Series[17].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s3rd', i))) ;
                        lb_Wgt3rd.Left := Series[17].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt3rd.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ü�� 5th
                        lb_Wgt5th.Top  := Series[16].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s5th', i))) - 5;
                        lb_Wgt5th.Left := Series[16].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt5th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ü�� 10th
                        lb_Wgt10th.Top  := Series[15].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s10th', i))) - 5;
                        lb_Wgt10th.Left := Series[15].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt10th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ü�� 25th
                        lb_Wgt25th.Top  := Series[14].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s25th', i))) - 5;
                        lb_Wgt25th.Left := Series[14].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt25th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ü�� 50th
                        lb_Wgt50th.Top  := Series[13].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s50th', i))) - 5;
                        lb_Wgt50th.Left := Series[13].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt50th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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


                        // ü�� 75th
                        lb_Wgt75th.Top  := Series[12].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s75th', i))) - 5;
                        lb_Wgt75th.Left := Series[12].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt75th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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


                        // ü�� 90th
                        lb_Wgt90th.Top  := Series[11].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s90th', i))) - 5;
                        lb_Wgt90th.Left := Series[11].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt90th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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

                        // ü�� 95th
                        lb_Wgt95th.Top  := Series[10].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s95th', i))) - 5;
                        lb_Wgt95th.Left := Series[10].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt95th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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


                        // ü�� 97th
                        lb_Wgt97th.Top  := Series[9].CalcYPosValue(StrToFloat(TpGetGrow.GetOutputDataS('s97th', i))) - 8;
                        lb_Wgt97th.Left := Series[9].CalcXPosValue(StrToFloat(TpGetGrow.GetOutputDataS('sFromAge',i))) - 15;
                        lb_Wgt97th.Visible := True;

                        // FormShow�� Series�� Pos ��� �ȵǴ� ���� �������� �߰� @ 2016.01.27 LSH
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
                  // XE7 ��ȯ�� Series Area Line Color �� Transparency ����� Index�� ���� (9 -> 17) @ 2016.01.27 LSH
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

                  // [����] Vertical Axis
                  for k := 0 to C_SERIES_CNT - 17 do
                  begin
   {$IFDEF VER130}
                     // [����] Vertical Axis
                     SeriesList.Series[k].VertAxis  := aRightAxis;
                     // [����] Horizontal Axis
                     SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                     // [����] Vertical Axis
                     Series[k].VertAxis  := aRightAxis;
                     // [����] Horizontal Axis
                     Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                  end;


                  // [����] ����� Label Location
                  if (i = (TpGetGrow.RowCount - 1)) then
                  begin
                     // Log
                     Memo1.Lines.Add('After Drawing ' + TpGetGrow.GetOutputDataS('sItem', i) + ' Chart & Set 100���� label');

                     //---------------------------------------------------------
                     // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                     //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
                  // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                  //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
                  // XE7 ��ȯ�� Series Area Line Color �� Transparency ����� Index�� ���� (9 -> 17) @ 2016.01.27 LSH
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
                  // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                  //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
                     // [����/BMI] Vertical Axis
                     SeriesList.Series[k].VertAxis  := aRightAxis;
                     // [����/BMI] Horizontal Axis
                     SeriesList.Series[k].HorizAxis := aBothHorizAxis;
   {$ELSE}
                     // [����/BMI] Vertical Axis
                     Series[k].VertAxis  := aRightAxis;
                     // [����/BMI] Horizontal Axis
                     Series[k].HorizAxis := aBothHorizAxis;
   {$ENDIF}
                  end;


                  // [BMI] ����� Label Location
                  if (i = (TpGetGrow.RowCount - 1)) then
                  begin
                     // Log
                     Memo1.Lines.Add('After Drawing ' + TpGetGrow.GetOutputDataS('sItem', i) + ' Chart & Set 100���� label');

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
                     // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                     //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
                     // BMI 85������� (85th) �߰� @ 2014.10.23 LSH
                     //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
      // ǥ�� Chart Series�� �÷���
      //------------------------------------------------------
      with chr_PdGrow do
      begin
         if (IsAgeFlag = 'NEONATAL') then
         begin
            if (sType3 = 'F') then
            begin
               // ���� :  Coloring
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
               // ���� : Coloring
   {$IFDEF VER130}
               SeriesList.Series[0].SeriesColor  := $00F9F3EC; // ������ $00FEEBE2;  // 97%
               SeriesList.Series[1].SeriesColor  := $00F6EDE3; // ������ $00FDD5C1;  // 95%
               SeriesList.Series[2].SeriesColor  := $00F3EEDA; // ������ $00FCBEA0;  // 90%
               SeriesList.Series[3].SeriesColor  := $00E8DDB6; // ������ $00FBA67D;  // 75%
               SeriesList.Series[4].SeriesColor  := $00DFD49D; // ������ $00F98751;  // 50%
               SeriesList.Series[5].SeriesColor  := $00DFC892; // ������ $00F86B27;  // 25%
               SeriesList.Series[6].SeriesColor  := $00E2B38D; // ������ $00F25509;  // 10%
               SeriesList.Series[7].SeriesColor  := $00DA9B6B; // ������ $00D64A07;  // 5%
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
               Series[0].SeriesColor  := $00F9F3EC; // ������ $00FEEBE2;  // 97%
               Series[1].SeriesColor  := $00F6EDE3; // ������ $00FDD5C1;  // 95%
               Series[2].SeriesColor  := $00F3EEDA; // ������ $00FCBEA0;  // 90%
               Series[3].SeriesColor  := $00E8DDB6; // ������ $00FBA67D;  // 75%
               Series[4].SeriesColor  := $00DFD49D; // ������ $00F98751;  // 50%
               Series[5].SeriesColor  := $00DFC892; // ������ $00F86B27;  // 25%
               Series[6].SeriesColor  := $00E2B38D; // ������ $00F25509;  // 10%
               Series[7].SeriesColor  := $00DA9B6B; // ������ $00D64A07;  // 5%
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
               // ���� :  Coloring
               SeriesList.Series[0].SeriesColor  := $00EEF1FF;  // 97%
               SeriesList.Series[1].SeriesColor  := $00D7DEFF;  // 95%
   {$ELSE}
               // ���� :  Coloring
               Series[0].SeriesColor  := $00EEF1FF;  // 97%
               Series[1].SeriesColor  := $00D7DEFF;  // 95%
   {$ENDIF}


               //---------------------------------------------------------------
               // BMI 85 ������� �߰����� Color �б� @ 2014.10.23 LSH
               //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
               // ���� : Coloring
   {$IFDEF VER130}
               SeriesList.Series[0].SeriesColor  := $00F9F3EC;  // 97%
               SeriesList.Series[1].SeriesColor  := $00F6EDE3;  // 95%
   {$ELSE}
               Series[0].SeriesColor  := $00F9F3EC;  // 97%
               Series[1].SeriesColor  := $00F6EDE3;  // 95%
   {$ENDIF}


               //---------------------------------------------------------------
               // BMI 85 ������� �߰����� Color �б� @ 2014.10.23 LSH
               //       - ���� S/R : GRPD1410002 (PD ��ȿ��)
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
// [Axis] ����-���ɺ� �׸� ǥ�ؼ�����ǥ Axis ����
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
//[����] ��ȿ�� ���� ����� ���� ȭ�� ������ ���� �� �ְ� ����
// 2016.09.07 �ֿ���
//------------------------------------------------------------------------------
procedure TMDRC05F1.FormSetting;
begin

   if Screen.MonitorCount > 1 then
   begin
      if Screen.Monitors[0].MonitorNum = 0 then
      begin
         if Screen.Monitors[0].Width > 1201 then
         begin
            // FormStyle = poDefault�� ���� ���� ��� ����ȯ�� ���� �ؿ� �������� �޶��Ͽ� ��ǥ fixed @ 2018.05.31 LSH (PD ��ȿ�� ��û)
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
// [����] Form onShow Event Handler
//
// Date     : 2013.11.20
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.FormShow(Sender: TObject);
var
   Key : Word;
begin
   // ���κ��� ���� ����ͼ� ó��ȭ�� ������ �� �� �ְ� (PD ��ȿ��)
   // FormSetting �Լ� ���
   // 2016.09.07 �ֿ���
   // [�Ⱦ�] �̱��� �ǹ������� ������ ���� Pivot Ȯ�� ���� @ 2017.12.27 LSH (PD ��ȿ��)
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
   // ������ Debugging ���
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
   // Flow-Sheet (EMR) ȣ��� �Կ� �����̷� ���� �ڵ� Check
   //       - ���� S/R : ASPD1610013 (PD ������)
   //       - 2017.01.17 LSH
   //
   // ȯ�� ������ [�Կ�]�� ���, onShow�� �ڵ� Check
   //       - 2017.01.26 LSH
   //------------------------------------------------------
   cbx_AdmIncluded.Checked := (FsFromForm = 'FLOWSHEET') or (FsPatCls = 'I');


   //------------------------------------------------------
   // ǥ�� D/B ���� �ε��� �� Caption ���� @ 2018.05.28 LSH
   //          - ���� S/R : GRPD1803005 (PD ��ȿ��)
   //------------------------------------------------------
   if (FsStandIdx = 'DDET') then
      self.Caption := '[MDRC05F1] �������� Chart 2007'
   else if (FsStandIDx = '2017') then
      self.Caption := '[MDRC05F1] �������� Chart 2017';


   //------------------------------------------------------
   // �������� ���(ĸ��) ��ư Ȱ��ȭ @ 2020.01.28 LSH
   //          - ���� S/R : ���� (PD �̱��� ex-�Ƿ����)
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
   // ȣ�� ������ ���� ȯ�ڹ�ȣ assign
   //------------------------------------------------------
   fed_PatNo.Text := FsPatNo;
   fed_PatNo.SetFocus;

   Key := 13;


   //------------------------------------------------------
   // ȯ�ڼ��� ���� (Tag)
   //------------------------------------------------------
   if fed_PatNo.Text <> '' then
      fed_PatNo.Tag := 1;


   //------------------------------------------------------
   // ����� ��ȸ
   //------------------------------------------------------
   fcb_MedDept.ItemIndex := GetFlatMedDept(fcb_MedDept);


   //------------------------------------------------------
   // ȯ������ ��ȸ
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
   // Vertical Axis�� Custom Axis Drawing �߰�
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


         // �Ż��� ����ּ� Line Drawing
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




         // ü��/���� ������� ǥ�� �߰� @ 2014.05.26 LSH
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

         // BMI ������� ǥ�� �߰� @ 2014.05.26 LSH
         if (IsAgeFlag = 'BMI') and (fcb_Percent.Checked) then
            DrawPatSeries;


      end;

      {
      // ���� [ü��] Custom Axis Drawing �߰� : ���� Axis�� ü��/���� Display ������ Zoom In/Out ��� ���׷� �ּ�
      LeftAxis.CustomDrawMinMaxStartEnd(PosRightAxis-547,
                                        PosRightAxis,
                                        PosRightAxis,
                                        True,
                                        5,
                                        20,
                                        0.1,
                                        688,
                                        768);

      // ���� [����] Custom Axis Drawing �߰� : ���� Axis�� ü��/���� Display ������ Zoom In/Out ��� ���׷� �ּ�
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
   // Axis Range ���� Refersh Debugging ó�� @ 2013.12.24 LSH
   //-------------------------------------------------------------
   ResetAxisRange;



   with chr_PdGrow do
   begin

      //--------------------------------------------------------------
      // �Ż��� (22��~50��) �������� Chart Axis
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
         end;



      end
      //--------------------------------------------------------------
      // 0���� ~ 36���� �������� Chart Axis
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 105;
            LeftAxis.Minimum                := -10;
            // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  1 => 5 - 2016.01.14 �ֿ���
            LeftAxis.Increment              := 5;
            //LeftAxis.Increment              := 5;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 4;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
         end;

      end
      //--------------------------------------------------------------
      // ��2�� ~ 18�� �������� Chart Axis
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����

         end;


         try
            LeftAxis.Automatic              := False;
            LeftAxis.Maximum                := 190;
            LeftAxis.Minimum                := 60;
            // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  0.1 => 5 - 2016.01.14 �ֿ���
             LeftAxis.Increment              := 5;
            //LeftAxis.Increment              := 5;
            LeftAxis.StartPosition          := 0;
            LeftAxis.EndPosition            := 100;
            LeftAxis.LabelStyle             := talValue;
            LeftAxis.MinorTicks.Visible     := True;
            LeftAxis.MinorTickCount         := 4;
            LeftAxis.MinorTickLength        := 2;
         except
            // Axis Max ~ Min ���� ����
         end;


         LeftAxis.Visible  := True;


         try
            RightAxis.Automatic             := False;
            RightAxis.Maximum               := 135;
            RightAxis.Minimum               := 5;
            // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  0.1 => 5 - 2016.01.14 �ֿ���
            RightAxis.Increment             := 5;
            RightAxis.StartPosition         := 0;
            RightAxis.EndPosition           := 100;
            RightAxis.LabelStyle            := talValue;
            RightAxis.MinorTicks.Visible    := True;
            RightAxis.MinorTickCount        := 4;
            RightAxis.MinorTickLength       := 2;
         except
            // Axis Max ~ Min ���� ����
         end;

      end
      //--------------------------------------------------------------
      // ��0�� ~ 6�� ���� ����� � Chart Axis
      //--------------------------------------------------------------
      else if (IsAgeFlag = 'HEADCIR') then
      begin


         try
            BottomAxis.Automatic            := False;
            BottomAxis.Maximum              := fn_decode([FsStandIdx, 'DDET', C_2007_HEADCIR_MAXRANGE, '2017', C_2017_HEADCIR_MAXRANGE, C_2017_HEADCIR_MAXRANGE]);   // ���� ���ɹ��� ����(2007 vs. 2017)�� ���� �б� @ 2018.05.29 LSH
            BottomAxis.Minimum              := 0;
            BottomAxis.Increment            := 3;
            BottomAxis.StartPosition        := 0;
            BottomAxis.EndPosition          := 100;
            BottomAxis.LabelStyle           := talValue;
            BottomAxis.MinorTicks.Visible   := True;
            BottomAxis.MinorTickCount       := 2;
            BottomAxis.MinorTickLength      := 0;
         except
            // Axis Max ~ Min ���� ����
         end;


         try
            TopAxis.Automatic               := False;
            TopAxis.Maximum                 := fn_decode([FsStandIdx, 'DDET', C_2007_HEADCIR_MAXRANGE, '2017', C_2017_HEADCIR_MAXRANGE, C_2017_HEADCIR_MAXRANGE]);   // ���� ���ɹ��� ����(2007 vs. 2017)�� ���� �б� @ 2018.05.29 LSH
            TopAxis.Minimum                 := 0;
            TopAxis.Increment               := 3;
            TopAxis.StartPosition           := 0;
            TopAxis.EndPosition             := 100;
            TopAxis.LabelStyle              := talValue;
            TopAxis.MinorTicks.Visible      := False;
            TopAxis.MinorTickCount          := 2;
            TopAxis.MinorTickLength         := 0;
         except
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
         end;

         //------------------------------------------------------
         // ���� Axis�� Right Axis�� Custom Drawing���� �����ؼ�
         // ����ϹǷ� Invisible @ 2013.12.23 LSH
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
            // Axis Max ~ Min ���� ����
         end;

      end
      //--------------------------------------------------------------
      // ��2�� ~ 18�� BMI ����� � Chart Axis
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
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
            // Axis Max ~ Min ���� ����
         end;

         //------------------------------------------------------
         // ���� Axis�� Right Axis�� Custom Drawing���� �����ؼ�
         // ����ϹǷ� Invisible @ 2013.12.23 LSH
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
            // Axis Max ~ Min ���� ����
         end;
      end;

   end;
end;





//------------------------------------------------------------------------------
// [Axis Panel] ����-���ɺ� Axis Hide Panel ��ġ ����
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.SetAxisPanel(in_Flag : String);
begin
   // Log
   Memo1.Lines.Add('Call SetAxisPanel Location: ' + in_Flag);

   //------------------------------------------------------
   // ���ɺ� ǥ����ǥ Axis ���� Flag Set
   //------------------------------------------------------
   IsAgeFlag := in_Flag;


   //------------------------------------------------------
   // ����� Label Initalization
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
   lb_Hgt85th.Visible := False;     // BMI 85������� �߰� @ 2014.10.23 LSH
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
   // �Ż���(22�� ~ 50��) �������� Chart Axis
   //--------------------------------------------------------------
   if (IsAgeFlag = 'NEONATAL') then
   begin
      fpn_LeftHgtAxis.Top     := 60; // + C_NEONATAL_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 21;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(13);
      fpn_LeftHgtAxis.Height  := 408;
      fpn_LeftHgtAxis.Caption := '����';
      lb_LeftHgt.Top          := 211 + 147;
      lb_LeftHgt.Left         := 1;
      lb_LeftHgt.Caption      := '����' + #13#10 + ' cm';

      fpn_LeftWgtAxis.Top     := 471 + C_NEONATAL_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 44;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(38);
      fpn_LeftWgtAxis.Height  := 332;
      lb_LeftWgt.Top          := 172; // + C_NEONATAL_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 60;   //  + C_NEONATAL_TOP_OFFSET; // 85;
      fpn_RightHgtAxis.Left   := 608;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(612);
      fpn_RightHgtAxis.Height := 210;
      fpn_RightHgtAxis.Caption:= '����';
      lb_RightHgt.Top         := 110 + 70 + C_NEONATAL_TOP_OFFSET;
      lb_RightHgt.Left        := 0;
      lb_RightHgt.Caption     := '����' + #13#10 + ' cm';

      fpn_RightWgtAxis.Top    := 300 + C_NEONATAL_TOP_OFFSET;
      fpn_RightWgtAxis.Left   := 629;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(635);
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

      lb_Age.Caption := '�����ּ�(��)';

      lb_BornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // 0���� ~ 36���� �������� Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'ZERO2THIRTYSIX') then
   begin
      fpn_LeftHgtAxis.Top     := 65 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 19;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(10);
      fpn_LeftHgtAxis.Height  := 408;
      fpn_LeftHgtAxis.Caption := '����';
      lb_LeftHgt.Top          := 211; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_LeftHgt.Left         := 7;
      lb_LeftHgt.Caption      := 'cm';

      fpn_LeftWgtAxis.Top     := 474 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 43;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(39);
      fpn_LeftWgtAxis.Height  := 332;
      lb_LeftWgt.Top          := 172; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 65 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_RightHgtAxis.Left   := 606;  // XE7 ��ȯ�� LabelsSize = 30 ������� ����(613);
      fpn_RightHgtAxis.Height := 156;
      fpn_RightHgtAxis.Caption:= '����';
      lb_RightHgt.Top         := 86; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_RightHgt.Left        := 6;
      lb_RightHgt.Caption     := 'cm';

      fpn_RightWgtAxis.Top    := 230 + C_ZERO2THIRTYSIX_TOP_OFFSET;
      fpn_RightWgtAxis.Left   := 636;  // XE7 ��ȯ�� LabelsSize = 30 ������� ����(642);
      fpn_RightWgtAxis.Height := 591;
      lb_RightWgt.Top         := 304; // + C_ZERO2THIRTYSIX_TOP_OFFSET;
      lb_RightWgt.Left        := 7;

      lb_RightHead.Top        := 999;
      lb_RightHead.Left       := 999;
      lb_RightHead.Visible    := False;

      lb_RightBmi.Top         := 999;
      lb_RightBmi.Left        := 999;
      lb_RightBmi.Visible     := False;

      lb_Age.Caption := '����(����)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // �Ż��� ����ּ� Ȯ�� Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // ��2�� ~ 18�� �������� Chart Axis
   //--------------------------------------------------------------
   else if (IsAgeFlag = 'TWO2EIGHTTEEN') then
   begin
      fpn_LeftHgtAxis.Top     := 61 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_LeftHgtAxis.Left    := 19;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(15);
      fpn_LeftHgtAxis.Height  := 632;
      fpn_LeftHgtAxis.Caption := '����';

      lb_LeftHgt.Top          := 323; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_LeftHgt.Left         := 7;
      lb_LeftHgt.Caption      := 'cm';

      fpn_LeftWgtAxis.Top     := 694 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_LeftWgtAxis.Left    := 42;   // XE7 ��ȯ�� LabelsSize = 30 ������� ����(38);
      fpn_LeftWgtAxis.Height  := 109;
      lb_LeftWgt.Top          := 60; // + C_TWO2EIGHTTEEN_TOP_OFFSET;
      lb_LeftWgt.Left         := 7;

      fpn_RightHgtAxis.Top    := 63 + C_TWO2EIGHTTEEN_TOP_OFFSET;
      fpn_RightHgtAxis.Left   := 605;  // XE7 ��ȯ�� LabelsSize = 30 ������� ����(610);
      fpn_RightHgtAxis.Height := 252;
      fpn_RightHgtAxis.Caption:= '����';
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

      lb_Age.Caption := '����(��)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // �Ż��� ����ּ� Ȯ�� Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // ���� ǥ����ǥ (��0�� ~ 6�� )  Chart Axis
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

      lb_Age.Caption := '����(����)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // �Ż��� ����ּ� Ȯ�� Panel Close
      //---------------------------------------------------------
      apn_NeoBornWks.Collaps := True;
      apn_NeoBornWks.Visible := False;
   end
   //--------------------------------------------------------------
   // BMI ǥ����ǥ (��2��~18��) Chart Axis
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

      lb_Age.Caption := '����(��)';

      lb_BornWks.Visible := False;

      //---------------------------------------------------------
      // �Ż��� ����ּ� Ȯ�� Panel Close
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
// [��ǥ����] Chart onMouseMove Event Handler
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
   // ��ǥ ���� ���
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
                  tmpYLeftLabel  := '����(cm)';
                  tmpYRightLabel := 'ü��(kg)';

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
                     tmpYRightLabel := '����(cm)'
                  else if (ftc_Chart.ActiveTab = AT_BMI) then
                     tmpYRightLabel := 'BMI(��/��)';

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
      // Vertical Axis�� Custom Axis Drawing �߰�
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
         lb_Hgt85th.Visible := False;     // BMI 85������� �߰� @ 2014.10.23 LSH
         lb_Hgt85th.Top     := 999;       // Zoom-UnZoom �̺�Ʈ�� �ϴܿ� �������� �κ� �������� �߰� @ 2016.01.27 LSH
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
      // Vertical Axis�� Custom Axis Drawing �߰�
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
            lb_Hgt85th.Visible := False;     // BMI 85������� �߰� @ 2014.10.23 LSH
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
            lb_Hgt85th.Visible := True;      // BMI 85������� �߰� @ 2014.10.23 LSH
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
            lb_Hgt85th.Visible := True;     // BMI 85������� �߰� @ 2014.10.23 LSH
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
// [�÷�����] AdvStringGrid onGetAlignment Event Handler
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
// [��ȸ] �μ��� (+�μ��ڵ�) List ��ȸ �Լ�
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
   // Default [PD]�� ȯ�������̷� ��ȸ�ϱ� ���ϴ� �μ� Assign
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


      // ��ȸ�Ǽ� ����
      if iRowCnt = 0 then
      begin
         mdExCode.Free;
         Exit;
      end;


      // �ڵ� ó��
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
// [��ȸ] ��ü���� �̷� ��ȸ
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
      // �����̷� List �ʱ�ȭ
      //------------------------------------------------------
      asg_BodyInfo.ClearRows(1, asg_BodyInfo.RowCount);
      asg_BodyInfo.RowCount := 1;

   except
      // ���ι̻��� Grid Out of Index ���� ����
   end;


   //------------------------------------------------------
   // ���� vs. Ÿ����� ���� ���� ��ȸ����
   //------------------------------------------------------
   if (cbx_OtherDept.Checked = False) then
      sFlag := '3'
   else if (cbx_OtherDept.Checked = True) then
      sFlag := '4';


   sType1 := sFlag;
   sType2 := Trim(fed_PatNo.Text);
   sType3 := fn_nvl(fn_decode([UpperCase((CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))), 'PD', 'PD', '']), fn_nvl(FsMedDept, G_DeptCd));

   // �Կ��� �����̷� ���� @ 2017.01.17 LSH
   if cbx_AdmIncluded.Checked then
      sType4 := 'I'
   else
      sType4 := fn_nvl(FsPatCls,  md_PatCls);

   sType5 := fn_nvl(FsMedDate, md_AdmDate);        // �Կ��� �����̷� �������� �Կ��� �߰� @ 2017.01.17 LSH



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
            stb_Message.Panels[0].Text := '��ϵ� �����̷� �ڷᰡ �����ϴ�.';

            Exit;
         end;

         with asg_BodyInfo do
         begin
            iRowCnt  := TpGetBdInf.RowCount;

            NowRow   := 0;

            for i := 0 to iRowCnt - 1 do
            begin
               //------------------------------------------------------------
               // �Կ��� �����̷�(C_MEDDATE is not null & C_MEDTIME is null)
               // ���� Grid�� ������ �ʵ��� ���� @ 2014.07.08 LSH
               //    - ���� S/R : GRPD1406003 (PD ��ȿ��)
               //    - �Կ�ȯ�� �����̷� D/B ������ ������.
               //------------------------------------------------------------
               // ������� ������ �̷��� ǥ�õ��� �ʴ� �������� ����. - 2014.09.12 dkchoi
               {
               // ���� Row-Index ����
               if (NowRow > 0) then
                  NowRow := NowRow - 1
               else
                  NowRow := NowRow;
               }

               // ���� RowCount�� ����
               //RowCount := RowCount - 1;

               //------------------------------------------------------------
               // [�Կ��̷� ����] unChecked�� �Կ� �����̷� ���� ���� ����
               //          - ���� S/R : ASPD1610013 (PD ������)
               //          - 2017.01.17 LSH
               //------------------------------------------------------------
               if  (
                     (not cbx_AdmIncluded.Checked) and
                     (Trim(TpGetBdInf.GetOutputDataS('sMedDate', i)) <> '') and
                     (Trim(TpGetBdInf.GetOutputDataS('sMedTime', i)) = '')
                   ) or
                   (
                     // ü�� �� ���� ������ (��� 0)�� ���, �����̷� List ǥ�� ���� @ 2016.09.26 LSH (PD ��ȿ��)
                     (StrToFloatDef(TpGetBdInf.GetOutputDataS('sWeight', i), 0) = 0) and
                     (StrToFloatDef(TpGetBdInf.GetOutputDataS('sHeight', i), 0) = 0)
                   ) then
               begin
                  Continue;
               end;


               // ������� ������ �̷��� ǥ�õ��� �ʴ� �������� ����. - 2014.09.12 dkchoi
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
               // Check �ڽ� Set.
               //------------------------------------------------------
               AddCheckBox(C_CHECK, NowRow+FixedRows, False, True);


               // ������� ������ �̷��� ǥ�õ��� �ʴ� �������� ����. - 2014.09.12 dkchoi
               {
               //------------------------------------------------------
               // ���� Row-Index ����
               //------------------------------------------------------
               Inc(NowRow);

               //------------------------------------------------------
               // RowCount ����
               //------------------------------------------------------
               RowCount := NowRow + FixedRows;
               }
            end;

            stb_Message.Panels[0].Text := IntToStr(NowRow + 1) + '���� �����̷��� [��ȸ]�Ǿ����ϴ�.';

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
// [�Լ�] ȯ�� ���� ��ȯ(��/����/�Ѱ�����) �Լ�
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
   // ��ȯ�� �ʱ�ȭ
   //------------------------------------------------------
   Result := '';

   //------------------------------------------------------
   // ��¥��� ���� assign
   //------------------------------------------------------
   v_Year  := StrToInt(CopyByte(in_FromDate, 1, 4));   // YYYY-MM-DD
   v_Month := StrToInt(CopyByte(in_FromDate, 6, 2));
   v_Day   := StrToInt(CopyByte(in_FromDate, 9, 2));

   i_Year  := StrToInt(CopyByte(in_BirtDate, 1, 4));   // YYYYMMDD
   i_Month := StrToInt(CopyByte(in_BirtDate, 5, 2));
   i_Day   := StrToInt(CopyByte(in_BirtDate, 7, 2));

   //------------------------------------------------------
   // �⵵ ���� ���
   //------------------------------------------------------
	d_Year := v_Year - i_Year;


   //------------------------------------------------------
   // ���� ���� ���
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
 	// �ϼ� ���� ���
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
   // �� ������ ���
   //------------------------------------------------------
   if d_Year > 0 then
      d_TotMonth  := d_Year * 12 + d_Month
   else
      d_TotMonth  := d_Month;

   //------------------------------------------------------
   // �ϼ��� �� ������ ȯ�� (�Ҽ��� ù°�ڸ�)
   //------------------------------------------------------
   tmpTransDay := RTrunc_Pos(RRound_Pos(d_Day * 0.03, 1), 1);

   //------------------------------------------------------
   // ��� Data ��ȯ
   //------------------------------------------------------
 	if (in_Flag = 'YEAR') then
      Result := IntToStr(d_Year)
   else if (in_Flag = 'MONTH') then
      Result := IntToStr(d_Month)
   else if (in_Flag = 'TOTMON') then
      Result := FloatToStr(d_TotMonth + tmpTransDay);

end;



//------------------------------------------------------------------------------
// [�Լ�] ��ü���� ������ Data ���� ��ȯ
//         - �Ż��� �������� �Կ��̷� �������� ȯ�� ��������(in_YearInfo)
//           �߰� @ 2017.01.18 LSH (ASPD1610013, PD ������)
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
   // ��ȯ�� �ʱ�ȭ
   //------------------------------------------------------
   Result := '';

   //------------------------------------------------------
   // ��ȿ���� ���� ��ȯ ����
   //------------------------------------------------------
   if (in_DataVal <> '') and
      ((in_DataVal > '0') or
       (CopyByte(in_DataVal, 1, 1) = '.')) then
   begin
      if (in_Flag = 'WEIGHT') then
      begin
         //------------------------------------------------------
         // [ü��] Gram --> KiloGram���� ��ȯ
         //
         //       - �Ż��� �Կ��̷� �������� ü�� 4�ڸ�(��: 1100 g)
         //         ���� 3�ڸ� (��: 980 g) üũ ��ȯ @ 2017.01.17 LSH (ASPD1610013, PD ������)
         //
         //       - ȯ�� ���������� 2���ʰ� ���� Check �Ͽ�
         //         g <-> Kg ��ȯ ���� @ 2017.01.18 LSH
         //------------------------------------------------------
         if (PosByte('.', Trim(in_DataVal)) = 0) and
            (LengthByte(Trim(in_DataVal))  >= 3) then
         begin
            // 2�� �̸� ȯ���� 3�ڸ� �̻� �����Ը� gram ȯ�� ���� @ 2017.01.18 LSH
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
   // ��� Data ��ȯ
   //------------------------------------------------------
 	if (in_Flag = 'WEIGHT') then
      Result := FloatToStr(tmpTransVal);


end;



//------------------------------------------------------------------------------
// [�Լ�] BMI �ڵ� ���
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
   // ��ȯ�� Initialize
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
   // BMI(ü��������) ���
   //------------------------------------------------------
   if iHeight <> 0 then
      iResult :=  Round(( iWeight / ((iHeight/100) * (iHeight/100))) * 10) / 10 // Height�� cm --> m�� ȯ�� �� ��� + �Ҽ��� ��°�ڸ� �ݿø�
   else
      iResult := 0 ;


   //------------------------------------------------------
   // ��ȯ�� ó��
   //------------------------------------------------------
   Result := FormatFloat('#0.######',iResult);

end;


//------------------------------------------------------------------------------
// [��ȸ] FlatButton onClick Event Handler
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
                 PChar('ȯ�ڹ�ȣ �Է���, EnterŰ�� �����ּ���.'),
                 'ȯ�ڹ�ȣ �Է� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   // �������� ȯ�꺸�� �� ȯ�� ��������(�Կ��� ��) ����ȭ�� ���� �ʿ� �ȳ� Pop-up
   if (fcb_ConvertWks.Checked) and
      (FsMedDate = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('[��������] ȯ�꺸��� ����ȭ��(���ʻ��)�� ȯ������ ���� �� ��ȸ �����մϴ�.'),
                 '�������� ȯ�꺸�� ��� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   //------------------------------------------------------
   // ��ü �������� ��ȸ
   //------------------------------------------------------
   SelBodyInfo;

   //------------------------------------------------------
   // ȯ�� �����̷� Draw
   //------------------------------------------------------
   DrawPatSeries;

   //----------------------------------------------------------------
   // ����� �г� On��, ǥ�����Ժ��� ������� ���(Z-Score) Refresh
   //----------------------------------------------------------------
   if apn_NormsDist.Visible then
      CalcZScore2Grid;
end;


//------------------------------------------------------------------------------
// [��ȸ] FlatEditBox onKeyDown Event Handler
//
// Date     : 2013.11.21
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_PatNoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
   //---------------------------------------------------------------------------
   //  �Լ����� : ����Ŭ�Լ��� LPAD�� ���� ����� �Ѵ�.
   //             ���ϴ� SIZE��ŭ ������ ���ϴ� ���ڿ��� ä���.
   //  �� �� �� : 1.ASourceStr(String) : ����ڿ�
   //             2.PadLen(String)     : ä�� size
   //             3.PadStr(String)     : ä�﹮��
   //  ���ϱ��� : LPAD�� String
   //  �� �� �� : A := LPAD('123',7,'0') --> '0000123'
   //  �Լ���ó : SQCOMCLS.pas
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
   // Enter �Է½� �˻�
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
      // ����ȭ�鿡 ���õ� ȯ�������� �� Chart�� ȯ������ ��ġ����
      //       - Flow-Sheet(EMR) �Ż��� �������� ��������
      //         ���� ���� PATNO ������� Chart �����ǵ��� ���� ó�� @ 2017.01.18 LSH (ASPD1610013, PD ������)
      //-------------------------------------------------------------------
      if (md_PatNo <> '') and
         (md_PatNo <> LPad(Trim(fed_PatNo.Text), 8, '0')) and
         (FindForm('MEI700F1') = nil) then
      begin
         MessageBox(Self.Handle,
                    PChar('���� ����ȭ��(�������) ȯ�������� �� Chart�� ȯ�������� ��ġ���� �ʽ��ϴ�.' + #13#10 + #13#10 +
                          'ȯ�������� ��Ȯ����, �Է� �ٶ��ϴ�.'),
                    '������ ȯ������ ����ġ �˸�',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;



      //------------------------------------------------------
      // ȯ������ ��ȸ
      //------------------------------------------------------
      if GetPatNameFlag(fed_PatNo, fed_PatNo, fed_PatName, fed_SexAge, '1') then
      begin
         //------------------------------------------------------
         // Flow-Sheet (EMR) ȣ��� ȯ������ ���� Disabled ����
         //       - ���� S/R : ASPD1610013 (PD ������)
         //       - 2017.01.18 LSH
         //------------------------------------------------------
         fed_PatNo.Enabled       := (FsFromForm <> 'FLOWSHEET');
         cbx_AdmIncluded.Enabled := (FsFromForm <> 'FLOWSHEET');

         //------------------------------------------------------
         // ��24���� �̸� ȯ�ƴ� Default 0~36���� ���� Chart
         //------------------------------------------------------
         if (PosByte('��',   Trim(fed_SexAge.Text)) > 0) or
            ((PosByte('����', Trim(fed_SexAge.Text)) > 0) and
             (CopyByte(Trim(fed_SexAge.Text), 3, PosByte('����', Trim(fed_SexAge.Text)) - 1) < '24')
            ) then
         begin
            // Log
            Memo1.Lines.Add('After GetPatName, 0~36���� Tab Changed');

            ftc_Chart.ActiveTab := AT_ZERO2THIRTYSIX;
         end
         //------------------------------------------------------
         // ��24���� �̻� ȯ�ƴ� Default 2~18�� ���� Chart
         //------------------------------------------------------
         else if (PosByte('Y',   Trim(fed_SexAge.Text)) > 0) or
                 (PosByte('��',  Trim(fed_SexAge.Text)) > 0) then
         begin
            // Log
            Memo1.Lines.Add('After GetPatName, 2~18�� Tab Changed');


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
   // ȯ�� �⺻���� ��ȸ
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
   // ��ü �������� ��ȸ
   //---------------------------------------------------------
   SelBodyInfo;



   //---------------------------------------------------------
   // ȯ�� �����̷� Draw
   //---------------------------------------------------------
   DrawPatSeries;
   }

end;



//------------------------------------------------------------------------------
// [��ȸ] FlatEditBox onChange Event Handler
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
// [��ȸ] FlatEditBox onEnter Event Handler
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
   // ǥ�����Դ������� ����� ������ Tab-Changed�� ���� @ 2014.05.26 LSH
   if (fcb_Percent.Checked) then
      fcb_Percent.Checked := False;


   case ftc_Chart.ActiveTab of

      AT_NEONATAL :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : �Ż���');

            //------------------------------------------------------
            // �Ż��� ���� �������� ȯ�꺸�� Check-Box Set-On.
            //          - ���� S/R : ASPD1610013 (PD ������)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 20;
            fcb_ConvertWks.Left     := 531;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // ����ּ� �ʱ�ȭ
            //------------------------------------------------------
            varBornWks := 0;
            varBornDay := 0;

            //------------------------------------------------------
            // ����-�ּ��� Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('NEONATAL');

            //------------------------------------------------------
            // ����-�ּ��� Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('NEONATAL',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));

            //------------------------------------------------------
            // ����-�ּ��� �׸� ǥ�ؼ�����ǥ ��ȸ
            //------------------------------------------------------
            GetStandardMarking('7',
                               'NBINF',
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');

            // XE7 ��ȯ�� FormShow�� Axis Ʋ������ �κ� �������� �ʱ�ȭ ���� @ 2016.01.27 LSH
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
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
               end;
            end;

         end;

      AT_ZERO2THIRTYSIX :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 0~36����');

            //------------------------------------------------------
            // 0~36���� ���� �������� ȯ�꺸�� Check-Box Set-Off.
            //          - ���� S/R : ASPD1610013 (PD ������)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // ����-���ɺ� Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('ZERO2THIRTYSIX');



            //------------------------------------------------------
            // ����-���ɺ� Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('ZERO2THIRTYSIX',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));



            //------------------------------------------------------
            // ����-���ɺ� �׸� ǥ�ؼ�����ǥ ��ȸ
            //------------------------------------------------------
            GetStandardMarking('1',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');

            // XE7 ��ȯ�� FormShow�� Axis Ʋ������ �κ� �������� �ʱ�ȭ ���� @ 2016.01.27 LSH
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
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
               end;


               try
                  LeftAxis.Automatic              := False;
                  LeftAxis.Maximum                := 105;
                  LeftAxis.Minimum                := -10;
                  // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  1 => 5 - 2016.01.14 �ֿ���
                  LeftAxis.Increment              := 5;
                  //LeftAxis.Increment              := 5;
                  LeftAxis.StartPosition          := 0;
                  LeftAxis.EndPosition            := 100;
                  LeftAxis.LabelStyle             := talValue;
                  LeftAxis.MinorTicks.Visible     := True;
                  LeftAxis.MinorTickCount         := 4;
                  LeftAxis.MinorTickLength        := 2;
               except
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
               end;
            end;

         end;

      AT_TWO2EIGHTTEEN :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : 2~18��');

            //------------------------------------------------------
            // 2~18�� ���� �������� ȯ�꺸�� Check-Box Set-Off.
            //          - ���� S/R : ASPD1610013 (PD ������)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // ����-���ɺ� Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('TWO2EIGHTTEEN');


            //------------------------------------------------------
            // ����-���ɺ� Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('TWO2EIGHTTEEN',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));



            //------------------------------------------------------
            // ����-���ɺ� �׸� ǥ�ؼ�����ǥ ��ȸ
            //------------------------------------------------------
            GetStandardMarking('2',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               '');




            // XE7 ��ȯ�� FormShow�� Axis Ʋ������ �κ� �������� �ʱ�ȭ ���� @ 2016.01.27 LSH
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
                  // Axis Max ~ Min ���� ����
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
                  // Axis Max ~ Min ���� ����
               end;


               try
                  LeftAxis.Automatic              := False;
                  LeftAxis.Maximum                := 190;
                  LeftAxis.Minimum                := 60;
                  // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  0.1 => 5 - 2016.01.14 �ֿ���
                   LeftAxis.Increment              := 5;
                  //LeftAxis.Increment              := 5;
                  LeftAxis.StartPosition          := 0;
                  LeftAxis.EndPosition            := 100;
                  LeftAxis.LabelStyle             := talValue;
                  LeftAxis.MinorTicks.Visible     := True;
                  LeftAxis.MinorTickCount         := 4;
                  LeftAxis.MinorTickLength        := 2;
               except
                  // Axis Max ~ Min ���� ����
               end;


               LeftAxis.Visible  := True;


               try
                  RightAxis.Automatic             := False;
                  RightAxis.Maximum               := 135;
                  RightAxis.Minimum               := 5;
                  // xe7 ���� ȭ�鿡�� ��ǥ �� ���� �ʾ� ����  0.1 => 5 - 2016.01.14 �ֿ���
                  RightAxis.Increment             := 5;
                  RightAxis.StartPosition         := 0;
                  RightAxis.EndPosition           := 100;
                  RightAxis.LabelStyle            := talValue;
                  RightAxis.MinorTicks.Visible    := True;
                  RightAxis.MinorTickCount        := 4;
                  RightAxis.MinorTickLength       := 2;
               except
                  // Axis Max ~ Min ���� ����
               end;
            end;

         end;

      AT_HEADCIR :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : ����');

            //------------------------------------------------------
            // 0~36���� ����� �������� ȯ�꺸�� Check-Box Set-Off.
            //          - ���� S/R : ASPD1610013 (PD ������)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;


            //------------------------------------------------------
            // ����-���ɺ� Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('HEADCIR');

            //------------------------------------------------------
            // ����-���ɺ� Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('HEADCIR',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));


            //------------------------------------------------------
            // ����-���ɺ� �׸� ���� ����� ǥ����ǥ ��ȸ
            //------------------------------------------------------
            GetStandardMarking('5',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               'HEADCIR');

         end;

      AT_BMI :

         begin
            // Log
            Memo1.Lines.Add('Call onTabChanged : BMI');

            //------------------------------------------------------
            // 2~18�� BMI� �������� ȯ�꺸�� Check-Box Set-Off.
            //          - ���� S/R : ASPD1610013 (PD ������)
            //          - 2017.01.17 LSH
            //------------------------------------------------------
            fcb_ConvertWks.Top      := 999;
            fcb_ConvertWks.Left     := 999;
            fcb_ConvertWks.Checked  := False;

            //------------------------------------------------------
            // ����-���ɺ� Axis Panel Location
            //------------------------------------------------------
            SetAxisPanel('BMI');

            //------------------------------------------------------
            // ����-���ɺ� Chart Axis Set
            //------------------------------------------------------
            SetStandardAxis('BMI',
                            CopyByte(Trim(fed_SexAge.Text), 1, 1));

            //------------------------------------------------------
            // ����-���ɺ� �׸� BMI ����� ǥ����ǥ ��ȸ
            //------------------------------------------------------
            GetStandardMarking('6',
                               'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                               CopyByte(Trim(fed_SexAge.Text), 1, 1),
                               'BMI');
         end;
   end;


   //-------------------------------------------------------
   // ȯ�� �⺻���� ��ȸ
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
   // ��ü �������� ��ȸ
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // ȯ�� �����̷� Draw
   //---------------------------------------------------------
   DrawPatSeries;


end;


//------------------------------------------------------------------------------
// [��ġ����] FlatCheckBox onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fcb_NumberClick(Sender: TObject);
begin
   //------------------------------------------------------------------
   // ȯ�� ��ü���� ����� ��ǥ ��ȯ���� @ 2014.05.22 LSH
   //------------------------------------------------------------------
   { -- Grid ǥ�Ⱑ �ƴ�, Chart�� ǥ����ȯ�� ���� �ּ� @ 2014.05.26 LSH
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
         // Data ��ġ ǥ��
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
         // Data ��ġ ǥ��
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATWGT].Marks.Visible     := fcb_Number.Checked;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := fcb_Number.Checked;
         series[C_SERIES_IDX_PATBMI].Marks.Visible     := fcb_Number.Checked;
      end;
   end;
end;


//------------------------------------------------------------------------------
// [%����] FlatCheckBox onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fcb_PercentClick(Sender: TObject);
begin
   //------------------------------------------------------------------
   // ȯ�� ��ü���� ����� ��ǥ ��ȯ���� @ 2014.05.22 LSH
   //------------------------------------------------------------------
   if CheckDeptBtn('MDRC05_PER', G_DeptCd) then
   begin
      if fcb_Percent.Checked then
         fcb_Number.Checked := False;

      // ������� ǥ�� ��ȸ
      fbt_SearchClick(Sender);


      // Grid ǥ�Ⱑ �ƴ�, Chart�� ǥ����ȯ�� ���� �ּ� @ 2014.05.26 LSH
      // Grid ǥ�� ���û�� ���� �ּ����� @ 2014.07.08 LSH
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
         // ǥ�����Ժ��� ������� ���(Z-Score) �� Grid ǥ��
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
         // Data % ǥ��
         //------------------------------------------------------
         series[C_SERIES_IDX_PATHGT].Marks.Visible     := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATWGT].Marks.Visible     := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := fcb_Percent.Checked;
         series[C_SERIES_IDX_PATBMI].Marks.Visible     := fcb_Percent.Checked;
      end;
   end;
end;


//------------------------------------------------------------------------------
// [����] Form onCreate Event Handler
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
// [��ǥ����] FlatCheckBox onClick Event Handler
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
// [�����߰�/����] FlatSpeedButton onClick Event Handler
//
// Date     : 2013.11.22
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fsbt_AddClick(Sender: TObject);
begin

   // Log
   Memo1.Lines.Add('Call ���� Add onClick');

   if (Trim(fed_PatNo.Text) = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('ȯ�ڹ�ȣ �Է���, EnterŰ�� �����ּ���.'),
                 'ȯ�ڹ�ȣ �Է� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;



   stb_Message.Panels[0].Text := '';



   //-----------------------------------------------------------------
   // ���� ���
   //-----------------------------------------------------------------
   if (asg_BodyInfo.Cells[C_CHECK, asg_BodyInfo.Row] = 'Y') then
   begin
      if (asg_BodyInfo.Cells[C_MEDDEPT, asg_BodyInfo.Row] <> CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))  then
      begin
         MessageBox(Self.Handle,
                    PChar('Ÿ������ ������ Data�� ������ �Ұ����մϴ�.'),
                    'Ÿ ����� ��ü���� �������� �˸�',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;

      if (asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row] = '') then
      begin
         MessageBox(Self.Handle,
                    PChar('�� OCS ȭ�鿡�� �Է��� ��ü���� Data�� ������ �����մϴ�.'),
                    'Ÿ �ý��� ��ü���� �������� �˸�',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;

      //-----------------------------------------------------------------
      // Caption
      //-----------------------------------------------------------------
      apn_PdBodAdd.Caption.Text := '��ü���� ����';


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
         Cells[1, 7] := '�ʼ��׸� �Է��� �� ĭ�� ��Ϲ�ư�� ������.';
      end;
   end
   else
   //-----------------------------------------------------------------
   // �ű� ���
   //-----------------------------------------------------------------
   begin
      // Caption
      apn_PdBodAdd.Caption.Text := '��ü���� �ű��߰�';

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
         Cells[1, 7] := '�ʼ��׸� �Է��� �� ĭ�� ��Ϲ�ư�� ������.';
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
// [�ʱ�ȭ] AdvStringGrid onClick Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoClick(Sender: TObject);
begin
   stb_Message.Panels[0].Text := '';
end;


//------------------------------------------------------------------------------
// [�ʱ�ȭ] Chart onClick Event Handler
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
// [�÷�����] AdvStringGrid onGetAlignment Event Handler
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
// [�÷�Type] AdvStringGrid onGetEditorType Event Handler
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
// [LF����] AdvStringGrid onKeyPress Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddKeyPress(Sender: TObject; var Key: Char);
begin
   //--------------------------------------------------------
   // ���� �Է½�, ���� Cell ���࿩�� �б�
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
   // ����üũ(�ǽ��л� ��� �Ұ�) 2012.11.05 wcw
   if CheckAuthority('PRINT', '', '', '', self.Name) = False then Exit;

   // ��Ʈ �� �������� (��ü frame) �̹��� ����
   SaveComponentImg(Sender);


   // ����Ʈ ���� Check
   if (IsNotPrinterReady) then exit;



end;

//------------------------------------------------------------------------------
// [��ư����] AdvStringGrid onEditingDone Event Handler
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
                   '�� �����̷��� ����Ͻ÷��� ���⸦ ��������.',
                   haBeforeText,
                   vaCenter);
      end
      else
         RemoveButton(Col, 7);
   end;
end;


//------------------------------------------------------------------------------
// [��������] AdvStringGrid onCanEditCell Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_PdBodAddCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
   //---------------------------------------------------------------------
   // 1. Check (Frame �׸��� ����)
   //---------------------------------------------------------------------
   if (ACol < 1) then
   begin
      Exit;
   end;

   //---------------------------------------------------------------------
   // 2. Edit ����
   //---------------------------------------------------------------------
   if (PosByte('�ű�', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      if (ACol = 1)    and                                  // Frame ��� ����
         (  (ARow = 2) or                                   // ����� ����
            (ARow = 7)                                      // ��� Button
         ) then
      begin
         CanEdit := False;
      end
      else
         CanEdit := True;
   end
   else if (PosByte('����', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      if (ACol = 1)    and                                  // Frame ��� ����
         (  (ARow = 0) or                                   // �������� ����
            (ARow = 1) or                                   // �����ð� ����
            (ARow = 2) or                                   // �����   ����
            (ARow = 7)                                      // ��� Button
         ) then
      begin
         CanEdit := False;
      end
      else
         CanEdit := True;

   end;
end;


//------------------------------------------------------------------------------
// [����] AdvStrinGrid onButtonClick Event Handler
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
   Memo1.Lines.Add('Call �����̷� onButtonClick');

   //-------------------------------------------------------------------
   // Check
   //    - �ӻ�ǽ��л� OCS ���ٱ���(����/����/����/���/����) ����
   //-------------------------------------------------------------------
   if CheckAuthority('SAVE', '', '', '', self.Name) = False then Exit;




   //-------------------------------------------------------------------
   // ȯ�� ��������(�Ǵ� �Կ�����) ���� assign (�ɼ�)
   //-------------------------------------------------------------------
   if (PosByte('�ű�', apn_PdBodAdd.Caption.Text) > 0) then
   begin
      // �ܷ� �����̷�(MEDDATE & MEDTIME) �Ǵ� �Կ��̷�(ADMDATE) �����ִ� ȯ���� ���
      if (FsMedDate <> '') then
      begin
         tmpMedDate := FsMedDate;      // EMR ���� �� Ÿ �ý��� �������� Global var. ��ȯ @ 2017.01.17 LSH
         tmpMedTime := FsMedTime;      // EMR ���� �� Ÿ �ý��� �������� Global var. ��ȯ @ 2017.01.17 LSH
      end
      // �ܷ� �����̷� �Ǵ� �Կ��̷� ���� [ó������ȸ] - [�������� Chart] ���� �����̷� ��Ͻ�
      // �������� [�ܷ� ������]��, �����ð��� [�ܷ� ����ð�]���� ���/���� @ 2017.02.24 LSH (PD ��ȿ�� ��û)
      else
      begin
         tmpMedDate := asg_PdBodAdd.Cells[1, 0];
         tmpMedTime := asg_PdBodAdd.Cells[1, 0] + ' ' + asg_PdBodAdd.Cells[1, 1];
      end;
   end
   else if (PosByte('����', apn_PdBodAdd.Caption.Text) > 0) then
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
                    PChar('��������/�ð�/����� �׸��� �ʼ��Է� �׸��Դϴ�.'),
                    '��ü���� �̷� ����� �ʼ��Է� Ȯ��',
                    MB_OK + MB_ICONWARNING);

         Exit;
      end;
   end;




   //-------------------------------------------------------------------
   // ���� ��� ���� Ȯ��
   //-------------------------------------------------------------------
   iChoice := MessageBox(Self.Handle,
                         PChar('�ۼ��Ͻ� �����̷��� ����Ͻðڽ��ϱ�?'),
                         '��ü���� ��� Ȯ��',
                         MB_YESNO + MB_ICONQUESTION);


   if iChoice = IDNO then Exit;


   iCnt := 0;



   //-------------------------------------------------------------------
   // ��������/�����ð� Assign
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
                         , 'S_STRING1' , vPatNo            // ȯ�ڹ�ȣ
                         , 'S_STRING2' , vMedDept          // �����
                         , 'S_STRING3' , vRgtDate          // ��������
                         , 'S_STRING4' , vRgtTime          // �����Ͻ�
                         , 'S_STRING5' , vMedDate          // ����(�Կ�)����
                         , 'S_STRING6' , vMedTime          // ����(�Կ�)����
                         , 'S_STRING8' , vHeight           // ����
                         , 'S_STRING9' , vWeight           // ü��
                         , 'S_STRING10', vHeadCir          // ����
                         , 'S_STRING13', vRemark           // Ư�����
                         , 'S_STRING20', vDelDate          // ��������
                         , 'S_STRING21', vEditId           // ������ ID
                         , 'S_STRING22', vEditIp           // ������ IP
                         ] ) then
      begin
         stb_Message.Panels[0].Text := '�����̷��� ���������� [���]�Ǿ����ϴ�.';
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
   // 4. �����̷� ����ȸ
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // 5. ȯ�� �����̷� Draw
   //---------------------------------------------------------
   DrawPatSeries;

end;



//------------------------------------------------------------------------------
// [��������] AdvStringGrid onCanEditCell Event Handler
//
// Date     : 2013.11.25
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.asg_BodyInfoCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
   //---------------------------------------------------------------------
   // 1. Check (Frame �׸��� ����)
   //---------------------------------------------------------------------
   if (ARow = 0) then
   begin
      Exit;
   end;

   //---------------------------------------------------------------------
   // 2. Edit ����
   //---------------------------------------------------------------------
   if (ARow > 0)    and                                  // Frame ��� ����
      (ACol = C_CHECK)                                   // Check-Box Button
   then
   begin
      CanEdit := True;
   end
   else
      CanEdit := False;
end;


//------------------------------------------------------------------------------
// [��ƮDraw] ȯ�� �����̷� Charting ǥ��
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
            // �Ż��� ��ȣ���������� ����ּ� ���� ��ȸ
            // ���� ����̷� ������, ����ּ� Ȯ�� Panel-On.
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
                  // Invisible Comp. Focus ���� ����
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
                  // �Կ��� �����̷�(C_MEDDATE is not null & C_MEDTIME is null)
                  // Charting�� ������ �ʵ��� ���� @ 2014.02.07 LSH
                  //    - ���� PD ��ȿ�� ��û
                  //------------------------------------------------------------
                  if (Cells[C_MEDDATE, j] <> '') and
                     (Cells[C_MEDTIME, j] = '') then
                  begin
                     //---------------------------------------------------------
                     // [�Կ��̷� ����] unChecked�� �Կ� �����̷� ���� ���� ����
                     //          - ���� S/R : ASPD1610013 (PD ������)
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
                        // [����] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);


                        // [����] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [����] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;
                     end;


                     if (i = C_WEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [ü��] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATWGT].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [ü��] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [ü��] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;
                     end;


                     if (i = C_HEADCIR) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [����] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATHEADCIR].AddXy(StrToFloat(CalcNeoWks(varBirtdate, DelChar(Cells[C_RGTDATE, j], '-'))),
                                                              StrToFloat(Cells[C_HEADCIR, j]),
                                                              '',
                                                              chr_PdGrow.Series[C_SERIES_IDX_PATHEADCIR].SeriesColor);

                        // [����] Vertical Axis
                        Series[C_SERIES_IDX_PATHEADCIR].VertAxis  := aLeftAxis;

                        // [����] Horizontal Axis
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
                        // [����] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);

                        // [����] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [����] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // ������� ��� �� Text Drawing @ 2014.05.26 LSH
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
                        // [ü��] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATWGT].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [ü��] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [ü��] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // ������� ��� �� Text Drawing @ 2014.05.26 LSH
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
                     // 2~18�� ������� Chart ����� 18�� �ʰ� �������� ����� ǥ�� ����
                     //          - ��û : PD ��ȿ��
                     //          - D/B���� 18������ �ۿ� LMS ���� �����Ƿ�, Skip.
                     //          - 2016.09.08 LSH
                     //
                     // �Ż��� �� �Ҿ� �Կ� �����̷� �������� 2~18�� �ƴѰ��, ����� ǥ�� ����
                     //          - ���� S/R : ASPD1610013 (PD ������)
                     //          - 2017.01.17 LSH
                     //---------------------------------------------------------
                     {
                     if
                        (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and
                        (StrToIntDef(Cells[C_MONTH, j], 0) >  0)  then
                     }
                     if (
                           (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and   // �� 18�� �ʰ��̰ų�
                           (StrToIntDef(Cells[C_MONTH, j], 0) >  0)
                        ) or
                        (StrToIntDef(Cells[C_YEAR, j], 0) <  2) then       // �� 2�� �̸��� ���, ǥ�� ����
                     begin
                        Continue;
                     end;

                     if (i = C_HEIGHT) and
                        (Trim(Cells[i, j]) <> '')  and
                        (Trim(Cells[i, j]) <> '0') and
                        (Trim(Cells[i, j]) <> '00.0') then
                     begin
                        // [����] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATHGT].AddXy(StrToFloat(Cells[C_TOTMONTH, j]) / 12,
                                                          StrToFloat(Cells[C_HEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATHGT].SeriesColor);


                        // [����] Vertical Axis
                        Series[C_SERIES_IDX_PATHGT].VertAxis  := aLeftAxis;

                        // [����] Horizontal Axis
                        Series[C_SERIES_IDX_PATHGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // ������� ��� �� Text Drawing @ 2014.05.26 LSH
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
                        // [ü��] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATWGT].AddXy((StrToFloat(Cells[C_TOTMONTH, j]) / 12),
                                                          StrToFloat(Cells[C_WEIGHT, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATWGT].SeriesColor);

                        // [ü��] Vertical Axis
                        Series[C_SERIES_IDX_PATWGT].VertAxis  := aRightAxis;

                        // [ü��] Horizontal Axis
                        Series[C_SERIES_IDX_PATWGT].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // ������� ��� �� Text Drawing @ 2014.05.26 LSH
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
                        // [����] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATHEADCIR].AddXy(StrToFloat(Cells[C_TOTMONTH,j]),
                                                              StrToFloat(Cells[C_HEADCIR, j]),
                                                              '',
                                                              chr_PdGrow.Series[C_SERIES_IDX_PATHEADCIR].SeriesColor);

                        // [����] Vertical Axis
                        Series[C_SERIES_IDX_PATHEADCIR].VertAxis  := aRightAxis;

                        // [����] Horizontal Axis
                        Series[C_SERIES_IDX_PATHEADCIR].HorizAxis := aBothHorizAxis;
                     end
                     else if (IsAgeFlag = 'BMI') then
                     begin
                        //------------------------------------------------------
                        // 2~18�� ������� Chart ����� 18�� �ʰ� �������� ����� ǥ�� ����
                        //          - ��û : PD ��ȿ��
                        //          - D/B���� 18������ �ۿ� LMS ���� �����Ƿ�, Skip.
                        //          - 2016.09.08 LSH
                        //
                        // �Ż��� �� �Ҿ� �Կ� �����̷� �������� 2~18�� �ƴѰ��, ����� ǥ�� ����
                        //          - ���� S/R : ASPD1610013 (PD ������)
                        //          - 2017.01.17 LSH
                        //------------------------------------------------------
                        {
                        if
                           (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and
                           (StrToIntDef(Cells[C_MONTH, j], 0) >  0)  then
                        }

                        if (
                              (StrToIntDef(Cells[C_YEAR,  j], 0) >= 18) and   // �� 18�� �ʰ��̰ų�
                              (StrToIntDef(Cells[C_MONTH, j], 0) >  0)
                           ) or
                           (StrToIntDef(Cells[C_YEAR, j], 0) <  2) then       // �� 2�� �̸��� ���, ǥ�� ����
                        begin
                           Continue;
                        end;


                        // [BMI] ȯ�� �����̷�
                        Series[C_SERIES_IDX_PATBMI].AddXy(StrToFloat(Cells[C_TOTMONTH, j]) / 12,
                                                          StrToFloat(Cells[C_BMI, j]),
                                                          '',
                                                          chr_PdGrow.Series[C_SERIES_IDX_PATBMI].SeriesColor);

                        // Log
                        Memo1.Lines.Add('BMI Drawing ��ǥ : ' + FloatToStr(StrToFloat(Cells[C_TOTMONTH, j]) / 12) + ' , ' + Cells[C_BMI, j]);

                        // [BMI] Vertical Axis
                        Series[C_SERIES_IDX_PATBMI].VertAxis  := aRightAxis;

                        // [BMI] Horizontal Axis
                        Series[C_SERIES_IDX_PATBMI].HorizAxis := aBothHorizAxis;

                        //------------------------------------------------------
                        // ������� ��� �� Text Drawing @ 2014.05.26 LSH
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
   // �Ż��� ����ּ� Line Drawing
   //-------------------------------------------------------------------
   if (IsAgeFlag = 'NEONATAL') then
      NeoBornAfterDraw;


   //-------------------------------------------------------------------
   // Data ��ġ ǥ��
   //-------------------------------------------------------------------

   chr_PdGrow.series[C_SERIES_IDX_PATHGT].Marks.Visible     := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATWGT].Marks.Visible     := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATHEADCIR].Marks.Visible := (fcb_Number.Checked);
   chr_PdGrow.series[C_SERIES_IDX_PATBMI].Marks.Visible     := (fcb_Number.Checked);
end;


//------------------------------------------------------------------------------
// [����] FlatButton onClick Event Handler
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
   Memo1.Lines.Add('Call �����̷� Del onClick');

   //-------------------------------------------------------------------
   // 1-1. Check
   //    - �ӻ�ǽ��л� OCS ���ٱ���(����/����/����/���/����) ����
   //-------------------------------------------------------------------
   if CheckAuthority('SAVE', '', '', '', self.Name) = False then Exit;




   if (Trim(fed_PatNo.Text) = '') then
   begin
      MessageBox(Self.Handle,
                 PChar('ȯ�ڹ�ȣ �Է���, EnterŰ�� �����ּ���.'),
                 'ȯ�ڹ�ȣ �Է� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;


   //-----------------------------------------------------------------
   // ���� ��� ��ȿ�� Check
   //-----------------------------------------------------------------
   if (asg_BodyInfo.Cells[C_CHECK,   asg_BodyInfo.Row] = 'Y') and
      (asg_BodyInfo.Cells[C_MEDDEPT, asg_BodyInfo.Row] <> CopyByte(Trim(fcb_MedDept.Text), 1, PosByte('[', Trim(fcb_MedDept.Text)) - 2))  then
   begin
      MessageBox(Self.Handle,
                 PChar('Ÿ������ ������ Data�� ������ �Ұ����մϴ�.'),
                 'Ÿ ����� ��ü���� �������� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;

   if (asg_BodyInfo.Cells[C_CHECK,   asg_BodyInfo.Row] = 'Y') and
      (asg_BodyInfo.Cells[C_RGTTIME, asg_BodyInfo.Row] = '')  then
   begin
      MessageBox(Self.Handle,
                 PChar('�� OCS ȭ�鿡�� �Է��� ��ü���� Data�� ������ �����մϴ�.'),
                 'Ÿ �ý��� ��ü���� �������� �˸�',
                 MB_OK + MB_ICONWARNING);

      Exit;
   end;


   //-----------------------------------------------------------------
   // ���� ��� ���� Ȯ��
   //-----------------------------------------------------------------
   iChoice := MessageBox(Self.Handle,
                         PChar('�����Ͻ� �����̷��� �����Ͻðڽ��ϱ�?'),
                         '��ü���� ���� Ȯ��',
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
                         , 'S_STRING1' , vPatNo            // ȯ�ڹ�ȣ
                         , 'S_STRING2' , vMedDept          // �����
                         , 'S_STRING3' , vRgtDate          // ��������
                         , 'S_STRING4' , vRgtTime          // �����Ͻ�
                         , 'S_STRING20', vDelDate          // ��������
                         , 'S_STRING21', vEditId           // ������ ID
                         , 'S_STRING22', vEditIp           // ������ IP
                         ] ) then
      begin
         stb_Message.Panels[0].Text := '�����̷��� ���������� [����]�Ǿ����ϴ�.';
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
   // 4. �����̷� ����ȸ
   //---------------------------------------------------------
   SelBodyInfo;


   //---------------------------------------------------------
   // 5. ȯ�� �����̷� Draw
   //---------------------------------------------------------
   DrawPatSeries;

end;

//------------------------------------------------------------------------------
// [�̹���View] FlatButton onClick Event Handler
//
// Date     : 2013.11.27
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_NeoChartClick(Sender: TObject);
var
   FForm : TForm;
begin
   //---------------------------------------------------------
   // ���� FTP �̹��� ��� (BPL) ȣ��
   //---------------------------------------------------------
   FForm := BplFormCreate('MDN990F1');


   //---------------------------------------------------------
   // �Ż��ƿ� (2008 Fenton WHO ǥ��)
   //---------------------------------------------------------
   SetBplStrProp(FForm.Name, 'Prop_FromForm', 'MDN635F2');     // �Ż��� ��ȣ���������� ȣ�� ���
   SetBplStrProp(FForm.Name, 'Prop_ImgName' , 'FENTON2008');   // FTP �̹��� �̸�

   MComFormShow(FForm);
end;



//------------------------------------------------------------------------------
// [����] FlatButton onClick Event Handler
//
// Date     : 2013.11.27
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fbt_CloseClick(Sender: TObject);
begin
   Close;
end;


//------------------------------------------------------------------------------
// [�̷¼���] AdvStringGrid onDblClick Event Handler
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
// [Hintǥ��] AdvStringGrid onMouseMove Event Handler
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
   // �� Mouse ������ ��ǥ �޾ƿ���
   //-----------------------------------------------------------------
   asg_BodyInfo.MouseToCell(X,
                            Y,
                            NowCol,
                            NowRow);

   //-----------------------------------------------------------------
   // Ư����� Hint
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
// NeoNatal �����ַ� ��� �Լ�
//    - �������, ���� ������ڸ� �޾Ƽ� �����ַ��� ���.
//    - �Ż��� �Կ� �����̷� �������� �����ַ� ������ �߰� @ 2017.01.17 LSH (ASPD1610013, PD ������)
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

   iDiffDay1, iDiffDay2, iTmpPeriod, iAddingWks, iAddingDay, iAddedWks, iAddedDay : Integer;      // �����ּ� ������� var. �߰� @ 2017.01.17 LSH
   dDiffDayFloat : Double;

   fixed_BornDate : String;
   trans_BornDate, trans_RgtDate : TDateTime;
begin
   //-----------------------------------------------------------------
   // �ʱ� Return Value Null ó��
   //-----------------------------------------------------------------
   diffDay  := 0;

   Result   := IntToStr(diffDay);


   //-----------------------------------------------------------------
   // ���� �����ϼ�
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
   // ��������, �������� ���� assign
   //-----------------------------------------------------------------
   iBornYear := StrToInt(CopyByte(in_BornDate, 1, 4));
   iBornMon  := StrToInt(CopyByte(in_BornDate, 5, 2));
   iBornDay  := StrToInt(CopyByte(in_BornDate, 7, 2));
   iNowYear  := StrToInt(CopyByte(in_RgtDate,  1, 4));
   iNowMon   := StrToInt(CopyByte(in_RgtDate,  5, 2));
   iNowDay   := StrToInt(CopyByte(in_RgtDate,  7, 2));


   //------------------------------------
   // 1. ����⵵ = ��ϳ⵵
   //------------------------------------
   if (iBornYear = iNowYear) then
   begin
      // 1-1. ����� = ��Ͽ�
      if (iBornMon = iNowMon) then
      begin
         iBornCnt := iBornDay;
         iNowCnt  := iNowDay;
      end
      // 1-2. ����� < ��Ͽ�
      else if (iBornMon < iNowMon) then
      begin
         iBornCnt := (Month[iBornMon]) + iBornDay;
         iNowCnt  := (Month[iNowMon])  + iNowDay;
      end
      else
      begin

         //----------------------------------------------------------------
         // ����Ͻô� 6/1�� �����ε�, ������ڴ� 5/31�� case �߻�
         //  - �׳� '����ó��' �������� ���� �߰� @ 2012.06.01
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
                       '�����(���,�Կ�)�� ���ۿ�(���)���� �۽��ϴ�. ������ڸ� �� ���� �ٶ��ϴ�.',
                       '�������� ��� ����',
                       MB_OK + MB_ICONWARNING
                       );

            Exit;
         end;
      end;
   end
   //------------------------------------
   // 2. ����⵵ < ��ϳ⵵
   //------------------------------------
   else if (iBornYear < iNowYear) then
   begin
      // 2-1. ����� = ��Ͽ�
      if (iBornMon = iNowMon) then
      begin
         iBornCnt := iBornDay;
         iNowCnt  := (iNowYear - iBornYear) * 365 + iNowDay;
      end
      // 2-2. ����� > ��Ͽ�
      else if (iBornMon > iNowMon) then
      begin
         // ��Ͽ��� 2������
         if (iNowMon > 1) then
         begin
            iBornCnt := (Month[iBornMon]) + iBornDay;
            iNowCnt  := (iNowYear - iBornYear) * 365 + (Month[iNowMon])  + iNowDay;
         end
         // ��Ͽ��� 1��
         else if (iNowMon = 1) then
         begin
            iBornCnt := (Month[iBornMon])   + iBornDay;
            iNowCnt  := (Month[iNowMon+12]) + iNowDay;
         end;
      end
      // 2-3. ����� < ��Ͽ�
      else if (iBornMon < iNowMon) then
      begin
         iBornCnt := (Month[iBornMon]) + iBornDay;
         iNowCnt  := (iNowYear - iBornYear) * 365 + (Month[iNowMon])  + iNowDay;
      end;

   end
   //------------------------------------
   // 3. ����⵵ > ��ϳ⵵
   //------------------------------------
   else
   begin
      MessageBox(self.Handle,
                 '����⵵(���,�Կ�)�� ����⵵(���)���� �۽��ϴ�. ������ڸ� �� ���� �ٶ��ϴ�.',
                 '���¿��� ��� ����',
                 MB_OK + MB_ICONWARNING
                 );

      Exit;
   end;

   //-----------------------------------------------------------------
   // �� ����ϼ�(����)
   //-----------------------------------------------------------------
   diffDay  := iNowCnt - iBornCnt;


   //-------------------------------------------------------
   // ���� ��� �߰�
   //-------------------------------------------------------
   if (isYunYear(iNowYear) or isYunYear(iBornYear)) and                       // ����⵵(���,�Կ�)) �Ǵ� ���۳⵵(���)�� �����̸鼭,
      (((iNowYear > iBornYear) and (iNowMon > 2)) or                          // ����⵵(���,�Կ�)�� ���۳⵵(���)���� ���ų� ũ�� �����(���,�Կ�)�� 2������ �Ǵ�
       ((iNowYear = iBornYear) and (iNowMon > 2) and (iBornMon <= 2))) then   // �����(���,�Կ�)�� 2�������̰� ���ۿ�(���)�� 1~2���̸�, ++

      diffDay := diffDay + 1;



   //-----------------------------------------------------------------
   // ����� ~ ���� ����� ������ �� ����ϼ�
   //-----------------------------------------------------------------
   iTmpTransWks := (diffDay div 7);
   iTmpTransDay := (diffDay mod 7) + varBornDay;


   //-----------------------------------------------------------------
   // �ϼ��� 7�� �Ѿ��, �ּ� + 1
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
   // �����ַ� ȯ�꺸�� Checked�� �����ּ� + �����ϼ� �߰� ���
   //          - ���� S/R : ASPD1610013 (PD ������)
   //          - 2017.01.17 LSH
   //-----------------------------------------------------------------
   if (fcb_ConvertWks.Checked) then
   begin
      // ������� ~ �Կ����� �� ����ϼ�
      iDiffDay1  := GetDiffDay(in_BornDate, FsMedDate);

      // ������ ������� (�� ������� + �Կ��Ⱓ���� �� ����ϼ�)
      fixed_BornDate := FormatDateTime('yyyymmdd', StrToDate(ConvertSDate(in_BornDate)) + iDiffDay1);

      trans_BornDate  := EncodeDate(strToint(CopyByte(fixed_BornDate,1,4)),
                                    strToint(CopyByte(fixed_BornDate,5,2)),
                                    strToint(CopyByte(fixed_BornDate,7,2)));


      trans_RgtDate  := EncodeDate(strToint(CopyByte(in_RgtDate,1,4)),
                                   strToint(CopyByte(in_RgtDate,5,2)),
                                   strToint(CopyByte(in_RgtDate,7,2)));

      dDiffDayFloat  := (trans_RgtDate - trans_BornDate);

      iDiffDay2 := StrToInt(FloatToStr(dDiffDayFloat));

      // ����Ϻ��� ~ �Կ������� ����� ���õ� ����� ������ �� ����ϼ�
      iTmpPeriod  := iDiffDay1 + iDiffDay2;

      // �����ַɿ� ���������� week ī��Ʈ
      iAddingWks    := iTmpPeriod div 7;

      // �����ַɿ� ���������� day ī��Ʈ
      iAddingDay    := iTmpPeriod mod 7;


      // �����ַ� day�� �߰��� day�� ���� 7�� ������,
      // �����ַ� week ī��Ʈ�� �ش� week ī��Ʈ�� �����ش�.
      if (iTmpTransDay + iAddingDay >= 7) then
      begin
         iAddedWks := iAddingWks + 1;

         try
            iAddedDay := (iTmpTransDay + iAddingDay) mod 7;

         except
            on e : Exception do
            begin
               showmessage(e.Message + ' : NICU �������� 7�Ϲ̸�(�߰�) ��� ����ó��');
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
               showmessage(e.Message + ' : NICU �������� 7���̻�(�߰�) ��� ����ó��');
            end;
         end;
      end;

      // ������ Week �� Day �� ���� �����ַ� buffer var.�� added.
      iTmpTransWks := iTmpTransWks + iAddedWks;
      iTmpTransDay := iTmpTransDay + iAddedDay;

      // �����ּ� Label ǥ�� �߰� (���� �� ����غ���..)
      //lb_BornWks.Caption := lb_BornWks.Caption + ' [����] ' + IntToStr(varBornWks + iAddedWks) + ' + ' + IntToStr(varBornDay + iAddedDay);

   end;


   //-----------------------------------------------------------------
   // �ϼ�(Day)�� �Ҽ������� ȯ���Ͽ�,
   // ����ּ�(Wks + Day)�� X�� Drawing ��ǥ Set.
   //-----------------------------------------------------------------
   iTmpTransDay2 := (0.01 * (iTmpTransDay mod 7) * 100 / 7);


   //-----------------------------------------------------------------
   // ���� ȯ�� �ּ� (Day�� �Ҽ��� ȯ��� Wks)
   //-----------------------------------------------------------------
   tmpResult := varBornWks + iTmpTransWks + iTmpTransDay2;


   //-----------------------------------------------------------------
   // ���¿�(��)��
   //-----------------------------------------------------------------
   try
      Result := FloatToStr(tmpResult);

   except
      on e : Exception do
      begin
         MessageBox(Self.Handle,
                    PChar('[Exception Msg] : ' + e.Message),
                    'NeoNatal ���¿��� ��� ����ó��',
                    MB_OK + MB_ICONINFORMATION);
      end;
   end;
end;



//------------------------------------------------------------------------------
// ���� ���
// - Neo ���¿��� ������� ���� ����(Y/N) üũ
//
// Author : Lee, Se-Ha
// Date   : 2013.12.05
//------------------------------------------------------------------------------
function TMDRC05F1.IsYunYear(in_Year : Integer) : Boolean;
begin
   //-----------------------------------------------------------------
   // �ʱⰪ
   //-----------------------------------------------------------------
   Result := False;

   //-----------------------------------------------------------------
   // 4�ڸ��� ���� �Է¹޾�����, ���⿩�� Check
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
// �Ż��� ��ȣ���������� ����ּ� ��ȸ �Լ�
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

   lb_BornWks.Caption := '����ּ� :';
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
            //  True ��ȯ
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
      // ����ּ� ǥ��
      //---------------------------------------------------------
      lb_BornWks.Caption := '����ּ� : ' + IntToStr(varBornWks) + '��' + IntToStr(varBornDay) + '�� (' + ConvertSDate(varBirtdate) + ')';


   finally
      FreeAndNil(TpGetNeo);
      Screen.Cursor := crDefault;
   end;

end;



//------------------------------------------------------------------------------
// [����ּ�] FlatEditBox onKeyDown Event Handler
//
// Date   : 2013.12.16
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_DayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   //---------------------------------------------------------
   // Enter �Է½� �˻�
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

      lb_BornWks.Caption := '����ּ� : ' + Trim(fed_Wks.Text) + '��' + Trim(fed_Day.Text) + '�� (' + ConvertSDate(varBirtdate) + ')';
      lb_BornWks.Visible := False;
   end;


   //---------------------------------------------------------
   // �ʱ�ȭ
   //---------------------------------------------------------
   fed_Wks.Text := '';
   fed_Day.Text := '';


   //---------------------------------------------------------
   // �Ż��� ����ּ� Ȯ�� Panel Close
   //---------------------------------------------------------
   apn_NeoBornWks.Collaps := True;
   apn_NeoBornWks.Visible := False;


   //---------------------------------------------------------
   // ȯ�� �����̷� Draw
   //---------------------------------------------------------
   DrawPatSeries;
end;


//------------------------------------------------------------------------------
// [����ּ�] FlatEditBox onChange Event Handler
//
// Date   : 2013.12.16
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.fed_WksChange(Sender: TObject);
begin
   //------------------------------------------------
   // 2�ڸ� ���� �Է½�, Day�� Set Focus
   //------------------------------------------------
   if LengthByte(Trim(fed_Wks.Text)) >= 2 then
      fed_Day.SetFocus;
end;


//------------------------------------------------------------------------------
// �Ż��� ���� ����ּ� Line Draw
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
         // �ϼ�(Day)�� �ּ�(�Ҽ���)�� ȯ���Ͽ�,
         // ����ּ�(Wks + Day)�� X�� Drawing ��ǥ Set.
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
         // ������� ��� Output Text�� X ��ǥ�� ����(ȭ�� �������� ©��)��
         // �Ǳ� ������, ������ Position�� Offset ���� @ 2017.01.17 LSH
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
// [Debug] �����ڿ� Refresh ���
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
   // ����-���ɺ� Axis Panel Location
   //-----------------------------------------------------------------
   SetAxisPanel(IsAgeFlag);

   //-----------------------------------------------------------------
   // ����-���ɺ� Chart Axis Set
   //-----------------------------------------------------------------
   SetStandardAxis(IsAgeFlag,
                   CopyByte(Trim(fed_SexAge.Text), 1, 1));


   //-----------------------------------------------------------------
   // ����-���ɺ� �׸� ǥ�ؼ�����ǥ ��ȸ
   //-----------------------------------------------------------------
   if IsAgeFlag = 'NEONATAL' then
      GetStandardMarking('7',
                         'NBINF',
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '')
   else if IsAgeFlag = 'ZERO2THIRTYSIX' then
      GetStandardMarking('1',
                         'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ����(PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '')
   else if IsAgeFlag = 'TWO2EIGHTTEEN' then
      GetStandardMarking('2',
                         'P' + fn_nvl(FsStandIdx, '2017'),           // ǥ�� D/B ���� �ε��� ����(PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
                         CopyByte(Trim(fed_SexAge.Text), 1, 1),
                         '');

   //-----------------------------------------------------------------
   // ȯ�� �����̷� Draw
   //-----------------------------------------------------------------
   DrawPatSeries;

end;

//------------------------------------------------------------------------------
// [Debug] Chart Axis Range �ʱ�ȭ
//
// Date     : 2013.12.26
// Author   : Lee, Se-Ha
//------------------------------------------------------------------------------
procedure TMDRC05F1.ResetAxisRange;
begin
   // Log
   Memo1.Lines.Add('Reset Axis Range(Init)');

   //-----------------------------------------------------------------
   // Tab Changed �̺�Ʈ �߻��� Axis Range ���� Refersh Debugging
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
// [�Լ�] ǥ������ �������� ��� (ȯ�� ��ü���� data ������� ǥ��)
//       - MS Excel�� Normsdist() ������ ������.
//
// Date   : 2014.05.22
// Author : Lee, Se-Ha
//------------------------------------------------------------------------------
function TMDRC05F1.NormsDist(in_ZScore : Extended ) : Extended;
var
   b1, b2, b3, b4, b5, p, t1, t2, t3, t4, t5, dArea, xx : Extended;
begin
   // Constant ����
	b1 := 0.31938153;
	b2 := -0.356563782;
	b3 := 1.781477937;
	b4 := -1.821255978;
	b5 := 1.330274429;
	p  := 0.2316419;


   // Z-Score ���밪 ��ȯ
	xx := Abs(in_ZScore);


   // �Է°� ��ȿ�� Check
   if (xx = 0) then
   begin
      Result := 0;
      Exit;
   end;


   // Normsdist() ���� Constant ����
	t1 := 1.0 / (1.0 + p * xx);
	t2 := t1 * t1;
	t3 := t2 * t1;
	t4 := t3 * t1;
	t5 := t4 * t1;

   // ǥ������ �������� ���
	dArea := INVSQRT2PI * Exp(-0.5 * xx * xx) * (b1 * t1 + b2 * t2 + b3 * t3 + b4 * t4 +b5 * t5);


	if (in_ZScore > 0.0) then
		dArea := 1.0 - dArea;

	Result := dArea;

end;



//------------------------------------------------------------------------------
// ǥ�����Ժ��� ������� ����Լ� ȣ�� �� Panel-on
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
   sType2 := 'P' + fn_nvl(FsStandIdx, '2017');           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
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
         // ü�� Z-Score ���
         if (in_Gubun = 'WEIGHT') and
            (in_Item > 0) then
         begin
            // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 0))) = 0 then
            begin
               try
                  tmpZ_Wgt := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 0))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 0))
                                         );
               except
                  // Floating ��� ����ó��
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
                  // Floating ��� ����ó��
               end;
            end;
         end
         else
            tmpZ_Wgt := '0';

         // ���� Z-Score ���
         if (in_Gubun = 'HEIGHT') and
            (in_Item > 0) then
         begin
            // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 1))) = 0 then
            begin
               try
                  tmpZ_Hgt := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 1))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 1))
                                         );
               except
                  // Floating ��� ����ó��
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
                  // Floating ��� ����ó��
               end;
            end;
         end
         else
            tmpZ_Hgt := '0';

         // BMI Z-Score ���
         if (in_Gubun = 'BMI') and
            (in_Item > 0) then
         begin
            // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
            if Abs(StrToFloat(TpGetLMS.GetOutputDataS('sLesti', 2))) = 0 then
            begin
               try
                  tmpZ_Bmi := FloatToStr(
                                             ln(in_Item/StrToFloat(TpGetLMS.GetOutputDataS('sMesti', 2))) /
                                             StrToFloat(TpGetLMS.GetOutputDataS('sSesti', 2))
                                         );
               except
                  // Floating ��� ����ó��
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
                  // Floating ��� ����ó��
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
// ǥ�����Ժ��� ������� ����Լ� ȣ�� �� Panel-on To Grid
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
      // ����� ǥ�� Grid RowCount
      asg_NormsDist.RowCount := RowCount;


      for i := 1 to RowCount - 1 do
      begin
         sType1 := '8';
         sType2 := 'P' + fn_nvl(FsStandIdx, '2017');           // ǥ�� D/B ���� �ε��� ���� (PDDET : 2007 ver. P2017 : 2017 ver.) @ 2018.05.28 LSH
         sType3 := CopyByte(Trim(fed_SexAge.Text), 1, 1);
         sType4 := Cells[C_YEAR,  i];
         sType5 := Cells[C_MONTH, i];

         //---------------------------------------------------------------------
         // 2~18�� ������� Chart ����� 18�� �ʰ� �������� ����� ǥ�� ����
         //          - ��û : PD ��ȿ��
         //          - D/B���� 2~18������ �ۿ� LMS ���� �����Ƿ�, Skip.
         //          - 2016.09.08 LSH
         //
         // �Ż��� �Կ� �����̷� �������� 18�� �̸� �ƴѰ��, Z-Score ����� ǥ�� ����
         //          - ���� S/R : ASPD1610013 (PD ������)
         //          - 2017.01.17 LSH
         //---------------------------------------------------------------------
         {
         if (StrToIntDef(sType4, 0) >= 18) and
            (StrToIntDef(sType5, 0) >  0)  then
         }
         if (
               (StrToIntDef(sType4, 0) >= 18) and  // �� 18�� �̻��̸� ǥ�� ����
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

               //  Grid ǥ�Ⱑ �ƴ�, Chart�� ǥ��� ��ȯ����� �ּ�ó�� @ 2014.05.26 LSH
               //  Grid ǥ�� ���û ���� �ּ����� @ 2014.07.08 LSH
               // ü�� Z-Score ���
               if (Cells[C_WEIGHT, i] > '0') then
               begin
                  // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 0), 0)) = 0 then
                  begin
                     try
                        tmpZ_Wgt := FloatToStr(
                                                   ln(StrToFloat(Cells[C_WEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 0), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 0), 0)
                                               );
                     except
                        // Floating ��� ����ó��
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
                        // Floating ��� ����ó��
                     end;
                  end;
               end
               else
                  tmpZ_Wgt := '0';

               // ���� Z-Score ���
               if (Cells[C_HEIGHT, i] > '0') then
               begin
                  // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 1), 0)) = 0 then
                  begin
                     try
                        tmpZ_Hgt := FloatToStr(
                                                   ln(StrToFloat(Cells[C_HEIGHT, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 1), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 1), 0)
                                               );
                     except
                        // Floating ��� ����ó��
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
                        // Floating ��� ����ó��
                     end;
                  end;
               end
               else
                  tmpZ_Hgt := '0';

               // BMI Z-Score ��� (2������ LMS ����ġ ���갡��)
               if (Cells[C_YEAR, i] > '1') and
                  (Cells[C_BMI, i] > '0') then
               begin
                  // L-Value�� 0�� ��� ���� �б� @ 2016.02.11 LSH (PD ��ȿ��)
                  if Abs(StrToFloatDef(TpGetLMS.GetOutputDataS('sLesti', 2), 0)) = 0 then
                  begin
                     try
                        tmpZ_Bmi := FloatToStr(
                                                   ln(StrToFloat(Cells[C_BMI, i])/StrToFloatDef(TpGetLMS.GetOutputDataS('sMesti', 2), 0)) /
                                                   StrToFloatDef(TpGetLMS.GetOutputDataS('sSesti', 2), 0)
                                               );
                     except
                        // Floating ��� ����ó��
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
                        // Floating ��� ����ó��
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



         //  Grid ǥ�Ⱑ �ƴ�, Chart�� ǥ��� ��ȯ����� �ּ�ó�� @ 2014.05.26 LSH
         //  Grid ǥ�� ���û ���� �ּ����� @ 2014.07.08 LSH
         // ǥ�����Դ�������(�����, f(z)) ���
         try
            asg_NormsDist.Cells[0, i] :=  FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Wgt, 0)), 0)) + 'p | ' +
                                          FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Hgt, 0)), 0)) + 'p | ' +
                                          FloatToStr(RTrunc_Pos(100 * NormsDist(StrToFloatDef(tmpZ_Bmi, 0)), 0)) + 'p';
         except
            // Floating ��� ����ó��
         end;
      end;
   end;
end;


//------------------------------------------------------------------------------
// ������� ��� �� Text Banner Drawing
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
      // ���� Chart�� ��ǥ ���
      x := in_Series.CalcXPosValue(in_TotMon);
      y := in_Series.CalcYPosValue(in_Item);


      // �� ��ġ�� ǥ�õ� Marker ũ��, ��ġ ����
      // �� ��ġ�� ǥ�ǵ� MARKER ũ��, ��ġ ����  @ 2016.01.22 lSH
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

      // �� �ֺ��� ���� ǥ��
      Canvas.Pen.Color   := clNavy;
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := clNavy;

      // ��Ʈ ����, �۲�, ũ�� ����
      chr_PdGrow.Canvas.Font.Name   := 'Arial';
      chr_PdGrow.Canvas.Font.Color  := clWhite;
      chr_PdGrow.Canvas.Font.Size   := 9;
      chr_PdGrow.Canvas.Font.Style  := [fsBold];

      // XE7 ��ȯ�� Canvas�� Brush �Ӽ� �׷��ֱ� ���� �߰� @ 2016.01.22 lSH
      Canvas.FillRect(rT);

      // �ؽ�Ʈ ���
      try
         sText := CalcZScore2Dist(in_Gubun,
                                  in_Year,
                                  in_Month,
                                  in_Item);

      except
         // ǥ�����Դ������� ���� �߻��ϴ� floating point ���� Skip
      end;

      chr_PdGrow.Canvas.TextOut(x - 30, y - 30, sText);


      // ����ٿ� �� Maker ���̿� ���߱�
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
      // ��Ʈ (��) + �������� (��) ĸ��
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
   // ��Ʈ �� �������� (��ü frame) �̹��� ����
   SaveComponentImg(Sender);

   // ���(QReport) �� ���� �� �̹��� �ҷ�����
   // ����üũ(�ǽ��л� ��� �Ұ�)
   if CheckAuthority('PRINT', '', '', '', self.Name) = False then Exit;

   // ����Ʈ ���� Check
   if (IsNotPrinterReady) then Exit;


   try
      if MDRC05F1_P01 <> nil then
         MDRC05F1_P01.Close;

      Application.CreateForm(TMDRC05F1_P01, MDRC05F1_P01);

      MDRC05F1_P01.qrimg_GrowthChart.Picture.Bitmap.LoadFromFile(G_HOMEDIR + 'TEMP\MDRC05F1_CAP.bmp');
      MDRC05F1_P01.qrImg_Hospital.Picture.LoadFromFile(G_HOMEDIR + 'EXE\RES\HSIG_KR2_' + G_LOCATE + '.JPG');

      // ����������ȣ ��¹�����
      MDRC05F1_P01.qr_ChartMain.ReportTitle := '[MDRC05F1_P01] ��������';   // ������ ��Ȯ���� ���� ReportTitle�� �߰�
      fn_SetReportID(MDRC05F1_P01.qr_ChartMain);                                // ��� ID

      {-- �̸����� Ȯ�强 ���
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


      // �½�Ʈ�� �̸����� (BPL) ����
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
