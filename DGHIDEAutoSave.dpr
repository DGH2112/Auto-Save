(**
  
  This library module contains a definition for a DLL plug-in for RAD Studio.
  
  @Author  David Hoyle
  @Version 2.1
  @Date    13 Jul 2018

  @nocheck EmptyBEGINEND
  
**)
Library DGHIDEAutoSave;

{$R 'SplashScreenIcon.res' 'Source\SplashScreenIcon.RC'}
{$R 'DGHIDEAutoSaveITHVerInfo.res' 'DGHIDEAutoSaveITHVerInfo.RC'}
{$INCLUDE Source\CompilerDefinitions.inc}
{$INCLUDE Source\LibrarySuffixes.inc}

uses
  System.SysUtils,
  System.Classes,
  DGHIDEAutoSave.Wizard in 'Source\DGHIDEAutoSave.Wizard.pas',
  DGHIDEAutoSave.ToolsAPIFunctions in 'Source\DGHIDEAutoSave.ToolsAPIFunctions.pas',
  DGHIDEAutoSave.Settings in 'Source\DGHIDEAutoSave.Settings.pas',
  DGHIDEAutoSave.OptionsFrame in 'Source\DGHIDEAutoSave.OptionsFrame.pas' {fmIDEAutoSaveOptions: TFrame},
  DGHIDEAutoSave.OptionsForm in 'Source\DGHIDEAutoSave.OptionsForm.pas' {frmAutoSaveOptions},
  DGHIDEAutoSave.InitializationModule in 'Source\DGHIDEAutoSave.InitializationModule.pas',
  DGHIDEAutoSave.IDEOptionsInterface in 'Source\DGHIDEAutoSave.IDEOptionsInterface.pas',
  DGHIDEAutoSave.Functions in 'Source\DGHIDEAutoSave.Functions.pas',
  DGHIDEAutoSave.CompileNotifier in 'Source\DGHIDEAutoSave.CompileNotifier.pas',
  DGHIDEAutoSave.Types in 'Source\DGHIDEAutoSave.Types.pas',
  DGHIDEAutoSave.SplashScreen in 'Source\DGHIDEAutoSave.SplashScreen.pas',
  DGHIDEAutoSave.ResourceStrings in 'Source\DGHIDEAutoSave.ResourceStrings.pas',
  DGHIDEAutoSave.Interfaces in 'Source\DGHIDEAutoSave.Interfaces.pas',
  DGHIDEAutoSave.Constants in 'Source\DGHIDEAutoSave.Constants.pas',
  DGHIDEAutoSave.AboutBox in 'Source\DGHIDEAutoSave.AboutBox.pas';

{$R *.res}


Begin

End.
