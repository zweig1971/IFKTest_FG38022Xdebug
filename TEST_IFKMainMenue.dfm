object IFKMainMenue: TIFKMainMenue
  Left = 490
  Top = 327
  Width = 297
  Height = 207
  AutoSize = True
  Caption = 'IFKTesT38022X'
  Color = clBtnFace
  DefaultMonitor = dmPrimary
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 105
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object AutomaticTest_Button: TButton
      Left = 24
      Top = 24
      Width = 241
      Height = 57
      Caption = 'Automatik Test'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = AutomaticTest_ButtonClick
    end
  end
  object EXIT_Button: TButton
    Left = 80
    Top = 112
    Width = 137
    Height = 41
    Caption = 'E X I T'
    TabOrder = 1
    OnClick = EXIT_ButtonClick
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object About_Menue: TMenuItem
      Caption = 'About'
      OnClick = About_MenueClick
    end
  end
end
