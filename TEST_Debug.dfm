object DebugForm: TDebugForm
  Left = 320
  Top = 14
  Width = 703
  Height = 346
  Caption = 'debug'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DebugListBox: TListBox
    Left = 5
    Top = 8
    Width = 681
    Height = 273
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 600
    Top = 288
    Width = 89
    Height = 17
    Caption = 'Clear'
    TabOrder = 1
    OnClick = Button1Click
  end
end
