(**

  This module contains a frame which represent the auto save settings for editing the
  behaviour of the applications.

  @Version 1.1
  @Author  David Hoyle
  @Date    25 Aug 2019

  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2019  David Hoyle (https://github.com/DGH2112/Auto-Save/)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License

**)
Unit DGHIDEAutoSave.OptionsFrame;

Interface

Uses
  WinAPI.Windows,
  WinAPI.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.ComCtrls,
  VCL.Buttons,
  VCL.ExtCtrls,
  DGHIDEAutoSave.Types,
  DGHIDEAutoSave.Interfaces;

Type
  (** A frame to represent the settings interface. **)
  TfmIDEAutoSaveOptions = Class(TFrame)
    gbxAutoSaveOptions: TGroupBox;
    lblAutoSaveInterval: TLabel;
    edtAutosaveInterval: TEdit;
    udAutoSaveInterval: TUpDown;
    cbxPrompt: TCheckBox;
    chkEnabled: TCheckBox;
    rgrpCompileType: TRadioGroup;
    chkMessages: TCheckBox;
    gbxMessages: TGroupBox;
    lblMessageColour: TLabel;
    cbxMessageColour: TColorBox;
    chkBold: TCheckBox;
    chkItalic: TCheckBox;
    chkUnderline: TCheckBox;
    chkStrikeout: TCheckBox;
    gpnlFontStyles: TGridPanel;
    pnlFudgePanel: TPanel;
    Procedure chkEnabledClick(Sender: TObject);
    procedure chkMessagesClick(Sender: TObject);
  Private
    {Private declarations}
  Public
    {Public declarations}
    Procedure InitialiseFrame(Const Settings : IDGHIDEAutoSaveSettings);
    Procedure FinaliseFrame(Const Settings : IDGHIDEAutoSaveSettings);
  End;

Implementation

{$R *.dfm}

(**

  This is an on click event handler for the enabled checkbox.

  @precon  None.
  @postcon Enables or disables the auto save controls depending upon the status of the
           enabled checkbox.

  @param   Sender as a TObject

**)
Procedure TfmIDEAutoSaveOptions.chkEnabledClick(Sender: TObject);

Begin
  lblAutoSaveInterval.Enabled := chkEnabled.Checked;
  edtAutosaveInterval.Enabled := chkEnabled.Checked;
  udAutoSaveInterval.Enabled := chkEnabled.Checked;
  cbxPrompt.Enabled := chkEnabled.Checked;
End;

(**

  This is an on click event handler for the Messages Checkbox control.

  @precon  None.
  @postcon Enabled or disables the message colour and styles controls.

  @param   Sender as a TObject

**)
Procedure TfmIDEAutoSaveOptions.chkMessagesClick(Sender: TObject);

Begin
  gbxMessages.Enabled := chkMessages.Checked;
  lblMessageColour.Enabled := chkMessages.Checked;
  cbxMessageColour.Enabled := chkMessages.Checked;
  chkBold.Enabled := chkMessages.Checked;
  chkItalic.Enabled := chkMessages.Checked;
  chkUnderline.Enabled := chkMessages.Checked;
  chkStrikeout.Enabled := chkMessages.Checked;
End;

(**

  This method retreieves the setings from the framee interface and assigns them to the given settings. 
  This should be called when closing the hosting for / options page.

  @precon  None.
  @postcon Initialises the interface with the given settings.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant

**)
Procedure TfmIDEAutoSaveOptions.FinaliseFrame(Const Settings : IDGHIDEAutoSaveSettings);

Begin
  Settings.Interval := udAutoSaveInterval.Position;
  Settings.Prompt := cbxPrompt.Checked;
  Settings.Enabled := chkEnabled.Checked;
  Settings.CompileType := TDGHIDEAutoSaveCompileType(rgrpCompileType.ItemIndex);
  Settings.Messages := chkMessages.Checked;
  Settings.MessageColour := cbxMessageColour.Selected;
  Settings.MessageStyle := [];
  If chkBold.Checked Then
    Settings.MessageStyle := Settings.MessageStyle + [fsBold];
  If chkItalic.Checked Then
    Settings.MessageStyle := Settings.MessageStyle + [fsItalic];
  If chkUnderline.Checked Then
    Settings.MessageStyle := Settings.MessageStyle + [fsUnderline];
  If chkStrikeout.Checked Then
    Settings.MessageStyle := Settings.MessageStyle + [fsStrikeout];
End;

(**

  This method initialises the interface with the given settings. This should be called before the for / 
  option page is displayed to show these options.

  @precon  None.
  @postcon Initialises the interface with the given settings.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant

**)
Procedure TfmIDEAutoSaveOptions.InitialiseFrame(Const Settings : IDGHIDEAutoSaveSettings);

Begin
  udAutoSaveInterval.Position := Settings.Interval;
  cbxPrompt.Checked := Settings.Prompt;
  chkEnabled.Checked := Settings.Enabled;
  chkEnabledClick(Nil);
  rgrpCompileType.ItemIndex := Integer(Settings.CompileType);
  chkMessages.Checked := Settings.Messages;
  cbxMessageColour.Selected := Settings.MessageColour;
  chkBold.Checked := fsBold In Settings.MessageStyle;
  chkItalic.Checked := fsItalic In Settings.MessageStyle;
  chkUnderline.Checked := fsUnderline In Settings.MessageStyle;
  chkStrikeout.Checked := fsStrikeOut In Settings.MessageStyle;
  chkMessagesClick(Nil);
End;

End.
