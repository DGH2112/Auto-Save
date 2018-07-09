object fmIDEAutoSaveOptions: TfmIDEAutoSaveOptions
  Left = 0
  Top = 0
  Width = 325
  Height = 300
  Constraints.MinHeight = 300
  Constraints.MinWidth = 325
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  DesignSize = (
    325
    300)
  object gbxAutoSaveOptions: TGroupBox
    Left = 3
    Top = 31
    Width = 319
    Height = 77
    Anchors = [akLeft, akTop, akRight]
    Caption = 'AutoSave Options'
    TabOrder = 0
    ExplicitWidth = 375
    DesignSize = (
      319
      77)
    object lblAutoSaveInterval: TLabel
      Left = 16
      Top = 25
      Width = 105
      Height = 16
      Caption = 'Auto Save &Interval'
      FocusControl = edtAutosaveInterval
    end
    object edtAutosaveInterval: TEdit
      Left = 247
      Top = 22
      Width = 48
      Height = 24
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = '60'
      ExplicitLeft = 303
    end
    object udAutoSaveInterval: TUpDown
      Left = 295
      Top = 22
      Width = 16
      Height = 24
      Anchors = [akTop, akRight]
      Associate = edtAutosaveInterval
      Min = 60
      Max = 3600
      Position = 60
      TabOrder = 1
      ExplicitLeft = 351
    end
    object cbxPrompt: TCheckBox
      Left = 16
      Top = 47
      Width = 292
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Prompt'
      TabOrder = 2
      ExplicitWidth = 348
    end
  end
  object chkEnabled: TCheckBox
    Left = 8
    Top = 8
    Width = 304
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = '&Enabled AutoSave'
    TabOrder = 1
    OnClick = chkEnabledClick
    ExplicitWidth = 360
  end
  object rgrpCompileType: TRadioGroup
    Left = 3
    Top = 114
    Width = 319
    Height = 160
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'AutoSave Options for Compilations'
    Items.Strings = (
      '&Disabled'
      'AutoSave files &Before compiling ALL Projects'
      'AutoSave files Before compile &each Project'
      'AutoSave files After compile e&ach Project'
      'AutoSave files &After compiling ALL Projects')
    TabOrder = 2
  end
  object chkMessages: TCheckBox
    Left = 8
    Top = 280
    Width = 314
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Output messages for each file saved.'
    TabOrder = 3
  end
end
