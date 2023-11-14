(**
  
  This module contains code in add and remove an about box plug-in entry from the IDE.

  @Author  David Hoyle
  @Version 1.147
  @Date    30 Dec 2021
  
  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2023  David Hoyle (https://github.com/DGH2112/Auto-Save/)

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
Unit DGHIDEAutoSave.AboutBox;

Interface

Uses
  ToolsAPI;

Type
  (** A record to encapsulate the about box functionality. **)
  TDGHIDEAutoSaveAboutBox = Record
  Strict Private
    Class Var
      (** A private class variable to hold the about box index after it is added and is used to remove
          it. **)
      FAboutBoxIndex : Integer;
  Public
    Class Procedure InstallAboutBox; Static;
    Class Procedure RemoveAboutBox; Static;
  End;

Implementation

{$INCLUDE CompilerDefinitions.inc}

Uses
  System.SysUtils,
  {$IFDEF RS110}
  VCL.Graphics,
  {$ELSE}
  WinAPI.Windows,
  {$ENDIF RS110}
  VCL.Forms,
  DGHIDEAutoSave.Functions,
  DGHIDEAutoSave.ResourceStrings,
  DGHIDEAutoSave.Constants;

(**

  This method adds an about box entry to the RAD Studio IDE.

  @precon  None.
  @postcon An entry is added to the RAD Studio IDE.

**)
Class Procedure TDGHIDEAutoSaveAboutBox.InstallAboutBox;

ResourceString
  strAutoSaveWizardForRADStudioIDE = 'An auto save wizard for the RAD Studio IDE.';
  strSKUBuild = 'SKU Build %d.%d.%d.%d';

Const
  strSplashScreenBitMap = 'SplashScreenBitMap48x48';

Var
  ABS : IOTAAboutBoxServices;
  {$IFDEF RS110}
  AboutBoxBitMap : TBitMap;
  {$ELSE}
  bmSplashScreen : HBITMAP;
  {$ENDIF}
  VerInfo: TVersionInfo;

Begin
  FAboutBoxIndex := -1;
  BuildNumber(VerInfo);
  If Supports(BorlandIDEServices, IOTAABoutBoxServices, ABS) Then
    Begin
      {$IFDEF RS110}
      AboutBoxBitMap := TBitMap.Create;
      Try
        AboutBoxBitMap.LoadFromResourceName(hInstance, strSplashScreenBitMap);
        FAboutBoxIndex := ABS.AddPluginInfo(
          Format(strSplashScreenName, [VerInfo.iMajor, VerInfo.iMinor, Copy(strRevision, VerInfo.iBugFix + 1, 1), Application.Title]),
          strAutoSaveWizardForRADStudioIDE,
          [AboutBoxBitMap],
          {$IFDEF DEBUG} True {$ELSE} False {$ENDIF},
          Format(strSplashScreenBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugfix,VerInfo.iBuild]),
          Format(strSKUBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugfix, VerInfo.iBuild])
        );
      Finally
        AboutBoxBitMap.Free;
      End;
      {$ELSE}
      bmSplashScreen := LoadBitmap(hInstance, strSplashScreenBitMap);
      FAboutBoxIndex := ABS.AddPluginInfo(
        Format(strSplashScreenName, [VerInfo.iMajor, VerInfo.iMinor, Copy(strRevision, VerInfo.iBugFix + 1, 1), Application.Title]),
        strAutoSaveWizardForRADStudioIDE,
        bmSplashScreen,
        {$IFDEF DEBUG} True {$ELSE} False {$ENDIF},
        Format(strSplashScreenBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugfix,VerInfo.iBuild]),
        Format(strSKUBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugfix, VerInfo.iBuild])
      );
      {$ENDIF RS110}
    End;
End;

(**

  This method removes the about box entry from the RAD Studio IDE.

  @precon  None.
  @postcon The entry is removed from the RAD Studio IDE.

**)
Class Procedure TDGHIDEAutoSaveAboutBox.RemoveAboutBox;

Var
  ABS : IOTAAboutBoxServices;
  
Begin
  If Supports(BorlandIDEServices, IOTAABoutBoxServices, ABS) Then
    If FAboutBoxIndex > -1 Then
      ABS.RemovePluginInfo(FAboutBoxIndex);
End;

End.
