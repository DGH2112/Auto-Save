(**
  
  This module contains code in add and remove an about box plug-in entry from the IDE.

  @Author  David Hoyle
  @Version 1.0
  @Date    13 Jul 2018
  
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

Uses
  System.SysUtils,
  WinAPI.Windows,
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
  bmSplashScreen : HBITMAP;
  VersionInfo: TVersionInfo;

Begin
  FAboutBoxIndex := -1;
  BuildNumber(VersionInfo);
  bmSplashScreen := LoadBitmap(hInstance, strSplashScreenBitMap);
  If Supports(BorlandIDEServices, IOTAABoutBoxServices, ABS) Then
    Begin
      FAboutBoxIndex := ABS.AddPluginInfo(
        Format(strSplashScreenName, [
          VersionInfo.iMajor,
          VersionInfo.iMinor,
          Copy(strRevision, VersionInfo.iBugFix + 1, 1),
          Application.Title]),
        strAutoSaveWizardForRADStudioIDE,
        bmSplashScreen,
        {$IFDEF DEBUG} True {$ELSE} False {$ENDIF},
        Format(strSplashScreenBuild, [
          VersionInfo.iMajor,
          VersionInfo.iMinor,
          VersionInfo.iBugfix,
          VersionInfo.iBuild]),
        Format(strSKUBuild, [
          VersionInfo.iMajor,
          VersionInfo.iMinor,
          VersionInfo.iBugfix,
          VersionInfo.iBuild]));
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
