object fmIDEAutoSaveOptions: TfmIDEAutoSaveOptions
  Left = 0
  Top = 0
  Width = 288
  Height = 111
  TabOrder = 0
  DesignSize = (
    288
    111)
  object gbxAutoSaveOptions: TGroupBox
    Left = 3
    Top = 31
    Width = 282
    Height = 77
    Anchors = [akLeft, akTop, akRight]
    Caption = 'AutoSave Options'
    TabOrder = 0
    DesignSize = (
      282
      77)
    object lblAutoSaveInterval: TLabel
      Left = 16
      Top = 25
      Width = 91
      Height = 13
      Caption = 'Auto Save &Interval'
      FocusControl = edtAutosaveInterval
    end
    object edtAutosaveInterval: TEdit
      Left = 210
      Top = 22
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = '60'
    end
    object udAutoSaveInterval: TUpDown
      Left = 258
      Top = 22
      Width = 16
      Height = 21
      Anchors = [akTop, akRight]
      Associate = edtAutosaveInterval
      Min = 60
      Max = 3600
      Position = 60
      TabOrder = 1
    end
    object cbxPrompt: TCheckBox
      Left = 16
      Top = 47
      Width = 255
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Prompt'
      TabOrder = 2
    end
  end
  object chkEnabled: TCheckBox
    Left = 8
    Top = 8
    Width = 267
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = '&Enabled AutoSave'
    TabOrder = 1
    OnClick = chkEnabledClick
  end
end
