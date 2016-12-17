(**

  This module contains a frame which represent the auto save settings for editing the
  behaviour of the applications.

  @Version 1.0
  @Author  David Hoyle
  @Date    09 Apr 2016

**)
Unit DGHIDEAutoSaveOptionsFrame;

Interface

Uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  Buttons;

Type
  (** A frame to represent the settings interface. **)
  TfmIDEAutoSaveOptions = Class(TFrame)
    gbxAutoSaveOptions: TGroupBox;
    lblAutoSaveInterval: TLabel;
    edtAutosaveInterval: TEdit;
    udAutoSaveInterval: TUpDown;
    cbxPrompt: TCheckBox;
    chkEnabled: TCheckBox;
    Procedure chkEnabledClick(Sender: TObject);
  Private
    {Private declarations}
  Public
    {Public declarations}
    Procedure InitialiseFrame(iInterval: Integer; boolPrompt, boolEnabled: Boolean);
    Procedure FinaliseFrame(Var iInterval: Integer; Var boolPrompt, boolEnabled: Boolean);
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

  This method retreieves the setings from the framee interface and assigns them to the
  given settings. This should be called when closing the hosting for / options page.

  @precon  None.
  @postcon Initialises the interface with the given settings.

  @param   iInterval   as an Integer as a reference
  @param   boolPrompt  as a Boolean as a reference
  @param   boolEnabled as a Boolean as a reference

**)
Procedure TfmIDEAutoSaveOptions.FinaliseFrame(Var iInterval: Integer;
  Var boolPrompt, boolEnabled: Boolean);

Begin
  iInterval := udAutoSaveInterval.Position;
  boolPrompt := cbxPrompt.Checked;
  boolEnabled := chkEnabled.Checked;
End;

(**

  This method initialises the interface with the given settings. This should be called
  before the for / option page is displayed to show these options.

  @precon  None.
  @postcon Initialises the interface with the given settings.

  @param   iInterval   as an Integer
  @param   boolPrompt  as a Boolean
  @param   boolEnabled as a Boolean

**)
Procedure TfmIDEAutoSaveOptions.InitialiseFrame(iInterval: Integer;
  boolPrompt, boolEnabled: Boolean);

Begin
  udAutoSaveInterval.Position := iInterval;
  cbxPrompt.Checked := boolPrompt;
  chkEnabled.Checked := boolEnabled;
  chkEnabledClick(Nil);
End;

End.
