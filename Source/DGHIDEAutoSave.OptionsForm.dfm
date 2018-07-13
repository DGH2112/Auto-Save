object frmAutoSaveOptions: TfrmAutoSaveOptions
  Left = 443
  Top = 427
  BorderStyle = bsDialog
  Caption = 'Auto Save Options'
  ClientHeight = 349
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    335
    349)
  PixelsPerInch = 96
  TextHeight = 16
  object btnCancel: TBitBtn
    Left = 252
    Top = 316
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
    ExplicitLeft = 329
    ExplicitTop = 266
  end
  object btnOK: TBitBtn
    Left = 171
    Top = 316
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    ExplicitLeft = 248
    ExplicitTop = 266
  end
  object pnlFrame: TPanel
    Left = 8
    Top = 8
    Width = 319
    Height = 302
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 396
    ExplicitHeight = 252
  end
end
