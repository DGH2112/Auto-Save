(**
  
  This module contains an CompileNotifier for the IDE.

  @Author  David Hoyle
  @Version 1.0
  @Date    25 Aug 2019
  
  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2019  David Hoyle (https://github.com/DGH2112/Auto-Save/)

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
Unit DGHIDEAutoSave.CompileNotifier;

Interface

Uses
  ToolsAPI,
  DGHIDEAutoSave.Interfaces;

Type
  (** A class to implement the IOTACompileNotifier interface. **)
  TDGHIDEAutoSaveCompileNotifier = Class(TInterfacedObject, IInterface, IOTACompileNotifier)
  Strict Private
    Class Var
      (** A class variable to hold the comppile notifier index. **)
      FCompileNotifierIndex :Integer;
      (** A reference to the settings interfaces **)
      FSettings : IDGHIDEAutoSaveSettings;
  Strict Protected
    Procedure ProjectCompileFinished(Const Project: IOTAProject; Result: TOTACompileResult);
    Procedure ProjectCompileStarted(Const Project: IOTAProject; Mode: TOTACompileMode);
    Procedure ProjectGroupCompileFinished(Result: TOTACompileResult);
    Procedure ProjectGroupCompileStarted(Mode: TOTACompileMode);
  Public
    Class Procedure InstallIDECompilationEventHandler(Const Settings : IDGHIDEAutoSaveSettings);
    Class Procedure UninstallIDECompilationEventHandler;
  End;
  
Implementation

Uses
  System.SysUtils,
  DGHIDEAutoSave.Types,
  DGHIDEAutoSave.ToolsAPIFunctions;

(**

  This method installs the compile notifier into the IDE to capture compiler start and finish events.

  @precon  None.
  @postcon The compile notifier is installed.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant

**)
Class Procedure TDGHIDEAutoSaveCompileNotifier.InstallIDECompilationEventHandler(
  Const Settings : IDGHIDEAutoSaveSettings);

Var
  CS : IOTACompileServices;
  
Begin
  FSettings := Settings;
  FCompileNotifierIndex := -1;
  If Supports(BorlandIDEServices, IOTACompileServices, CS) Then
    FCompileNotifierIndex := CS.AddNotifier(TDGHIDEAutoSaveCompileNotifier.Create);
End;

(**

  This method is called when a project compilation is complete.

  @precon  None.
  @postcon Saves the files for the project if the compilation was successful and CompileType is set to
           Save modified files after project compilation.

  @nocheck MissingCONSTInParam

  @param   Project as an IOTAProject as a constant
  @param   Result  as a TOTACompileResult

**)
Procedure TDGHIDEAutoSaveCompileNotifier.ProjectCompileFinished(Const Project: IOTAProject;
  Result: TOTACompileResult);

Begin
  If (Result = crOTASucceeded) And (FSettings.CompileType = asctAfterCompileProject) Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(FSettings, Project);
End;

(**

  This method is called when a project compilation is started.

  @precon  None.
  @postcon Saves the files for the project if the CompileType is set to Save modified files after 
           project compilation.

  @nocheck MissingCONSTInParam
  @nohint  Mode

  @param   Project as an IOTAProject as a constant
  @param   Mode    as a TOTACompileMode

**)
Procedure TDGHIDEAutoSaveCompileNotifier.ProjectCompileStarted(Const Project: IOTAProject;
  Mode: TOTACompileMode); //FI:O804

Begin
  If FSettings.CompileType = asctBeforeCompileProject Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(FSettings, Project);
End;

(**

  This method is called when all projects are compiled.

  @precon  None.
  @postcon Saves all modified the files if the compilation was successful and CompileType is set to
           Save modified files after all projects are compiled.

  @nocheck MissingCONSTInParam

  @param   Result as a TOTACompileResult

**)
Procedure TDGHIDEAutoSaveCompileNotifier.ProjectGroupCompileFinished(Result: TOTACompileResult);

Begin
  If (Result = crOTASucceeded) And (FSettings.CompileType = asctAfterCompileAll) Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles(FSettings);
End;

(**

  This method is called before all projects are compiled.

  @precon  None.
  @postcon Saves all modified the files if the compilation was successful and CompileType is set to Save
           modified files before all projects are compiled.

  @nocheck MissingCONSTInParam
  @nohint  Mode

  @param   Mode as a TOTACompileMode

**)
Procedure TDGHIDEAutoSaveCompileNotifier.ProjectGroupCompileStarted(Mode: TOTACompileMode);//FI:O804

Begin
  If FSettings.CompileType = asctBeforeCompileAll Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles(FSettings);
End;

(**

  This method removes the compile notifier from the IDE.

  @precon  None.
  @postcon The compile notifier is removed.

**)
Class Procedure TDGHIDEAutoSaveCompileNotifier.UninstallIDECompilationEventHandler;

Var
  CS : IOTACompileServices;

Begin
  If Supports(BorlandIDEServices, IOTACompileServices, CS) Then
    If FCompileNotifierIndex > -1 Then
      CS.RemoveNotifier(FCompileNotifierIndex);
End;

End.
