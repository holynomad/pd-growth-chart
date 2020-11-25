{===============================================================================
   Program ID    : MDRC05U1_P01
   Program Name  : 소아 성장발육곡선 Charting 출력(Q/R)
   Program Desc. : 전 의료원장님 (PD) 지시...

   Author        : Lee, Se-Ha
   Date          : 2020.01.13
===============================================================================}
unit MDRC05U1_P01;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  Qrctrls, QuickRpt, ExtCtrls, UltraGrid, Variants, qrpctrls, Vcl.Imaging.jpeg;

type
  TMDRC05F1_P01 = class(TForm)
    qr_ChartMain: TQuickRep;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrlb_HosName: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape20: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel5: TQRLabel;
    qlb_QueryDate: TQRLabel;
    QRBand3: TQRBand;
    QRShape2: TQRShape;
    QRShape28: TQRShape;
    QRShape11: TQRShape;
    QRBand4: TQRBand;
    qrimg_GrowthChart: TQRImage;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    qrImg_Hospital: TQRImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    va_No, va_MedDept, va_PatNo, va_PatNm, va_Sex, va_RoomNo, va_OpName,
    va_DiagNm, va_OpNm, va_AnethCd, va_OpSTm, va_OpDur, va_OpRoom,
    va_Status, va_Caution, va_PatType, va_Oppartm, va_Eryn : Variant;

    iTotalCnt, iCurrentCnt : LongInt;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MDRC05F1_P01: TMDRC05F1_P01;

implementation

uses
   HisUtil;

{$R *.DFM}

procedure TMDRC05F1_P01.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TMDRC05F1_P01.FormDestroy(Sender: TObject);
begin
   MDRC05F1_P01 := nil;
end;


initialization
   RegisterClass(TMDRC05F1_P01);

finalization
   UnRegisterClass(TMDRC05F1_P01);


end.
