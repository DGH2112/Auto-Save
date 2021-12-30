(**
  
  This library module contains a definition for a DLL plug-in for RAD Studio.

  @Author  David Hoyle
  @Version 2.103
  @Date    30 Dec 2021

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
  DGHIDEAutoSave.InitializationModule in 'Source\DGHIDEAutoSave.InitializationModule.pas',
  DGHIDEAutoSave.IDEOptionsInterface in 'Source\DGHIDEAutoSave.IDEOptionsInterface.pas',
  DGHIDEAutoSave.Functions in 'Source\DGHIDEAutoSave.Functions.pas',
  DGHIDEAutoSave.CompileNotifier in 'Source\DGHIDEAutoSave.CompileNotifier.pas',
  DGHIDEAutoSave.Types in 'Source\DGHIDEAutoSave.Types.pas',
  DGHIDEAutoSave.SplashScreen in 'Source\DGHIDEAutoSave.SplashScreen.pas',
  DGHIDEAutoSave.ResourceStrings in 'Source\DGHIDEAutoSave.ResourceStrings.pas',
  DGHIDEAutoSave.Interfaces in 'Source\DGHIDEAutoSave.Interfaces.pas',
  DGHIDEAutoSave.Constants in 'Source\DGHIDEAutoSave.Constants.pas',
  DGHIDEAutoSave.AboutBox in 'Source\DGHIDEAutoSave.AboutBox.pas',
  DGHIDEAutoSave.CustomMessage in 'Source\DGHIDEAutoSave.CustomMessage.pas',
  DGHIDEAutoSave.ParentFrame in 'Source\DGHIDEAutoSave.ParentFrame.pas' {fmDIASParentFrame: TFrame};

{$R *.res}


Begin

End.
