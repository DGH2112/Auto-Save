(**

  This module contains a frame which represent the auto save settings for editing the
  behaviour of the applications.

  @Version 1.1
  @Author  David Hoyle
  @Date    09 Jul 2018

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
    Procedure chkEnabledClick(Sender: TObject);
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
  rgrpCompileType.ItemIndex := Integer(Settings.CompileType);
  chkEnabledClick(Nil);
End;

End.
