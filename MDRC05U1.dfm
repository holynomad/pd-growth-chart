object MDRC05F1: TMDRC05F1
  Left = 0
  Top = 0
  ActiveControl = ftc_Chart
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[MDRC05F1] '#49457#51109#48156#50977#44257#49440' Chart'
  ClientHeight = 877
  ClientWidth = 1271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object stb_Message: TStatusBar
    Left = 0
    Top = 858
    Width = 1271
    Height = 19
    Color = clWhite
    Panels = <
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object fpn_Framework: TFlatPanel
    Left = -2
    Top = 0
    Width = 1276
    Height = 859
    Color = clWhite
    TabOrder = 1
    UseDockManager = True
    object fpn_Chart: TFlatPanel
      Left = 1
      Top = 1
      Width = 675
      Height = 857
      Align = alLeft
      ParentColor = True
      TabOrder = 0
      UseDockManager = True
      object ftc_Chart: TFlatTabControl
        Left = 0
        Top = 0
        Width = 675
        Height = 861
        ColorUnselectedTab = clMaroon
        Tabs.Strings = (
          #49888#49373#50500' '#49457#51109#48156#50977#44257#49440
          '0~36'#44060#50900' '#49457#51109#48156#50977#44257#49440
          '2~18'#49464' '#49457#51109#48156#50977#44257#49440
          #46160#50948' '#48177#48516#50948#49688' '#44257#49440
          'BMI '#48177#48516#50948#49688' '#44257#49440)
        TabHeight = 30
        ActiveTab = 4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Color = 4365289
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnMouseMove = ftc_ChartMouseMove
        OnTabChanged = ftc_ChartTabChanged
        object chr_PdGrow: TChart
          Left = 1
          Top = 31
          Width = 673
          Height = 829
          BackWall.Color = clWhite
          BackWall.Size = 4
          BackWall.Transparent = False
          Gradient.Direction = gdLeftRight
          LeftWall.Brush.Color = clRed
          LeftWall.Brush.Style = bsCross
          LeftWall.Color = 8454016
          LeftWall.Pen.Width = 3
          Legend.Alignment = laLeft
          Legend.ColorWidth = 55
          Legend.DividingLines.Style = psDot
          Legend.DividingLines.SmallDots = True
          Legend.Font.Charset = HANGEUL_CHARSET
          Legend.Font.Height = -13
          Legend.Font.Name = #44404#47548#52404
          Legend.Frame.Visible = False
          Legend.HorizMargin = 12
          Legend.LegendStyle = lsSeries
          Legend.Shadow.HorizSize = 0
          Legend.Shadow.VertSize = 0
          Legend.Symbol.Width = 55
          Legend.TopPos = 11
          Legend.Visible = False
          MarginBottom = 5
          MarginLeft = 5
          MarginRight = 5
          MarginTop = 5
          Title.Brush.Color = clSilver
          Title.Font.Charset = HANGEUL_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -15
          Title.Font.Name = #44404#47548#52404
          Title.Font.Style = [fsBold]
          Title.Text.Strings = (
            'TChart')
          Title.Visible = False
          OnUndoZoom = chr_PdGrowUndoZoom
          OnZoom = chr_PdGrowZoom
          BottomAxis.Automatic = False
          BottomAxis.AutomaticMaximum = False
          BottomAxis.AutomaticMinimum = False
          BottomAxis.AxisValuesFormat = '#,##0'
          BottomAxis.ExactDateTime = False
          BottomAxis.Grid.Style = psDot
          BottomAxis.Increment = 1.000000000000000000
          BottomAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
          BottomAxis.LabelsMultiLine = True
          BottomAxis.LabelStyle = talValue
          BottomAxis.Maximum = 18.000000000000000000
          BottomAxis.Minimum = 2.000000000000000000
          BottomAxis.MinorGrid.Color = clSilver
          BottomAxis.MinorTickCount = 0
          BottomAxis.MinorTickLength = 0
          BottomAxis.MinorTicks.Style = psDot
          BottomAxis.MinorTicks.Visible = False
          BottomAxis.RoundFirstLabel = False
          BottomAxis.Ticks.Style = psDot
          BottomAxis.TicksInner.Style = psDot
          Chart3DPercent = 10
          DepthAxis.Automatic = False
          DepthAxis.AutomaticMaximum = False
          DepthAxis.AutomaticMinimum = False
          DepthAxis.ExactDateTime = False
          DepthAxis.Grid.Color = 4227327
          DepthAxis.Increment = 5.000000000000000000
          DepthAxis.Maximum = 185.000000000000000000
          DepthAxis.Minimum = 50.000000000000000000
          DepthAxis.TickLength = 7
          DepthAxis.Ticks.Width = 6
          Hover.Visible = False
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMaximum = False
          LeftAxis.AutomaticMinimum = False
          LeftAxis.ExactDateTime = False
          LeftAxis.Grid.Style = psDot
          LeftAxis.Increment = 5.000000000000000000
          LeftAxis.LabelsMultiLine = True
          LeftAxis.LabelsSeparation = 5
          LeftAxis.LabelsSize = 30
          LeftAxis.Maximum = 200.000000000000000000
          LeftAxis.MinorGrid.Style = psDot
          LeftAxis.MinorTickCount = 4
          LeftAxis.RoundFirstLabel = False
          RightAxis.Automatic = False
          RightAxis.AutomaticMaximum = False
          RightAxis.AutomaticMinimum = False
          RightAxis.ExactDateTime = False
          RightAxis.Grid.Style = psDot
          RightAxis.Increment = 5.000000000000000000
          RightAxis.LabelsMultiLine = True
          RightAxis.LabelsSize = 30
          RightAxis.Maximum = 200.000000000000000000
          RightAxis.MinorGrid.Style = psDot
          RightAxis.MinorTickCount = 4
          RightAxis.RoundFirstLabel = False
          TopAxis.Automatic = False
          TopAxis.AutomaticMaximum = False
          TopAxis.AutomaticMinimum = False
          TopAxis.ExactDateTime = False
          TopAxis.Grid.Style = psDot
          TopAxis.Increment = 1.000000000000000000
          TopAxis.LabelsMultiLine = True
          TopAxis.LabelStyle = talValue
          TopAxis.Maximum = 18.000000000000000000
          TopAxis.Minimum = 2.000000000000000000
          TopAxis.MinorTickCount = 0
          TopAxis.MinorTickLength = 0
          TopAxis.MinorTicks.Style = psDot
          TopAxis.MinorTicks.Visible = False
          TopAxis.RoundFirstLabel = False
          View3D = False
          View3DOptions.HorizOffset = -19
          View3DOptions.VertOffset = -19
          View3DOptions.Zoom = 87
          View3DWalls = False
          OnAfterDraw = chr_PdGrowAfterDraw
          OnGetNextAxisLabel = chr_PdGrowGetNextAxisLabel
          Align = alClient
          BevelInner = bvLowered
          Color = clWhite
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          OnClick = chr_PdGrowClick
          OnMouseMove = chr_PdGrowMouseMove
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object lb_Age: TLabel
            Left = 549
            Top = 801
            Width = 60
            Height = 16
            Caption = #50672#47161'('#49464')'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
          object lb_AxisLocate: TLabel
            Left = 60
            Top = 9
            Width = 81
            Height = 18
            Caption = #51340#54364' '#48372#44592' : '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object Label1: TLabel
            Left = 6
            Top = 809
            Width = 296
            Height = 14
            Caption = #39#8600#39#48169#54693#51004#47196' '#46300#47000#44536' : '#54869#45824'  '#39#8598#39#48169#54693#51004#47196' '#46300#47000#44536' :  '#52629#49548
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object lb_RightHead: TLabel
            Left = 463
            Top = 4
            Width = 26
            Height = 28
            Caption = #46160#50948#13#10' cm'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_RightBmi: TLabel
            Left = 498
            Top = 4
            Width = 33
            Height = 28
            Caption = ' BMI'#13#10#13199'/'#13217
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt3rd: TLabel
            Left = 396
            Top = 734
            Width = 13
            Height = 11
            Caption = '3rd'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt3rd: TLabel
            Left = 396
            Top = 751
            Width = 13
            Height = 11
            Caption = '3rd'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt5th: TLabel
            Left = 414
            Top = 734
            Width = 13
            Height = 11
            Caption = '5th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt10th: TLabel
            Left = 434
            Top = 734
            Width = 18
            Height = 11
            Caption = '10th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt25th: TLabel
            Left = 457
            Top = 734
            Width = 18
            Height = 11
            Caption = '25th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt50th: TLabel
            Left = 481
            Top = 734
            Width = 18
            Height = 11
            Caption = '50th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt75th: TLabel
            Left = 505
            Top = 734
            Width = 18
            Height = 11
            Caption = '75th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt90th: TLabel
            Left = 548
            Top = 734
            Width = 18
            Height = 11
            Caption = '90th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt95th: TLabel
            Left = 572
            Top = 734
            Width = 18
            Height = 11
            Caption = '95th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt97th: TLabel
            Left = 596
            Top = 734
            Width = 18
            Height = 11
            Caption = '97th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt5th: TLabel
            Left = 414
            Top = 751
            Width = 13
            Height = 11
            Caption = '5th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt10th: TLabel
            Left = 435
            Top = 752
            Width = 18
            Height = 11
            Caption = '10th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt25th: TLabel
            Left = 457
            Top = 752
            Width = 18
            Height = 11
            Caption = '25th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt50th: TLabel
            Left = 480
            Top = 751
            Width = 18
            Height = 11
            Caption = '50th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt75th: TLabel
            Left = 505
            Top = 751
            Width = 18
            Height = 11
            Caption = '75th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt90th: TLabel
            Left = 548
            Top = 751
            Width = 18
            Height = 11
            Caption = '90th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt95th: TLabel
            Left = 572
            Top = 752
            Width = 18
            Height = 11
            Caption = '95th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Wgt97th: TLabel
            Left = 596
            Top = 752
            Width = 18
            Height = 11
            Caption = '97th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Neo3Rd: TLabel
            Left = 415
            Top = 713
            Width = 13
            Height = 11
            Caption = '3rd'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Neo10th: TLabel
            Left = 453
            Top = 713
            Width = 18
            Height = 11
            Caption = '10th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Neo50th: TLabel
            Left = 500
            Top = 713
            Width = 18
            Height = 11
            Caption = '50th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Neo90th: TLabel
            Left = 548
            Top = 713
            Width = 18
            Height = 11
            Caption = '90th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Neo97th: TLabel
            Left = 589
            Top = 713
            Width = 18
            Height = 11
            Caption = '97th'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_BornWks: TLabel
            Left = 244
            Top = 790
            Width = 73
            Height = 16
            Caption = #52636#49373#51452#49688' :'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object lb_Hgt85th: TLabel
            Left = 526
            Top = 734
            Width = 18
            Height = 11
            Caption = '85th'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object fcb_AxisLocate: TFlatCheckBox
            Left = 531
            Top = 3
            Width = 68
            Height = 15
            Hint = 'Chart'#45236' '#47560#50864#49828' '#54252#51064#53552' '#50948#52824#51032' '#51340'/'#50864' '#52629' Data '#51340#54364#47484' '#54364#44592#54633#45768#45796'.'
            Caption = #51340#54364#48372#44592
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ShowHint = True
            TabOrder = 0
            TabStop = True
            OnClick = fcb_AxisLocateClick
          end
          object fcb_ConvertWks: TFlatCheckBox
            Left = 531
            Top = 20
            Width = 69
            Height = 14
            Hint = '36'#44060#50900' '#51060#45236' '#48376#50896#52636#49373' '#54872#50500#51064' '#44221#50864' '#44368#51221#50672#47161#51004#47196' '#54872#49328#54616#50668' Chart'#50640' '#50672#46041#54633#45768#45796'.'
            Caption = #44368#51221#50672#47161
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ShowHint = True
            TabOrder = 1
            TabStop = True
          end
          object fpn_LeftHgtAxis: TFlatPanel
            Left = 4
            Top = 41
            Width = 28
            Height = 632
            ColorHighLight = clWhite
            ColorShadow = clWhite
            Caption = #49888#51109
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            TabOrder = 2
            UseDockManager = True
            object lb_LeftHgt: TLabel
              Left = 7
              Top = 323
              Width = 17
              Height = 14
              Caption = 'cm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object fpn_LeftWgtAxis: TFlatPanel
            Left = 31
            Top = 668
            Width = 26
            Height = 109
            ColorHighLight = clWhite
            ColorShadow = clWhite
            Caption = #52404#51473
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            TabOrder = 3
            UseDockManager = True
            object lb_LeftWgt: TLabel
              Left = 7
              Top = 60
              Width = 15
              Height = 14
              Caption = 'kg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object fpn_RightWgtAxis: TFlatPanel
            Left = 641
            Top = 196
            Width = 28
            Height = 490
            ColorHighLight = clWhite
            ColorShadow = clWhite
            Caption = #52404#51473
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            TabOrder = 4
            UseDockManager = True
            object lb_RightWgt: TLabel
              Left = 7
              Top = 254
              Width = 15
              Height = 14
              Caption = 'kg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object fpn_RightHgtAxis: TFlatPanel
            Left = 619
            Top = 47
            Width = 27
            Height = 252
            ColorHighLight = clWhite
            ColorShadow = clWhite
            Caption = #49888#51109
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            TabOrder = 5
            UseDockManager = True
            object lb_RightHgt: TLabel
              Left = 6
              Top = 133
              Width = 17
              Height = 14
              Caption = 'cm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object Series18: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 15659519
            Title = 'Wgt97th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series17: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 14147327
            Title = 'Wgt95th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series16: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 12898047
            Title = 'Wgt90th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series15: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 11583231
            Title = 'Wgt75th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series14: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 11379967
            Title = 'Wgt50th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series13: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 10853375
            Title = 'Wgt25th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series12: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 9734399
            Title = 'Wgt10th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series11: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 8286719
            Title = 'Wgt5th'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series10: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 5324543
            Title = 'Wgt3rd'
            VertAxis = aRightAxis
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            AreaLinesPen.Color = -1610612736
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series9: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 15659519
            Title = 'Hgt97th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series7: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 14147327
            Title = 'Hgt95th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series6: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 12898047
            Title = 'Hgt90th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series8: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 11583231
            Title = 'Hgt75th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series5: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 11379967
            Title = 'Hgt50th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series4: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 10853375
            Title = 'Hgt25th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series3: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 9734399
            Title = 'Hgt10th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series2: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 8286719
            Title = 'Hgt5th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series1: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = 5324543
            Title = 'Hgt3rd'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            AreaLinesPen.Color = -1342177280
            DrawArea = True
            LinePen.Style = psDot
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series27: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = clGreen
            Title = 'Hcr97th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            Dark3D = False
            DrawArea = True
            Pointer.Brush.Color = clLime
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series26: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = clGreen
            Title = 'Hcr90th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            Dark3D = False
            DrawArea = True
            Pointer.Brush.Color = clLime
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series25: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = clGreen
            Title = 'Hcr50th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            Dark3D = False
            DrawArea = True
            Pointer.Brush.Color = clLime
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series24: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = clGreen
            Title = 'Hcr10th'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            Dark3D = False
            DrawArea = True
            Pointer.Brush.Color = clLime
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series23: TAreaSeries
            Selected.Hover.Visible = False
            SeriesColor = clGreen
            Title = 'Hcr3rd'
            AreaChartBrush.Color = clGray
            AreaChartBrush.BackColor = clDefault
            AreaLinesPen.Color = -1291845632
            Dark3D = False
            DrawArea = True
            Pointer.Brush.Color = clLime
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series19: TLineSeries
            Selected.Hover.Visible = False
            HorizAxis = aBothHorizAxis
            SeriesColor = clLime
            Title = 'PatHgt'
            Brush.Style = bsClear
            Brush.BackColor = clDefault
            LineBrush = bsClear
            LinePen.Visible = False
            Pointer.Brush.Color = clYellow
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series20: TLineSeries
            Selected.Hover.Visible = False
            HorizAxis = aBothHorizAxis
            SeriesColor = clRed
            Title = 'PatWgt'
            VertAxis = aRightAxis
            Brush.Style = bsClear
            Brush.BackColor = clDefault
            LineBrush = bsClear
            LinePen.Visible = False
            Pointer.Brush.Color = 65408
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series21: TLineSeries
            Selected.Hover.Visible = False
            HorizAxis = aBothHorizAxis
            SeriesColor = clGreen
            Title = 'PatHeadCir'
            VertAxis = aRightAxis
            Brush.Style = bsClear
            Brush.BackColor = clDefault
            LineBrush = bsClear
            LinePen.Visible = False
            Pointer.Brush.Color = clAqua
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series22: TLineSeries
            Selected.Hover.Visible = False
            HorizAxis = aBothHorizAxis
            SeriesColor = clGreen
            Title = 'PatBmi'
            VertAxis = aRightAxis
            Brush.Style = bsClear
            Brush.BackColor = clDefault
            LineBrush = bsClear
            LinePen.Visible = False
            Pointer.Brush.Color = clAqua
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
        object fcb_Number: TFlatCheckBox
          Left = 603
          Top = 33
          Width = 69
          Height = 14
          Hint = #52769#51221#51060#47141#51032' '#49688#52824#47484' Chart'#50640' '#54364#44592#54633#45768#45796'.'
          Caption = #49688#52824#48372#44592
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ShowHint = True
          TabOrder = 1
          TabStop = True
          OnClick = fcb_NumberClick
        end
        object fcb_Percent: TFlatCheckBox
          Left = 603
          Top = 49
          Width = 69
          Height = 14
          Hint = 
            'LMS '#52628#51221#52824#47484' '#48148#53461#51004#47196' '#52769#51221#51060#47141#51032' '#54364#51456#51221#44508#45572#51201#48516#54252' '#54872#49328#44050'(NORMSDIST(z))'#51012' '#44228#49328#54616#50668#13#10'Chart'#50640' '#54364#44592#54633 +
            #45768#45796'.'
          Caption = #48177#48516#50948#49688
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ShowHint = True
          TabOrder = 2
          TabStop = True
          OnClick = fcb_PercentClick
        end
      end
    end
    object fpn_PatInfo: TFlatPanel
      Left = 673
      Top = 1
      Width = 602
      Height = 857
      Align = alRight
      ParentColor = True
      TabOrder = 1
      UseDockManager = True
      OnMouseMove = fpn_PatInfoMouseMove
      object Shape3: TShape
        Left = 7
        Top = 7
        Width = 71
        Height = 22
        Brush.Color = 4365289
        Pen.Color = clGray
      end
      object Shape2: TShape
        Left = 7
        Top = 36
        Width = 71
        Height = 22
        Brush.Color = 4365289
        Pen.Color = clGray
      end
      object Label5: TLabel
        Left = 24
        Top = 41
        Width = 39
        Height = 12
        Caption = #51652#47308#44284
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 18
        Top = 12
        Width = 52
        Height = 12
        Caption = #46321#47197#48264#54840
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Shape1: TShape
        Left = 160
        Top = 7
        Width = 71
        Height = 22
        Brush.Color = 4365289
        Pen.Color = clGray
      end
      object Label7: TLabel
        Left = 175
        Top = 12
        Width = 39
        Height = 12
        Caption = #54872#51088#47749
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Shape4: TShape
        Left = 351
        Top = 7
        Width = 71
        Height = 22
        Brush.Color = 4365289
        Pen.Color = clGray
      end
      object Label8: TLabel
        Left = 359
        Top = 12
        Width = 59
        Height = 12
        Caption = #49457#48324'/'#45208#51060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object fsbt_Add: TFlatSpeedButton
        Left = 485
        Top = 7
        Width = 49
        Height = 50
        Hint = #52769#51221#52628#44032' ('#52404#51473','#49888#51109','#52404#50728','#46160#50948','#53945#44592#49324#54637') '#46608#45716#13#10#44592#51316' '#52769#51221#51060#47141' '#49440#53469'('#52404#53356')'#54980', '#52769#51221#49688#51221' '#44032#45733#54633#45768#45796'.'
        ColorFocused = 4365289
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4A735C4A735C4A735C4A735C4A735C4AFF00FFB49D8D917C6A76614C76
          614C76614C76614C76614C76614C76614C76614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFBF4F1FBF4F1FA
          F4F1FAF4F0FAF2EFFBF3EEFAF2EEFAF1EE76614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFAF3F0FAF3F0F7
          8A52F78A52F78A52F78A52FAF3F0FAF3F076614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFAF3F0FAF3EFFA
          F1EFFAF1EEFAF1EDFAF1EDFAF0EDF9F0EC76614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFAF3F0FAF3EFFA
          F1EFFAF1EEFAF1EDFAF1EDFAF0EDF9F0EC76614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CC5B3A4C5B2A3C5
          B2A4C4B2A4C4B1A2C4B1A2C3B1A2C3B0A276614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFCF7F4FCF6F4FC
          F6F4FBF6F3FBF5F3FBF5F2FBF4F1FBF4F176614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFCF6F4FCF6F4F7
          8A52F78A52F78A52F78A52FBF3F0FBF3F076614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB39D8CFBF6F4FCF5F3FB
          F5F2FBF5F1FAF4F1FAF4F0FBF3F0FAF3F076614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8D917C6A76614C7661
          4C76614C76614C76614C76614C76614CFF00FFFF00FFB49D8DFBF6F2FBF5F2FB
          F4F2FBF4F1FBF4F1FAF3F0FAF3EFFAF3EF76614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFBF5F2FBF3F1FBF3
          EFFAF2EFFAF1EDFAF1EDF9F1EC76614CFF00FFFF00FFB49D8CC7B5A7C7B4A6C7
          B4A5C6B3A5C6B3A5C5B4A5C5B3A4C5B3A476614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFBF6F4FBF5F3FBF4
          F1735C4AFBF3F0FAF2EEFAF1ED76614CFF00FFFF00FFB49D8DFDF9F8FDF9F7FD
          F8F7FCF9F6FCF8F6FCF7F5FCF7F5FCF7F576614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFCF7F5FCF6F4FCF5
          F3735C4AFAF4F1FBF2F0FAF2EF76614CFF00FFFF00FFB49D8CFEFBFAFEFBFAF7
          8A52F78A52F78A52F78A52FDF9F7FDF9F776614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFDF8F6735C4A735C
          4A735C4A735C4A735C4AFBF3F076614CFF00FFFF00FFB49D8CFCF8F7FCF8F6FC
          F7F5FDF7F5FCF6F5FCF7F4FBF6F3FCF6F376614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFDF9F8FDF9F7FCF8
          F6735C4AFCF6F4FBF6F3FBF4F276614CFF00FFFF00FFB49D8DFCF8F6FCF7F5FC
          F7F5FCF7F4FCF6F4FCF6F3FCF6F3FBF5F276614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFEFAF9FDFAF8FCF9
          F7735C4AFCF7F6FCF7F5FCF6F378614CFF00FFFF00FFB49D8CC8B7A8C8B7A8C8
          B7A7C7B6A7C7B5A7C7B6A6C7B5A6C6B5A676614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFEFBFAFDFAF9FDFA
          F9FDF9F8FDF8F6FDF8F6FCF7F4917C6AFF00FFFF00FFB49D8CFDFCFAFEFBFAFE
          FBF9FEFBF9FEFAF9FDFAF8FDF9F8FDF9F876614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DB49D8DB49D8DB49D
          8DB49D8DB49D8DB49D8DB49D8DB49D8DFF00FFFF00FFB49D8CFEFBFAFEFBFAF7
          8A52F78A52F78A52F78A52FDF9F7FDF9F776614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF1B5C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFDFAF9FEFBF9FE
          FAF8FDFAF8FDFAF7FDF9F7FCF9F7FCF8F676614CFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF307B441F6030FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8DFEFAF8FDFAF8FD
          FAF7FDFAF8FCF8F7FDF8F7FCF8F6FCF7F576614CFF00FFFF00FFFF00FF296F3C
          296F3C296F3C226B3649945E6CBC832A753EFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CCAB9A9CAB9A9CA
          B8A9CAB8AACAB8A9C9B7A8C9B7A8C8B7A876614CFF00FFFF00FFFF00FF327E45
          63B27963B27963B27963B27963B2797ACE912A753EFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFEFCFBFDFCFBFE
          FCFBFEFCFBFEFBFBFEFBFBFEFCFAFDFBFA76614CFF00FFFF00FFFF00FF418D55
          75C68C75C68C75C68C75C68C75C68C75C68C7ACE912A753EFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFEFCFBFEFCFBF7
          8A52F78A52F78A52F78A52FEFBF9FEFBF976614CFF00FFFF00FFFF00FF56A26A
          87E6A387E6A38CECA985E19F75C68C8BF2AA2A753EFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFEFCFBFEFCFAFE
          FBFAFDFCFAFEFBFAFDFBFAFDFBF9FEFAF978614CFF00FFFF00FFFF00FF5AA66F
          5AA66F5AA66F5AA66F6BBF838BF2AA3C8750FF00FFFF00FFFF00FFFF00FFFF00
          FF735C4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB49D8CFEFBFAFEFCFAFE
          FCFAFEFBFAFDFAFAFEFBF9FEFAF9FDFAF8917C6AFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF63AE7956A26BFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF735C4A735C4A735C4A735C4A735C4A735C4AFF00FFB49D8CB49D8CB49D8DB4
          9D8CB49D8CB49D8CB49D8DB49D8DB49D8DB49D8DFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF5AA66FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = fsbt_AddClick
      end
      object sbt_Refresh: TSpeedButton
        Left = 3
        Top = 827
        Width = 95
        Height = 27
        Caption = #44060#48156#51088' Refresh'
        OnClick = sbt_RefreshClick
      end
      object sbt_ZoomIn: TSpeedButton
        Left = 2
        Top = 800
        Width = 96
        Height = 27
        Caption = #44060#48156#51088' '#46027#48372#44592
        OnClick = sbt_ZoomInClick
      end
      object fed_PatNo: TEdit
        Left = 80
        Top = 7
        Width = 78
        Height = 22
        Hint = '8'#51088#47532' '#46321#47197#48264#54840#47484' '#51077#47141#54616#49464#50836'.'
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = []
        ImeName = #54620#44397#50612'('#54620#44544')'
        MaxLength = 30
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = fed_PatNoChange
        OnEnter = fed_PatNoEnter
        OnKeyDown = fed_PatNoKeyDown
      end
      object fed_PatName: TEdit
        Left = 233
        Top = 7
        Width = 116
        Height = 22
        Hint = '8'#51088#47532' '#46321#47197#48264#54840' '#51077#47141#54980', '#45824#49345#54872#51088' '#44160#49353' '#46608#45716' '#49888#44256#45236#50669' '#51312#54924#44032' '#44032#45733#54633#45768#45796'.'
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = []
        ImeName = #54620#44397#50612'('#54620#44544')'
        MaxLength = 30
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 5
      end
      object fed_SexAge: TEdit
        Left = 424
        Top = 7
        Width = 58
        Height = 22
        Hint = '8'#51088#47532' '#46321#47197#48264#54840' '#51077#47141#54980', '#45824#49345#54872#51088' '#44160#49353' '#46608#45716' '#49888#44256#45236#50669' '#51312#54924#44032' '#44032#45733#54633#45768#45796'.'
        AutoSize = False
        Color = clWhite
        Ctl3D = False
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #44404#47548#52404
        Font.Style = []
        ImeName = #54620#44397#50612'('#54620#44544')'
        MaxLength = 30
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = False
        TabOrder = 6
      end
      object fcb_MedDept: TFlatComboBox
        Left = 81
        Top = 36
        Width = 150
        Height = 21
        Color = clWhite
        ColorArrowBackground = 4365289
        ColorBorder = 14013909
        TabOrder = 1
        ItemIndex = -1
      end
      object fbt_Search: TFlatButton
        Left = 350
        Top = 35
        Width = 132
        Height = 22
        Hint = #54872#51088#51032' '#52769#51221#51060#47141' '#49345#49464#51312#54924
        ColorFocused = 4365289
        Caption = #51312' '#54924
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000420B0000420B00000000000000000000FF00FF2173B5
          636B73FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF2173B5218CEF2173B5636B73FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF31A5FF52BDFF
          218CEF2173B5636B73FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF31A5FF52BDFF218CEF2173B5636B73FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          31A5FF52BDFF218CEF2173B5636B73FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF31A5FF52BDFF218CEF5A6B73FF
          00FFD5B9B4D6ADA5D6ADA5D6ADA5D5B9B4FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF31A5FF31A5FF4A4239B69B8BF0E2C0F9EFC8FDF2CBFEF4CCECD8
          C2D6ADA5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBB9F88F3
          E3B6FCF3D1FEF6CDFEF7CFFEF9D0FDF7D2F5E6C2D6ADA5FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFD5B9B4EFE1B5FAEDBDFFF1C1FFF3C2FFF5C4FFF7C5FFFA
          C7FDF8D2D6ADA5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD6ADA5EFE3B6FB
          ECBEFDEFBFFEF1C1FFF2C2FFF4C4FFF7C5FFF9C7EEE2BBD6ADA5FF00FFFF00FF
          FF00FFFF00FFFF00FFD6ADA5EDE1B4F6E9BEFCF1D3FCF0C9FEF0C1FFF1C2FFF4
          C3FFF6C5F6E9C2CBAF9CFF00FFFF00FFFF00FFFF00FFFF00FFD6ADA5EBDEB2F2
          E6BBFCF2D7FCF1D3FCEEC0FEEFC2FFF2C2FEF2C2EFE1BBD2B3A3FF00FFFF00FF
          FF00FFFF00FFFF00FFD5B9B4E4D8B0EDE1B6F3E7BCF8EBC0F9EBBCFBEDBEFAEC
          BDF5E9BAD6ADA5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD6ADA5EA
          DFBCECE0B6F0E3B6F1E5B7F2E5B7EFE3B5F5E7BCD5B9B4FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFD6ADA5E0D4B5EADEB4EBDEB1E8DBB1D6AD
          A5D5B9B4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFD5B9B4D6ADA5D6ADA5D9B7A3FF00FFFF00FFFF00FFFF00FF}
        Layout = blGlyphLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = fbt_SearchClick
      end
      object fbt_Delete: TFlatButton
        Left = 387
        Top = 821
        Width = 100
        Height = 29
        Hint = #49440#53469#54620' '#52769#51221#51060#47141' '#49325#51228
        ColorFocused = 4365289
        Caption = #49325' '#51228
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFB39B8F907860907860A18574FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08880C0
          A090F0E0D0D0C8C0B09890705040FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFC0A890F0E0E0F0D8D0F0F0F0FFFFFFD0C8C0B098907058
          40FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0A890F0F0F0FF
          FFFFFFFFFFF0E8E0FFF8F0D0C8C0B09890775F47FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFD0A8A0F0F0F0FFFFFFF0F0F0F0E0D0FFF8F0D0C8
          C0B09890705840FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0
          A8A0F0F0F0FFFFFFF0F0F0F0E0D0FFF8F0D0C8C0B09890604830FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0B0A0F0F0F0FFFFFFF0F0F0F0D8
          D0FFF8F0D0C8C0866656B49C8C806D59806D59806D59806D59806D59806D5980
          6D59806D59D0B0A0F0F0F0FFFFFFF0F0F0F0E8E0FFFFFFB09880B49C8CF8EFEA
          F8EFEAF8EFEAF8EFEAF8EFEAF8EFEAF8EFEAF8EFEAF8EFEAD0A8A0F0F0F0FFFF
          FFFFF8FFC0A8A0FF00FFB49C8CF8EFEA696462F8EFEAF8EFEAF8EFEA696462DB
          D3CE696462DBD3CEF8EFEAD0B0A0C0A090B09880FF00FFFF00FFB49C8CF8EFEA
          DBD3CE696462696462696462DBD3CE696462F8EFEA696462F8EFEAF8EFEA806D
          59FF00FFFF00FFFF00FFB49C8CFAF5F1FAF5F1696462FAF5F1696462FAF5F1FA
          F5F1696462696462FAF5F1FAF5F1806D59FF00FFFF00FFFF00FFB49C8CFDFBFA
          FDFBFADFDCDB696462DFDCDBFDFBFA696462FDFBFA696462FDFBFAFDFBFA806D
          59FF00FFFF00FFFF00FFB49C8CFFFFFFFFFFFFFFFFFF696462FFFFFFFFFFFFE1
          E0DF696462E1E0DFFFFFFFFFFFFF806D59FF00FFFF00FFFF00FFB49C8CFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF806D
          59FF00FFFF00FFFF00FFB49C8CB49C8CB49C8CB49C8CB49C8CB49C8CB49C8CB4
          9C8CB49C8CB49C8CB49C8CB49C8CB49C8CFF00FFFF00FFFF00FF}
        Layout = blGlyphLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = fbt_DeleteClick
      end
      object fbt_Close: TFlatButton
        Left = 491
        Top = 821
        Width = 100
        Height = 29
        Hint = #49457#51109#48156#50977#44257#49440' Chart '#51333#47308
        ColorFocused = 4365289
        Caption = #51333' '#47308
        Glyph.Data = {
          BA040000424DBA04000000000000360000002800000016000000110000000100
          1800000000008404000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62FFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00049B00
          0091000091000091000092000096FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00039B
          002EFF0033FF0034FF0032FF0036FF0028D4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF736A62FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0000940000910000
          92002EFF002FFF3DADFF0026FF3DADFF002DFF0023D07C6F5A736A62736A62FF
          FFFFFFFFFF736A62FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0029CD00
          2EFF002EFF002EFF0029FF3BA8FF0023FF3BA8FF002BFF0023D0FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF736A62FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          0021C9FFCCFFFFCCFF0036FF0036FF37A5FF0136FF39A6FF053FFF0022D0FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF736A62FFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFF0027CB001FC90019C6FFCCFF0C63FF239BFF0C63FF279DFF0C63FF00
          1ED07C6F5A736A62736A62FFFFFFFFFFFF736A62FFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A35CDFFCCFFFFCCFFFFCCFFFFCCFF
          FFCCFF001CD0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62FFFFFFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1534CD001DC8001D
          C8001DC8001FC90026CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736A62
          FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF736A62FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
        Layout = blGlyphLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = fbt_CloseClick
      end
      object cbx_OtherDept: TCheckBox
        Left = 243
        Top = 31
        Width = 98
        Height = 17
        Hint = #53440#44284' '#52769#51221#51060#47141#51012' '#54252#54632#54616#50668' '#44160#49353#54633#45768#45796'.'
        Caption = #53440#44284#44592#47197' '#54252#54632
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object cbx_AdmIncluded: TCheckBox
        Left = 243
        Top = 46
        Width = 95
        Height = 17
        Hint = #51077#50896#49884' '#52769#51221#51060#47141#51012' '#51312#54924#54616#44256' Chart'#50640' '#50672#46041#54633#45768#45796'.'
        Caption = #51077#50896#51060#47141' '#54252#54632
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object asg_BodyInfo: TAdvStringGrid
        Left = 1
        Top = 69
        Width = 585
        Height = 729
        Cursor = crDefault
        ColCount = 13
        Ctl3D = False
        DrawingStyle = gdsClassic
        FixedColor = clMaroon
        FixedCols = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = True
        TabOrder = 9
        OnClick = asg_BodyInfoClick
        OnDblClick = asg_BodyInfoDblClick
        OnMouseMove = asg_BodyInfoMouseMove
        GridLineColor = clGray
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = asg_BodyInfoGetAlignment
        OnCanEditCell = asg_BodyInfoCanEditCell
        HintColor = 2150379
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        Bands.Active = True
        Bands.PrimaryColor = 15329769
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          ''
          #52769#51221#51068#51088
          #51652#47308#44284
          #45380
          #44060#50900
          #52509#44060#50900#49688
          #52404#51473'(kg)'
          #49888#51109'(cm)'
          #46160#50948'(cm)'
          'BMI'
          #53945#44592#49324#54637)
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        ControlLook.NoDisabledButtonLook = True
        EnhRowColMove = False
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 20
        FixedRowHeight = 22
        FixedRowAlways = True
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = 4365289
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        Flat = True
        FloatFormat = '%.2f'
        HideFocusRect = True
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glSoft
        MouseActions.DirectEdit = True
        Navigation.AdvanceOnEnter = True
        Navigation.AutoComboDropSize = True
        Navigation.TabToNextAtEnd = True
        PrintSettings.Date = ppBottomRight
        PrintSettings.DateFormat = 'yyyy-mm-dd hh:nn'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PagePrefix = 'page'
        PrintSettings.PageNumSep = '/'
        ScrollWidth = 16
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = 6862847
        SelectionTextColor = clNavy
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        URLColor = clBlack
        Version = '7.8.6.0'
        ColWidths = (
          20
          67
          43
          26
          31
          54
          50
          52
          52
          40
          124
          64
          64)
        RowHeights = (
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22)
      end
      object fbt_Print: TFlatButton
        Left = 283
        Top = 821
        Width = 100
        Height = 29
        Hint = 'Growth Chart '#52636#47141
        ColorFocused = 4365289
        Caption = #52636' '#47141
        Glyph.Data = {
          6E040000424D6E04000000000000360000002800000014000000120000000100
          1800000000003804000000000000000000000000000000000000C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C35F544A42372B4236
          2B42362B42362B42362B42362B42362B42362B42362B42362B42362B42362B42
          362B42372B5F544AC3C3C3C3C3C3C3C3C3C3C3C3736960FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF736960C3C3C3C3C3C3C3C3C3C3C3C3756A61FFFFFFC6BBAFC9BFB4C8BDB3C8
          BDB3C9BFB4C8BDB3C8BDB3C9BFB4C8BDB3C8BDB3C9BFB4C6BBAFFFFFFF756A61
          C3C3C3C3C3C3C3C3C3C3C3C3786D64FFFFFFF7F2EDCDC2B9F8F3EFF8F3EFCDC2
          B9F8F3EFF8F3EFCDC2B9F8F3EFF8F3EFCDC2B9F7F2EDFFFFFF786D64C3C3C3C3
          C3C3C3C3C3C3C3C37B7067FFFFFF663333CEC5BCF9F5F0F9F5F0CEC5BCF9F5F0
          F9F5F0CEC5BCF9F5F0F9F5F0CEC5BCF8F4EFFFFFFF7B7067C3C3C3C3C3C3C3C3
          C3C3C3C37F756AFFFFFFD0C6BC663333D2C8BFD2C8BFD4CBC2663333D2C8BFD4
          CBC2D2C8BFD2C8BFD4CBC2D0C6BCFFFFFF7F756AC3C3C3C3C3C3C3C3C3C3C3C3
          82786DFFFFFFFBF8F4D4CBC2663333FCF9F5663333FCF9F5663333D4CBC2FCF9
          F5FCF9F5D4CBC2FBF8F4FFFFFF82786DC3C3C3C3C3C3C3C3C3C3C3C3877B70FF
          FFFFFCFAF7D7CDC5FCFBF8663333D7CDC5FCFBF8FCFBF8663333FCFBF8FCFBF8
          D7CDC5FCFAF7FFFFFF877B70C3C3C3C3C3C3C3C3C3C3C3C38A7E73FFFFFFD8CF
          C6DBD3CBD9D0C8D9D0C8DBD3CBD9D0C8D9D0C8DBD3CB663333D9D0C8DBD3CBD8
          CFC6FFFFFF8A7E73C3C3C3C3C3C3C3C3C3C3C3C38E8277FFFFFFFFFDFDDCD3CB
          FFFEFDFFFEFDDCD3CBFFFEFDFFFEFDDCD3CBFFFEFD663333DCD3CBFFFDFDFFFF
          FF8E8277C3C3C3C3C3C3C3C3C3C3C3C391867AFFFFFFFFFFFFDFD6CEFFFFFFFF
          FFFFDFD6CEFFFFFFFFFFFFDFD6CEFFFFFFFFFFFF663333663333FFFFFF91867A
          C3C3C3C3C3C3C3C3C3C3C3C395897DFFFFFFE0D8CFE2DBD2E1DAD1E1DAD1E2DB
          D2E1DAD1E1DAD1E2DBD2E1DAD1E1DAD1E2DBD2E0D8CFFFFFFF95897DC3C3C3C3
          C3C3C3C3C3C3C3C3998D81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF998D81C3C3C3C3C3C3C3C3
          C3C3C3C3A094899D90849C8F849C8F849C8F849C8F849C8F849C8F849C8F849C
          8F849C8F849C8F849C8F849C8F849D9084A09489C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3}
        Layout = blGlyphLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = fbt_PrintClick
      end
      object fbt_NeoChart: TFlatButton
        Left = 160
        Top = 821
        Width = 119
        Height = 29
        Hint = 'WHO'#54364#51456' '#49888#49373#50500' '#49457#51109#48156#50977#44257#49440' Chart '#51312#54924
        ColorFocused = 4365289
        Caption = #49888#49373#50500#50857' Chart'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFA6480AA3450AA0410A9E3E0A9A3C0A993A0A96
          370A93350A91320A8E300A8C2E0A8A2B0A892A0A87290AFF00FFFF00FFA94A0A
          FCF5EBFCF5EBFBF4E5FBF1E1FCEEDBFBECD4FBEBD0FBE8CAFBE5C5FBE4BFFBE1
          B9FBE1B9892A0AFF00FFFF00FFAC4D0AFCF7F0FCF7F0D6C5B8BF9E7258ADAD16
          ACD9159BD12C8DB67B96A1F2E0C1FBE4C0FBE4C08B2B0AFF00FFFF00FFAE500A
          FCF9F5D3C7C2BB8662FCDB9667DDDD1FDBFC14C9FC0DBEF80AA7E45D8599FBE5
          C5FBE5C58D2E0AFF00FFFF00FFB2540AFCFBF8B69E99E4AD7AF4B170ACA77436
          DDF023E2FC17D7FC0CD4FC28839CF5E2C7FBE8CC8E300AFF00FFFF00FFB6570A
          FCFBFCBFACA9F0B777ECAB62FB9B415F6A700D50C00D50C40B54C60C3AB18B83
          96FCEBD292330AFF00FFFF00FFB95B0AFCFCFCEEEBEBB38F71EDB0618F62480E
          0A7C0E1EC70E23D80C1BD90A18DD8A85A0FCEED994350AFF00FFFF00FFBC5D0A
          FCFCFCFCFCFCFCFCFCE4D9C97C7487133AD82164FC174AFC1336E24D58A6EBE1
          D3FBF0DF98380AFF00FFFF00FFBE610AFCFCFCFCFCFCFCFCFCFCFCFCDDDDE98F
          99D67F87C79599CAC9C6D3FCF5E9FBF4E4FBF4E49A3B0AFF00FFFF00FFC0620A
          FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCF9FCFBF7FCF8F4FCF7EEFCF6
          EBFCF6EB9C3D0AFF00FFFF00FFC2650AFCFCFCFCFCFCC6690ABF620AB7590AAD
          4F0AA5460A9A3C0A93340A8B2C0AFCF7F0FCF7F0A0400AFF00FFFF00FFC5680A
          FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF8FCF9
          F5FCF9F5A2440AFF00FFFF00FFC76A0AFCFCFCFCFCFCCB6E0AC5680ABD600AB5
          560AAC4D0AA1430A993A0A91320AFCFBF7FCFBF7A6480AFF00FFFF00FFC96C0A
          FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFB
          F7FCFBF7A94A0AFF00FFFF00FFCA6D0AC96C0AC66A0AC5690AC2670AC1630ABF
          620ABC5F0AB95C0AB7590AB5560AB2530AAE500AAC4D0AFF00FF}
        Layout = blGlyphLeft
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        Visible = False
        OnClick = fbt_NeoChartClick
      end
    end
    object apn_PdBodAdd: TAdvPanel
      Left = 719
      Top = 467
      Width = 340
      Height = 203
      BevelInner = bvLowered
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UseDockManager = True
      Visible = False
      Version = '2.4.1.0'
      AutoHideChildren = False
      BorderShadow = True
      CanMove = True
      Caption.Color = clWhite
      Caption.ColorTo = 4365289
      Caption.CloseButton = True
      Caption.Flat = True
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clMaroon
      Caption.Font.Height = -12
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = [fsBold]
      Caption.Height = 25
      Caption.Indent = 5
      Caption.Text = #49888#52404#52769#51221' '#52628#44032
      Caption.TopIndent = 2
      Caption.Visible = True
      CollapsDelay = 8
      CollapsSteps = 10
      DoubleBuffered = True
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      Text = ''
      FullHeight = 90
      object asg_PdBodAdd: TAdvStringGrid
        Left = 1
        Top = 24
        Width = 338
        Height = 178
        Cursor = crDefault
        Align = alClient
        BorderStyle = bsNone
        ColCount = 2
        Ctl3D = False
        DefaultColWidth = 80
        DrawingStyle = gdsClassic
        FixedColor = 5798615
        RowCount = 8
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssNone
        ShowHint = False
        TabOrder = 0
        OnKeyPress = asg_PdBodAddKeyPress
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = asg_PdBodAddGetAlignment
        OnCanEditCell = asg_PdBodAddCanEditCell
        OnGetEditorType = asg_PdBodAddGetEditorType
        OnButtonClick = asg_PdBodAddButtonClick
        OnEditingDone = asg_PdBodAddEditingDone
        HintColor = 13754291
        HintShowCells = True
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          #44396#48516
          #54924#49324#47749
          #44592#44396#47749
          #49688#47049
          #45812#45817#51088
          #50672#46973#52376'1'
          #50672#46973#52376'2'
          'Remark'
          #46321#47197#51068
          '')
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        ControlLook.NoDisabledButtonLook = True
        EnhRowColMove = False
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 80
        FixedRowHeight = 22
        FixedColAlways = True
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWhite
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        Flat = True
        FloatFormat = '%.2f'
        HideFocusRect = True
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glSoft
        MouseActions.DirectEdit = True
        Navigation.AdvanceOnEnter = True
        Navigation.AutoComboDropSize = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PagePrefix = 'page'
        PrintSettings.PageNumSep = '/'
        RowHeaders.Strings = (
          #52769#51221#51068#51088
          #52769#51221#49884#44036
          #51652#47308#44284
          #52404#51473'(kg)'
          #49888#51109'(cm)'
          #46160#50948'(cm)'
          #53945#44592#49324#54637)
        ScrollWidth = 16
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = 16772569
        ShowSelection = False
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        URLColor = clBlack
        Version = '7.8.6.0'
        WordWrap = False
        ColWidths = (
          80
          258)
        RowHeights = (
          22
          22
          22
          22
          22
          22
          22
          22)
      end
    end
    object apn_NeoBornWks: TAdvPanel
      Left = 623
      Top = 307
      Width = 331
      Height = 117
      BevelInner = bvLowered
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UseDockManager = True
      Visible = False
      Version = '2.4.1.0'
      AutoHideChildren = False
      BorderShadow = True
      CanMove = True
      Caption.Color = clWhite
      Caption.ColorTo = 4365289
      Caption.Flat = True
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clMaroon
      Caption.Font.Height = -12
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = [fsBold]
      Caption.Height = 25
      Caption.Indent = 5
      Caption.Text = #49888#49373#50500' '#52636#49373#51452#49688' '#54869#51064
      Caption.TopIndent = 2
      Caption.Visible = True
      CollapsDelay = 8
      CollapsSteps = 10
      DoubleBuffered = True
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      Text = ''
      FullHeight = 90
      object FlatPanel2: TFlatPanel
        Left = 0
        Top = 24
        Width = 328
        Height = 93
        Color = clWhite
        TabOrder = 0
        UseDockManager = True
        object Shape6: TShape
          Left = 7
          Top = 5
          Width = 314
          Height = 56
          Brush.Color = 4365289
          Pen.Color = clGray
        end
        object Label2: TLabel
          Left = 16
          Top = 27
          Width = 302
          Height = 12
          Caption = #49457#51109#44257#49440' '#52264#54021#51012' '#50948#54620' '#52636#49373#49884' '#51452#49688#47484' '#51077#47141#54616#49464#50836'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Shape7: TShape
          Left = 31
          Top = 65
          Width = 71
          Height = 22
          Brush.Color = 4365289
          Pen.Color = clGray
        end
        object Label3: TLabel
          Left = 37
          Top = 70
          Width = 61
          Height = 12
          Caption = #51452#49688'(wks)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Shape8: TShape
          Left = 177
          Top = 65
          Width = 71
          Height = 22
          Brush.Color = 4365289
          Pen.Color = clGray
        end
        object Label4: TLabel
          Left = 188
          Top = 70
          Width = 48
          Height = 12
          Caption = #51068'(day)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 160
          Top = 69
          Width = 10
          Height = 14
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object Label11: TLabel
          Left = 11
          Top = 10
          Width = 308
          Height = 12
          Caption = #48376#50896' '#49888#49373#50500' '#44036#54840#51221#48372#51312#49324#51648' '#51089#49457#51060#47141#51060' '#50630#49845#45768#45796'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label12: TLabel
          Left = 60
          Top = 44
          Width = 220
          Height = 12
          Caption = '('#51068#49688#44620#51648' '#51077#47141#54980', Enter '#45572#47476#49464#50836')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object fed_Wks: TEdit
          Left = 105
          Top = 65
          Width = 48
          Height = 22
          Hint = '2'#51088#47532' '#49707#51088#51077#47141#54980' '#51088#46041#51004#47196' '#51068'(Day)'#47196' '#45336#50612#44049#45768#45796'.'
          AutoSize = False
          Color = clWhite
          Ctl3D = False
          Font.Charset = HANGEUL_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = []
          ImeName = #54620#44397#50612'('#54620#44544')'
          MaxLength = 2
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = fed_WksChange
        end
        object fed_Day: TEdit
          Left = 251
          Top = 65
          Width = 48
          Height = 22
          Hint = '1'#51088#47532' '#49707#51088' '#51077#47141#54980', Enter'#47484' '#45580#47084#51452#49464#50836'.'
          AutoSize = False
          Color = clWhite
          Ctl3D = False
          Font.Charset = HANGEUL_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #44404#47548#52404
          Font.Style = []
          ImeName = #54620#44397#50612'('#54620#44544')'
          MaxLength = 1
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnKeyDown = fed_DayKeyDown
        end
      end
    end
    object apn_NormsDist: TAdvPanel
      Left = 1215
      Top = 70
      Width = 123
      Height = 724
      BevelInner = bvLowered
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UseDockManager = True
      Visible = False
      Version = '2.4.1.0'
      AutoHideChildren = False
      BorderShadow = True
      CanMove = True
      Caption.Color = clWhite
      Caption.ColorTo = 4365289
      Caption.CloseButton = True
      Caption.Flat = True
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clMaroon
      Caption.Font.Height = -12
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = [fsBold]
      Caption.Height = 25
      Caption.Indent = 5
      Caption.Text = #49888#52404#52769#51221' '#52628#44032
      Caption.TopIndent = 2
      CollapsDelay = 8
      CollapsSteps = 10
      DoubleBuffered = True
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      Text = ''
      FullHeight = 90
      object asg_NormsDist: TAdvStringGrid
        Left = 0
        Top = 0
        Width = 125
        Height = 729
        Cursor = crDefault
        ColCount = 1
        Ctl3D = False
        DrawingStyle = gdsClassic
        FixedColor = clMaroon
        FixedCols = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssNone
        ShowHint = True
        TabOrder = 0
        OnMouseMove = asg_BodyInfoMouseMove
        GridLineColor = clGray
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = asg_NormsDistGetAlignment
        HintColor = 2150379
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        Bands.Active = True
        Bands.PrimaryColor = 15329769
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          #48177#48516#50948'('#52404#51473'|'#49888#51109'|BMI)')
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        ControlLook.NoDisabledButtonLook = True
        EnhRowColMove = False
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 123
        FixedRowHeight = 22
        FixedRowAlways = True
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = 4365289
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        Flat = True
        FloatFormat = '%.2f'
        HideFocusRect = True
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glSoft
        MouseActions.DirectEdit = True
        Navigation.AdvanceOnEnter = True
        Navigation.AutoComboDropSize = True
        Navigation.TabToNextAtEnd = True
        PrintSettings.Date = ppBottomRight
        PrintSettings.DateFormat = 'yyyy-mm-dd hh:nn'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PagePrefix = 'page'
        PrintSettings.PageNumSep = '/'
        RowHeaders.Strings = (
          '')
        ScrollWidth = 16
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = 6862847
        SelectionTextColor = clNavy
        ShowSelection = False
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        URLColor = clBlack
        Version = '7.8.6.0'
        ColWidths = (
          123)
        RowHeights = (
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22)
      end
    end
    object Advpn_Log: TAdvPanel
      Left = 712
      Top = 112
      Width = 385
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      UseDockManager = True
      Version = '2.4.1.0'
      AutoHideChildren = False
      CanMove = True
      Caption.Color = clHighlight
      Caption.ColorTo = clNone
      Caption.CloseButton = True
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clHighlightText
      Caption.Font.Height = -12
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = [fsBold]
      Caption.Height = 25
      Caption.Indent = 5
      Caption.MinMaxButton = True
      Caption.Text = 'Debugging Log'
      Caption.TopIndent = 2
      Caption.Visible = True
      Collaps = True
      DoubleBuffered = True
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      Text = ''
      FullHeight = 660
      object Memo1: TMemo
        Left = 1
        Top = 24
        Width = 383
        Height = 635
        ImeName = 'Microsoft Office IME 2007'
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
