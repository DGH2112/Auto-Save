object frmAutoSaveOptions: TfrmAutoSaveOptions
  Left = 443
  Top = 427
  BorderStyle = bsDialog
  Caption = 'Auto Save Options'
  ClientHeight = 299
  ClientWidth = 412
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
    412
    299)
  PixelsPerInch = 96
  TextHeight = 16
  object btnCancel: TBitBtn
    Left = 329
    Top = 266
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
    ExplicitLeft = 263
    ExplicitTop = 126
  end
  object btnOK: TBitBtn
    Left = 248
    Top = 266
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    ExplicitLeft = 182
    ExplicitTop = 126
  end
  object pnlFrame: TPanel
    Left = 8
    Top = 8
    Width = 396
    Height = 252
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 330
    ExplicitHeight = 112
  end
end
