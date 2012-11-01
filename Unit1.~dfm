object Form1: TForm1
  Left = 468
  Top = 115
  Width = 580
  Height = 547
  Caption = #1063#1080#1089#1090#1082#1072' '#1052#1091#1089#1086#1088#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 494
    Width = 572
    Height = 19
    Panels = <
      item
        Text = #1054#1090#1082#1088#1099#1090#1086' '#1076#1080#1088#1088#1077#1082#1090#1086#1088#1080#1081': 0'
        Width = 170
      end
      item
        Text = #1042#1089#1077#1075#1086': 0 '#1092#1072#1083#1086#1074
        Width = 120
      end
      item
        Width = 150
      end>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 572
    Height = 23
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 93
    Caption = 'ToolBar1'
    Flat = True
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = aOpen
    end
    object ToolButton3: TToolButton
      Left = 93
      Top = 0
      Action = aClear
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 190
      Top = 0
      Action = aDelete
      Caption = #1053#1072#1081#1090#1080' '#1087#1086#1074#1090#1086#1088#1099
    end
    object ToolButton6: TToolButton
      Left = 283
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 1
      Visible = False
    end
    object ToolButton4: TToolButton
      Left = 376
      Top = 0
      Action = aClose
    end
    object ToolButton5: TToolButton
      Left = 469
      Top = 0
      Caption = #1089#1086#1079#1076#1072#1090#1077#1083#1080
      ImageIndex = 0
      OnClick = ToolButton5Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 57
    Width = 572
    Height = 437
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 23
    Width = 572
    Height = 34
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 26
      Top = 9
      Width = 74
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      OnClick = Label1Click
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Panel2: TPanel
      Left = 130
      Top = 1
      Width = 441
      Height = 32
      Align = alRight
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 1
      object Panel3: TPanel
        Left = 208
        Top = 0
        Width = 233
        Height = 32
        Align = alRight
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 0
        object Edit2: TEdit
          Left = 63
          Top = 6
          Width = 65
          Height = 21
          TabOrder = 0
          OnChange = CheckBox1Click
          OnClick = CheckBox1Click
        end
        object ComboBox3: TComboBox
          Left = 23
          Top = 6
          Width = 37
          Height = 21
          Enabled = False
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = '<'
          Items.Strings = (
            '<')
        end
        object ComboBox4: TComboBox
          Left = 132
          Top = 6
          Width = 56
          Height = 21
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 2
          Text = #1050#1073#1072#1081#1090
          OnChange = Edit2Change
          OnClick = Edit2Change
          Items.Strings = (
            #1073#1072#1081#1090
            #1050#1073#1072#1081#1090
            #1052#1073#1072#1081#1090)
        end
      end
      object ComboBox1: TComboBox
        Left = 132
        Top = 6
        Width = 57
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 1
        Text = #1050#1073#1072#1081#1090
        OnChange = ComboBox1Change
        OnClick = ComboBox1Change
        Items.Strings = (
          #1073#1072#1081#1090
          #1050#1073#1072#1081#1090
          #1052#1073#1072#1081#1090)
      end
      object ComboBox2: TComboBox
        Left = 5
        Top = 6
        Width = 40
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 2
        Text = '>'
        OnChange = CheckBox1Click
        Items.Strings = (
          '='
          '>'
          '<'
          '<>')
      end
      object Edit1: TEdit
        Left = 52
        Top = 6
        Width = 70
        Height = 21
        TabOrder = 3
        Text = #1056#1072#1079#1084#1077#1088
        OnChange = CheckBox1Click
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 199
        Top = 8
        Width = 14
        Height = 17
        TabOrder = 4
        OnClick = CheckBox1Click
      end
    end
  end
  object ActionList1: TActionList
    Left = 24
    Top = 120
    object aOpen: TAction
      Caption = '  '#1054#1090#1082#1088#1099#1090#1100'   '
      OnExecute = aOpenExecute
    end
    object aDelete: TAction
      Caption = '   '#1059#1076#1072#1083#1080#1090#1100'   '
      OnExecute = aDeleteExecute
      OnUpdate = aDeleteUpdate
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      OnExecute = aClearExecute
      OnUpdate = aClearUpdate
    end
    object aClose: TAction
      Caption = #1042#1099#1081#1090#1080
      OnExecute = aCloseExecute
    end
    object aCheck2: TAction
    end
    object aCheck3: TAction
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 224
    Top = 112
  end
end
