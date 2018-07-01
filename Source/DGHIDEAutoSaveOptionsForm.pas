(**

  This module provide an Option dialogue for the auto save options (@note The interface
  controls are hosted in frame for reuse in the IDEs options pages).

  @Date    01 Jul 2018
  @Version 1.1
  @Author  David Hoyle

**)
Unit DGHIDEAutoSaveOptionsForm;

Interface

Uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ComCtrls,
  DGHIDEAutoSaveOptionsFrame,
  ExtCtrls;

Type
  (** This class represent an options dialogue for the autosave feature. **)
  TfrmAutoSaveOptions = Class(TForm)
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    pnlFrame: TPanel;
    procedure FormCreate(Sender: TObject);
  Private
    {Private declarations}
    FIDEAutoSaveFrame: TfmIDEAutoSaveOptions;
  Public
    {Public declarations}
    Class Procedure Execute;
  End;

Implementation

Uses
  DGHIDEAutoSaveSettings;

{$R *.DFM}

{TfrmAutoSaveOptions}

(**

  This class method creates and displays the options form.

  @precon  None.
  @postcon Displays the AuotSave optins dialogue for settings the auto save attributes.

**)
Class Procedure TfrmAutoSaveOptions.Execute;

Var
  iInterval : Integer;
  boolEnabled, boolPrompt : Boolean;
  F: TfrmAutoSaveOptions;

Begin
  F := TfrmAutoSaveOptions.Create(Nil);
    Try
      iInterval := AppOptions.Interval;
      boolEnabled := AppOptions.Enabled;
      boolPrompt := AppOptions.Prompt;
      F.FIDEAutoSaveFrame.InitialiseFrame(iInterval, boolPrompt, boolEnabled);
      If F.ShowModal = mrOK Then
        Begin
          F.FIDEAutoSaveFrame.FinaliseFrame(iInterval, boolPrompt, boolEnabled);
          AppOptions.Interval := iInterval;
          AppOptions.Enabled := boolEnabled;
          AppOptions.Prompt := boolPrompt;
        End;
    Finally
      F.Free;
    End;
End;

(**

  This is an OnFormCreate Event Handler for the TfrmAutoSaveOptions class.

  @precon  None.
  @postcon The frame which hosts of applications settings controls is created and placed
           inside the panel on the form.

  @param   Sender as a TObject

**)
Procedure TfrmAutoSaveOptions.FormCreate(Sender: TObject);

Begin
  FIDEAutoSaveFrame := TfmIDEAutoSaveOptions.Create(Self);
  FIDEAutoSaveFrame.Parent := pnlFrame;
  FIDEAutoSaveFrame.Align := alClient;
End;

End.
