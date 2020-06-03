object fmIDEAutoSaveOptions: TfmIDEAutoSaveOptions
  Left = 0
  Top = 0
  Width = 407
  Height = 415
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnlFudgePanel: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 415
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object chkEnabled: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 401
      Height = 17
      Align = alTop
      Caption = '&Enabled AutoSave'
      TabOrder = 0
      OnClick = chkEnabledClick
    end
    object chkMessages: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 109
      Width = 401
      Height = 17
      Align = alTop
      Caption = 'Output messages for each file saved.'
      TabOrder = 1
      OnClick = chkMessagesClick
    end
    object gbxAutoSaveOptions: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 26
      Width = 401
      Height = 77
      Align = alTop
      Caption = 'AutoSave Options'
      TabOrder = 2
      DesignSize = (
        401
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
        Left = 329
        Top = 22
        Width = 48
        Height = 24
        Anchors = [akTop, akRight]
        TabOrder = 0
        Text = '60'
      end
      object udAutoSaveInterval: TUpDown
        Left = 377
        Top = 22
        Width = 16
        Height = 24
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
        Width = 374
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = '&Prompt'
        TabOrder = 2
      end
    end
    object gbxMessages: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 132
      Width = 401
      Height = 109
      Align = alTop
      Caption = 'Messages'
      TabOrder = 3
      DesignSize = (
        401
        109)
      object lblMessageColour: TLabel
        Left = 11
        Top = 24
        Width = 37
        Height = 16
        Caption = '&Colour'
      end
      object cbxMessageColour: TColorBox
        Left = 112
        Top = 21
        Width = 286
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames, cbCustomColors]
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object gpnlFontStyles: TGridPanel
        Left = 11
        Top = 49
        Width = 379
        Height = 50
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 49.917616842314120000
          end
          item
            Value = 50.131926121372030000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = chkItalic
            Row = 0
          end
          item
            Column = 0
            Control = chkStrikeout
            Row = 1
          end
          item
            Column = 1
            Control = chkUnderline
            Row = 1
          end
          item
            Column = 0
            Control = chkBold
            Row = 0
          end>
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end
          item
            SizeStyle = ssAuto
          end>
        TabOrder = 1
        DesignSize = (
          379
          50)
        object chkItalic: TCheckBox
          Left = 235
          Top = 4
          Width = 97
          Height = 17
          Anchors = []
          Caption = '&Italic'
          TabOrder = 1
        end
        object chkStrikeout: TCheckBox
          Left = 46
          Top = 29
          Width = 97
          Height = 17
          Anchors = []
          Caption = '&Strikeout'
          TabOrder = 2
        end
        object chkUnderline: TCheckBox
          Left = 235
          Top = 29
          Width = 97
          Height = 17
          Anchors = []
          Caption = '&Underline'
          TabOrder = 3
        end
        object chkBold: TCheckBox
          Left = 46
          Top = 4
          Width = 97
          Height = 17
          Anchors = []
          Caption = '&Bold'
          TabOrder = 0
        end
      end
    end
    object rgrpCompileType: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 247
      Width = 401
      Height = 165
      Align = alClient
      Caption = 'AutoSave Options for Compilations'
      Items.Strings = (
        '&Disabled'
        'AutoSave files &Before compiling ALL Projects'
        'AutoSave files Before compile &each Project'
        'AutoSave files After compile e&ach Project'
        'AutoSave files &After compiling ALL Projects')
      TabOrder = 4
    end
  end
end
