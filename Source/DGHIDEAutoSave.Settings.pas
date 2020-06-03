(**

  This module contains a class for handling all the applications settings which need to be
  loaded and saved to the regsitry.

  @Author  David Hoyle
  @Version 1.101
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
Unit DGHIDEAutoSave.Settings;

Interface

Uses
  Graphics,
  DGHIDEAutoSave.Types,
  DGHIDEAutoSave.Interfaces;

Type
  (** A class to handle the loading and saving of the applications settings. **)
  TDGHIDEAutoSaveSettings = Class(TInterfacedObject, IDGHIDEAutoSaveSettings)
  Strict Private
    FEnabled       : Boolean;
    FInterval      : Integer;
    FPrompt        : Boolean;
    FCompileType   : TDGHIDEAutoSaveCompileType;
    FMessages      : Boolean;
    FMessageColour : TColor;
    FMessageStyles : TFontStyles;
  Strict Protected    
    // IDGHDEAutoSaveSettings
    Function  GetEnabled: Boolean;
    Procedure SetEnabled(Const boolValue: Boolean);
    Function  GetInterval: Integer;
    Procedure SetInterval(Const iValue: Integer);
    Function  GetPrompt: Boolean;
    Procedure SetPrompt(Const boolValue: Boolean);
    Function  GetCompileType: TDGHIDEAutoSaveCompileType;
    Procedure SetCompileType(Const eCompileType: TDGHIDEAutoSaveCompileType);
    Function  GetMessages: Boolean;
    Procedure SetMessages(Const boolValue: Boolean);
    Function  GetMessageColour : TColor;
    Procedure SetMessageColour(Const iValue : TColor);
    Function  GetMessageStyles : TFontStyles;
    Procedure SetMessageStyles(Const setValue : TFontStyles);
    // General Methods
    Procedure LoadSettings;
    Procedure SaveSettings;
  Public
    Constructor Create;
    Destructor Destroy; Override;
  End;

Implementation

Uses
  Registry;

Const
  (** This constant represents the registry key the auto save settings are
      stored under. **)
  strRegistryKey = 'Software\Season''s Fall\Auto Save\';
  (** A default valkue for the number of seconds before saving files. **)
  iDefaultInterval = 300;
  (** An INI Section name for thr settings. **)
  strSetupINISection = 'Setup';
  (** An INI Key Name for the AutoSave Interval. **)
  strAutoSaveIntKey = 'AutoSaveInt';
  (** An INI Key Name for the Prompt. **)
  strPromptKey = 'Prompt';
  (** An INI Key Name for the Enabled. **)
  strEnabledKey = 'Enabled';
  (** An INI Key Name for the Compile Type. **)
  strCompileTypeKey = 'CompileType';
  (** An INI Key Name for the Messages. **)
  strMessagesKey = 'Messages';
  (** An INI Key Name for the Message Colour. **)
  strMessageColourKey = 'MessageColour';
  (** An INI Key Name for the Message Font Style. **)
  strMessageStylesKey = 'MessageStyles';

(**

  A constructor for the TDGHIDEAutoSaveSettings class.

  @precon  None.
  @postcon Initialises the settings and loads the settings from the registtry.

**)
Constructor TDGHIDEAutoSaveSettings.Create;

Begin
  FEnabled := False;
  FInterval := iDefaultInterval;
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

  This is a getter method for the CompileType property.

  @precon  None.
  @postcon Returns the current compile type setting.

  @return  a TDGHIDEAutoSaveCompileType

**)
Function TDGHIDEAutoSaveSettings.GetCompileType: TDGHIDEAutoSaveCompileType;

Begin
  Result := FCompileType;
End;

(**

  This is a getter method for the Enabled property.

  @precon  None.
  @postcon Returns whether autosaver is enabled.

  @return  a Boolean

**)
Function TDGHIDEAutoSaveSettings.GetEnabled: Boolean;

Begin
  Result := FEnabled;
End;

(**

  This is a getter method for the Interval property.

  @precon  None.
  @postcon Returns the autosave interval in seconds.

  @return  an Integer

**)
Function TDGHIDEAutoSaveSettings.GetInterval: Integer;

Begin
  Result := FInterval;
End;

(**

  This is a getter method for the MessageColour property.

  @precon  None.
  @postcon Returns the colour of the custom messages.

  @return  a TColor

**)
Function TDGHIDEAutoSaveSettings.GetMessageColour: TColor;

Begin
  Result := FMessageColour;
End;

(**

  This is a getter method for the Messages property.

  @precon  None.
  @postcon Returns whether a message should be displayed for each file saved.

  @return  a Boolean

**)
Function TDGHIDEAutoSaveSettings.GetMessages: Boolean;

Begin
  Result := FMessages;
End;

(**

  This is a getter method for the NessageStyles property.

  @precon  None.
  @postcon Returns the font style of the custom messages.

  @return  a TFontStyles

**)
Function TDGHIDEAutoSaveSettings.GetMessageStyles: TFontStyles;

Begin
  Result := FMessageStyles;
End;

(**

  This is a getter method for the Prompt property.

  @precon  None.
  @postcon Returns whether the user should be prompted before saving files.

  @return  a Boolean

**)
Function TDGHIDEAutoSaveSettings.GetPrompt: Boolean;

Begin
  Result := FPrompt;
End;

(**

  This method loads the settings from the regsitry.

  @precon  None.
  @postcon The settings are loaded from the registry if they exists else the default
           settings are used.

**)
Procedure TDGHIDEAutoSaveSettings.LoadSettings;

Const
  strDefaultMessageColour = 'clBlack';

Var
  riniFile: TRegIniFile;

Begin
  riniFile := TRegIniFile.Create();
  Try
    FInterval := riniFile.ReadInteger(strRegistryKey + strSetupINISection, strAutoSaveIntKey,
      iDefaultInterval);
    FPrompt := riniFile.ReadBool(strRegistryKey + strSetupINISection, strPromptKey, True);
    FEnabled := riniFile.ReadBool(strRegistryKey + strSetupINISection, strEnabledKey, True);
    FCompileType := TDGHIDEAutoSaveCompileType(riniFile.ReadInteger(strRegistryKey + strSetupINISection,
      strCompileTypeKey, Byte(asctNone)));
    FMessages := riniFile.ReadBool(strRegistryKey + strSetupINISection, strMessagesKey, True);
    FMessageColour := StringToColor(riniFile.ReadString(strRegistryKey + strSetupINISection,
      strMessageColourKey, strDefaultMessageColour));
    FMessageStyles := TFontStyles(Byte(riniFile.ReadInteger(strRegistryKey + strSetupINISection,
      strMessageStylesKey, 0)));
  Finally
    riniFile.Free;
  End;
End;

(**

  This method saves the settings to the registry.

  @precon  None.
  @postcon The settings are saved to the registry.

**)
Procedure TDGHIDEAutoSaveSettings.SaveSettings;

Var
  riniFile: TRegIniFile;

Begin
  riniFile := TRegIniFile.Create();
  Try
    riniFile.WriteInteger(strRegistryKey + strSetupINISection, strAutoSaveIntKey, FInterval);
    riniFile.WriteBool(strRegistryKey + strSetupINISection, strPromptKey, FPrompt);
    riniFile.WriteBool(strRegistryKey + strSetupINISection, strEnabledKey, FEnabled);
    riniFile.WriteInteger(strRegistryKey + strSetupINISection, strCompileTypeKey, Byte(FCompileType));
    riniFile.WriteBool(strRegistryKey + strSetupINISection, strMessagesKey, FMessages);
    riniFile.WriteString(strRegistryKey + strSetupINISection, strMessageColourKey,
      ColorToString(FMessageColour));
    riniFile.ReadInteger(strRegistryKey + strSetupINISection, strMessageStylesKey, Byte(FMessageStyles));
  Finally
    riniFile.Free;
  End;
End;

(**

  This is a setter method for the CompileType property.

  @precon  None.
  @postcon Updates the compile type setting.

  @param   eCompileType as a TDGHIDEAutoSaveCompileType as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetCompileType(Const eCompileType: TDGHIDEAutoSaveCompileType);

Begin
  FCompileType := eCompileType;
End;

(**

  This is a setter method for the Enabled property.

  @precon  None.
  @postcon Updates whether autosaev is enabled.

  @param   boolValue as a Boolean as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetEnabled(Const boolValue: Boolean);

Begin
  FEnabled := boolValue;
End;

(**

  This is a setter method for the Interval property.

  @precon  None.
  @postcon Updates the autosaev interval.

  @param   iValue as an Integer as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetInterval(Const iValue: Integer);

Begin
  FInterval := iValue;
End;

(**

  This is a setter method for the MessageColour property.

  @precon  None.
  @postcon Sets the custom message colour.

  @param   iValue as a TColor as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetMessageColour(Const iValue: TColor);

Begin
  FMessageColour := iValue;
End;

(**

  This is a setter method for the Messages property.

  @precon  None.
  @postcon Settings whether messages are output for each file saved.

  @param   boolValue as a Boolean as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetMessages(Const boolValue: Boolean);

Begin
  FMessages := boolValue;
End;

(**

  This is a setter method for the MessageStyles property.

  @precon  None.
  @postcon Sets the custom message font styles.

  @param   setValue as a TFontStyles as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetMessageStyles(Const setValue: TFontStyles);

Begin
  FMessageStyles := setValue;
End;

(**

  This is a setter method for the Prompt property.

  @precon  None.
  @postcon Updates whether the user should be prompted to save files.

  @param   boolValue as a Boolean as a constant

**)
Procedure TDGHIDEAutoSaveSettings.SetPrompt(Const boolValue: Boolean);

Begin
  FPrompt := boolValue;
End;

End.
