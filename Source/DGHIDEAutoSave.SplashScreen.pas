(**
  
  This module contains code for installing a splash screen in the IDE for the plug-in.

  @Author  David Hoyle
  @Version 1.119
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
Unit DGHIDEAutoSave.SplashScreen;

Interface

Uses
  ToolsAPI;

{$INCLUDE CompilerDefinitions.inc}

Type
  (** A record to encapsulate the splash screen methods. **)
  TDGHAutoSaveSplashScreen = Record
  Strict Private
  Public
    Class Procedure AddSplashScreen; Static;
  End;

Implementation

Uses
  System.SysUtils,
  {$IFDEF RS110}
  Graphics,
  {$ELSE}
  WinApi.Windows,
  {$ENDIF RS110}
  VCL.Forms,
  DGHIDEAutoSave.Functions,
  DGHIDEAutoSave.ResourceStrings,
  DGHIDEAutoSave.Constants;

(**

  This method to install a splash screen in to the RAD Studio IDE for this plug-in.

  @precon  None.
  @postcon The splash screen entry is added to the IDEs splash screen.

**)
Class Procedure TDGHAutoSaveSplashScreen.AddSplashScreen;

Const
  strSplashScreenBitMap = 'SplashScreenBitMap24x24';

Var
  SSS : IOTASplashScreenServices;
  VersionInfo : TVersionInfo;
  {$IFDEF RS110}
  SplashScreenBitMap : TBitMap;
  {$ELSE}
  bmSplashScreen : HBITMAP;
  {$ENDIF RS110}
  
Begin
  BuildNumber(VersionInfo);
  If Supports(SplashScreenServices, IOTASplashScreenServices, SSS) Then
    Begin
      {$IFDEF RS110}
      SplashScreenBitMap := TBitMap.Create;
      Try
        SplashScreenBitMap.LoadFromResourceName(hInstance, strSplashScreenBitMap);
        SSS.AddPluginBitmap(
          Format(strSplashScreenName, [VersionInfo.iMajor, VersionInfo.iMinor, Copy(strRevision, VersionInfo.iBugFix + 1, 1), Application.Title]),
          [SplashScreenBitMap],
          {$IFDEF DEBUG} True {$ELSE} False {$ENDIF},
          Format(strSplashScreenBuild, [VersionInfo.iMajor, VersionInfo.iMinor, VersionInfo.iBugfix, VersionInfo.iBuild])
        );
      Finally
        SplashScreenBitMap.Free;
      End;
      {$ELSE}
      bmSplashScreen := LoadBitmap(hInstance, strSplashScreenBitMap);
      SSS.AddPluginBitmap(
        Format(strSplashScreenName, [VersionInfo.iMajor, VersionInfo.iMinor, Copy(strRevision, VersionInfo.iBugFix + 1, 1), Application.Title]),
        bmSplashScreen,
        {$IFDEF DEBUG} True {$ELSE} False {$ENDIF},
        Format(strSplashScreenBuild, [VersionInfo.iMajor, VersionInfo.iMinor, VersionInfo.iBugfix, VersionInfo.iBuild])
      );
      {$ENDIF}
    End;
End;

End.
