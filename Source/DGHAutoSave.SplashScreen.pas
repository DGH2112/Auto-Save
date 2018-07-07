(**
  
  This module contains code for installing a splash screen in the IDE for the plug-in.

  @Author  David Hoyle
  @Version 1.0
  @Date    07 Jul 2018
  
**)
Unit DGHAutoSave.SplashScreen;

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
  WinApi.Windows,
  VCL.Forms,
  DGHIDEAutoSave.Functions,
  DGHAutoSave.ResourceStrings,
  DGHAutoSave.Constants;

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
  bmSplashScreen : HBITMAP;
  
Begin
  BuildNumber(VersionInfo);
  bmSplashScreen := LoadBitmap(hInstance, strSplashScreenBitMap);
  If Supports(SplashScreenServices, IOTASplashScreenServices, SSS) Then
    Begin
      SSS.AddPluginBitmap(
        Format(strSplashScreenName, [
          VersionInfo.iMajor,
          VersionInfo.iMinor,
          Copy(strRevision, VersionInfo.iBugFix + 1, 1),
          Application.Title]),
        bmSplashScreen,
        False,
        Format(strSplashScreenBuild, [
          VersionInfo.iMajor,
          VersionInfo.iMinor,
          VersionInfo.iBugfix,
          VersionInfo.iBuild])
        );
    End;
End;

End.
