(**

  This module contains a class for handling all the applications settings which need to be
  loaded and saved to the regsitry.

  @Author  David Hoyle
  @Version 1.0
  @Date    27 Mar 2016

**)
Unit DGHIDEAutoSaveSettings;

Interface

Type
  (** A class to handle the loading and saving of the applications settings. **)
  TDGHIDEAutoSaveSettings = Class
  Strict Private
    FEnabled: Boolean;
    FInterval: Integer;
    FPrompt: Boolean;
  Strict Protected
    Procedure LoadSettings;
    Procedure SaveSettings;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    (**
      This property determines whether the autosave functionality is enabled or disabled.
      @precon  None.
      @postcon Gets or sets whether the autosave functionality is enabled or disabled.
      @return  a Boolean
    **)
    Property Enabled: Boolean Read FEnabled Write FEnabled;
    (**
      This property defines the timer interval in second between autosaves.
      @precon  None.
      @postcon Gets or sets the interval between autosaves.
      @return  an Integer
    **)
    Property Interval: Integer Read FInterval Write FInterval;
    (**
      This property determines whether the user is prompted to save the file or the file
      is simply saved in the background.
      @precon  None.
      @postcon Gets or sets whether the user is prompted to save the modified files.
      @return  a Boolean
    **)
    Property Prompt: Boolean Read FPrompt Write FPrompt;
  End;

Var
  (** This is a globally visable variable to provide the application access to the
      settings - @note This class is creating in the initialisation section and freed
      in the finalisation section. **)
  AppOptions: TDGHIDEAutoSaveSettings;

Implementation

Uses
  Registry;

Const
  (** This constant represents the registry key the auto save settings are
      stored under. **)
  strRegistryKey = 'Software\Season''s Fall\Auto Save\';

{TDGHIDEAutoSaveSettings}

(**

  A constructor for the TDGHIDEAutoSaveSettings class.

  @precon  None.
  @postcon Initialises the settings and loads the settings from the registtry.

**)
Constructor TDGHIDEAutoSaveSettings.Create;

Begin
  FEnabled := False;
  FInterval := 300;
  FPrompt := True;
  LoadSettings;
End;

(**

  A destructor for the TDGHIDEAutoSaveSettings class.

  @precon  None.
  @postcon Saves the settings to the registry.

**)
Destructor TDGHIDEAutoSaveSettings.Destroy;

Begin
  SaveSettings;
  Inherited Destroy;
End;

(**

  This method loads the settings from the regsitry.

  @precon  None.
  @postcon The settings are loaded from the registry if they exists else the default
           settings are used.

**)
Procedure TDGHIDEAutoSaveSettings.LoadSettings;

Begin
  With TRegIniFile.Create() Do
    Try
      FInterval := ReadInteger(strRegistryKey + 'Setup', 'AutoSaveInt', 300);
      FPrompt := ReadBool(strRegistryKey + 'Setup', 'Prompt', True);
      FEnabled := ReadBool(strRegistryKey + 'Setup', 'Enabled', True);
    Finally
      Free;
    End;
End;

(**

  This method saves the settings to the registry.

  @precon  None.
  @postcon The settings are saved to the registry.

**)
Procedure TDGHIDEAutoSaveSettings.SaveSettings;

Begin
  With TRegIniFile.Create() Do
    Try
      WriteInteger(strRegistryKey + 'Setup', 'AutoSaveInt', FInterval);
      WriteBool(strRegistryKey + 'Setup', 'Prompt', FPrompt);
      WriteBool(strRegistryKey + 'Setup', 'Enabled', FEnabled);
    Finally
      Free;
    End;
End;

(** Creates an instance of the applications options class. **)
Initialization
  AppOptions := TDGHIDEAutoSaveSettings.Create;
(** Frees the memory used by the applications options class. **)
Finalization
  AppOptions.Free;
End.
