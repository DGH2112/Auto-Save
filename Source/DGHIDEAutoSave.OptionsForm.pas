(**

  This module provide an Option dialogue for the auto save options (@note The interface
  controls are hosted in frame for reuse in the IDEs options pages).

  @Date    25 Aug 2019
  @Version 1.1
  @Author  David Hoyle

  @license
  
    Auto Save is a RAD Studio plug-in to automatically save your code
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
Unit DGHIDEAutoSave.OptionsForm;

Interface

Uses
  WinAPI.Windows,
  WinAPI.Messages,
  System.SysUtils,
  System.Classes,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.Buttons,
  VCL.ComCtrls,
  VCL.ExtCtrls,
  DGHIDEAutoSave.Interfaces,
  DGHIDEAutoSave.OptionsFrame;

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
    Class Procedure Execute(Const Settings : IDGHIDEAutoSaveSettings);
  End;

Implementation

Uses
  DGHIDEAutoSave.Types;

{$R *.DFM}

(**

  This class method creates and displays the options form.

  @precon  None.
  @postcon Displays the AuotSave optins dialogue for settings the auto save attributes.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant

**)
Class Procedure TfrmAutoSaveOptions.Execute(Const Settings : IDGHIDEAutoSaveSettings);

Var
  F: TfrmAutoSaveOptions;

Begin
  F := TfrmAutoSaveOptions.Create(Nil);
    Try
      F.FIDEAutoSaveFrame.InitialiseFrame(Settings);
      If F.ShowModal = mrOK Then
        F.FIDEAutoSaveFrame.FinaliseFrame(Settings);
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
