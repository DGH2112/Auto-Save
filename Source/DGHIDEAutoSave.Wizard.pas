(**

  This module contains a class to represent the experts main wizard interface.

  @Version 2.101
  @Author  David Hoyle
  @Date    03 Jun 2020

  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2020  David Hoyle (https://github.com/DGH2112/Auto-Save/)

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
Unit DGHIDEAutoSave.Wizard;

Interface

Uses
  ToolsAPI,
  VCL.Extctrls,
  VCL.Menus,
  DGHIDEAutoSave.Interfaces,
  DGHIDEAutoSave.IDEOptionsInterface,
  DGHIDEAutoSave.ResourceStrings;

Type
  (** This class represents a the open tools API wizard for the IDE auto save. **)
  TDGHAutoSaveWizard = Class(TNotifierObject, IUnknown, IOTANotifier, IOTAWizard)
  Strict Private
    FTimer       : TTimer;
    FCounter     : Integer;
    FOpFrame     : TDGHIDEAutoSaveOptionsInterface;
    FParentFrame : TDGHIDEAutoSaveOptionsInterface;
    FSettings    : IDGHIDEAutoSaveSettings;
  Strict Protected
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Execute;
    Function  GetName: String;
    Function  GetIDString: String;
    Function  GetState: TWizardState;
    Procedure TimerEvent(Sender: TObject);
  End;

Implementation

Uses
  {$IFDEF DEBUG}
  CodeSiteLogging,
  {$ENDIF}
  System.SysUtils,
  VCL.Forms,
  Winapi.Windows,
  DGHIDEAutoSave.Settings,
  DGHIDEAutoSave.SplashScreen,
  DGHIDEAutoSave.AboutBox,
  DGHIDEAutoSave.CompileNotifier,
  DGHIDEAutoSave.ToolsAPIFunctions;

(**

  This is the constructor method for the TDGHAutoSavewizard class.

  @precon  None.
  @postcon Creates an internal timer for the autosave functionality and creates the
           options frame interface to be displayed in the IDEs Options dialogue.

**)
Constructor TDGHAutoSaveWizard.Create;

Const
  iOneSecond = 1000;

Begin
  Inherited Create;
  FSettings := TDGHIDEAutoSaveSettings.Create;
  TDGHAutoSaveSplashScreen.AddSplashScreen;
  TDGHIDEAutoSaveAboutBox.InstallAboutBox;
  TDGHIDEAutoSaveCompileNotifier.InstallIDECompilationEventHandler(FSettings);
  FCounter := 0;
  FTimer := TTimer.Create(Nil);
  FTimer.Interval := iOneSecond;
  FTimer.OnTimer := TimerEvent;
  FTimer.Enabled := True;
  FParentFrame := TDGHIDEAutoSaveOptionsInterface.Create(FSettings, ftParent);
  (BorlandIDEServices As INTAEnvironmentOptionsServices).RegisterAddInOptions(FParentFrame);
  FOpFrame := TDGHIDEAutoSaveOptionsInterface.Create(FSettings, ftOptions);
  (BorlandIDEServices As INTAEnvironmentOptionsServices).RegisterAddInOptions(FOpFrame);
End;

(**

  This is the destructor method for the TDGHAutoSaveWizard class.

  @precon  None.
  @postcon Frees the timer used by the applications and also frees the frame interface
           used by the IDEs options dialogue.

**)
Destructor TDGHAutoSaveWizard.Destroy;

Begin
  FTimer.Free;
  (BorlandIDEServices As INTAEnvironmentOptionsServices).UnregisterAddInOptions(FOpFrame);
  (BorlandIDEServices As INTAEnvironmentOptionsServices).UnregisterAddInOptions(FParentFrame);
  FOpFrame := Nil;
  TDGHIDEAutoSaveCompileNotifier.UninstallIDECompilationEventHandler;
  TDGHIDEAutoSaveAboutBox.RemoveAboutBox;
  FSettings := Nil;
  Inherited Destroy;
End;

(**

  This method is not called but must be implemented for the IOTAWIzard interface.

  @precon  None.
  @postcon None - Options dialogue is in the IDEs Options.

  @nocheck EmptyMethod

**)
Procedure TDGHAutoSaveWizard.Execute;

Begin
  // Does nothing
End;

(**

  This is a getter method for the IDString property.


  @precon  None.
  @postcon Returns a string ID for the wizard.

  @return  a String

**)
Function TDGHAutoSaveWizard.GetIDString: String;

ResourceString
  strSeasonFallDGHAutoSave = 'Season''s Fall.DGH IDE Auto Save';

Begin
  Result := strSeasonFallDGHAutoSave;
End;

(**

  This is a getter method for the Name property.

  @precon  None.
  @postcon Returns a name for the wizard.

  @return  a String

**)
Function TDGHAutoSaveWizard.GetName: String;

ResourceString
  strDGHAutoSave = 'DGH IDE Auto Save.';

Begin
  Result := strDGHAutoSave;
End;

(**

  This is a getter method for the State property.

  @precon  None.
  @postcon Returns a state for the wizard.

  @return  a TWizardState

**)
Function TDGHAutoSaveWizard.GetState: TWizardState;

Begin
  Result := [wsEnabled];
End;


(**

  This method is the timer event handler. If saves all the files if the
  appropriate time has elapsed.

  @precon  Sender is the control that initiated the event.
  @postcon If the time interval has elasped and the auto save functionality is enabled
           the modified files are saved.

  @param   Sender as a TObject

**)
Procedure TDGHAutoSaveWizard.TimerEvent(Sender: TObject);

{$IFDEF DEBUG}
Const
  strIDEInModalState = 'IDE is in a modal state (%d)!';
{$ENDIF DEBUG}

Begin
  FTimer.Enabled := False;
  Try
    Inc(FCounter);
    If FCounter >= FSettings.Interval Then
      Begin
        If FSettings.Enabled Then
          If IsWindowEnabled(Application.MainForm.Handle) Then
            Begin
              FCounter := 0;
              TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles(FSettings);
            End
          {$IFDEF DEBUG}
          Else
            CodeSite.SendFmtMsg(strIDEInModalState, [Application.ModalLevel])
          {$ENDIF DEBUG}
          ;
      End;
  Finally
    FTimer.Enabled := True;
  End;
End;

End.
