(**

  This module contains a class to represent the experts main wizard interface.

  @Version 2.1
  @Author  David Hoyle
  @Date    13 Jul 2018

**)
Unit DGHIDEAutoSave.Wizard;

Interface

Uses
  ToolsAPI,
  VCL.Extctrls,
  VCL.Menus,
  DGHIDEAutoSave.Interfaces,
  DGHIDEAutoSave.IDEOptionsInterface, DGHIDEAutoSave.ResourceStrings;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** This class represents a the open tools API wizard for the IDE auto save. **)
  TDGHAutoSaveWizard = Class(TNotifierObject, IUnknown, IOTANotifier, IOTAWizard, IOTAMenuWizard)
  Strict Private
    FTimer: TTimer;
    FCounter: Integer;
    {$IFDEF DXE00}
    FOpFrame: TDGHIDEAutoSaveOptionsInterface;
    {$ENDIF}
    FSettings : IDGHIDEAutoSaveSettings;
  Strict Protected
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Execute;
    Function  GetName: String;
    Function  GetIDString: String;
    Function  GetState: TWizardState;
    Procedure TimerEvent(Sender: TObject);
    Function  GetMenuText : String;
  End;

Implementation

Uses
  System.SysUtils,
  DGHIDEAutoSave.OptionsForm,
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
  {$IFDEF DXE00}
  FOpFrame := TDGHIDEAutoSaveOptionsInterface.Create(FSettings);
  (BorlandIDEServices As INTAEnvironmentOptionsServices).RegisterAddInOptions(FOpFrame);
  {$ENDIF}
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
  {$IFDEF DXE00}
  (BorlandIDEServices As INTAEnvironmentOptionsServices).UnregisterAddInOptions(FOpFrame);
  FOpFrame := Nil;
  {$ENDIF}
  TDGHIDEAutoSaveCompileNotifier.UninstallIDECompilationEventHandler;
  TDGHIDEAutoSaveAboutBox.RemoveAboutBox;
  FSettings := Nil;
  Inherited Destroy;
End;

(**

  This method is not called but must be implemented for the IOTAWIzard interface.

  @precon  None.
  @postcon None - Options dialogue is in the IDEs Options.

**)
Procedure TDGHAutoSaveWizard.Execute;

Begin
  {$IFDEF DXE00}
  (BorlandIDEServices As IOTAServices).GetEnvironmentOptions.EditOptions('', strIDEAutoSaveOptions);
  {$ELSE}
  TfrmAutoSaveOptions.Execute;
  {$ENDIF}
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

  This returns the menu text for the menu that appears under the help menu..

  @precon  None.
  @postcon Returns the menu text for the menu that appears under the help menu..

  @return  a String

**)
Function TDGHAutoSaveWizard.GetMenuText: String;

ResourceString
  strIDEAutoSaveOptions = 'DGH IDE Auto Save Options...';

Begin
  Result := strIDEAutoSaveOptions;
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

Begin
  FTimer.Enabled := False;
  Try
    Inc(FCounter);
    If FCounter >= FSettings.Interval Then
      Begin
        FCounter := 0;
        If FSettings.Enabled Then
          TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles(FSettings);
      End;
  Finally
    FTimer.Enabled := True;
  End;
End;

End.
