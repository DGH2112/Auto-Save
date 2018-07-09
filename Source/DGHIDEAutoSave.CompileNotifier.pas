(**
  
  This module contains an CompileNotifier for the IDE.

  @Author  David Hoyle
  @Version 1.0
  @Date    09 Jul 2018
  
**)
Unit DGHIDEAutoSave.CompileNotifier;

Interface

Uses
  ToolsAPI;

Type
  (** A class to implement the IOTACompileNotifier interface. **)
  TDGHIDEAutoSaveCompileNotifier = Class(TInterfacedObject, IOTACompileNotifier)
  Strict Private
    Class Var
      (** A class variable to hold the comppile notifier index. **)
      FCompileNotifierIndex :Integer;
  Strict Protected
    Procedure ProjectCompileFinished(Const Project: IOTAProject; Result: TOTACompileResult);
    Procedure ProjectCompileStarted(Const Project: IOTAProject; Mode: TOTACompileMode);
    Procedure ProjectGroupCompileFinished(Result: TOTACompileResult);
    Procedure ProjectGroupCompileStarted(Mode: TOTACompileMode);
  Public
    Class Procedure InstallIDECompilationEventHandler;
    Class Procedure UninstallIDECompilationEventHandler;
  End;
  
Implementation

Uses
  System.SysUtils,
  DGHIDEAutoSave.Settings, //: @todo Tnis can be removed of class created with IDGHIDEAutoSaveSettings.
  DGHAutoSave.Types,
  DGHIDEAutoSave.ToolsAPIFunctions;

(**

  This method installs the compile notifier into the IDE to capture compiler start and finish events.

  @precon  None.
  @postcon The compile notifier is installed.

**)
Class Procedure TDGHIDEAutoSaveCompileNotifier.InstallIDECompilationEventHandler;

Var
  CS : IOTACompileServices;
  
Begin
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
  If (Result = crOTASucceeded) And (AppOptions.CompileType = asctAfterCompileProject) Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(Project);
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
  Mode: TOTACompileMode);

Begin
  If AppOptions.CompileType = asctBeforeCompileProject Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(Project);
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
  If (Result = crOTASucceeded) And (AppOptions.CompileType = asctAfterCompileAll) Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles;
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
Procedure TDGHIDEAutoSaveCompileNotifier.ProjectGroupCompileStarted(Mode: TOTACompileMode);

Begin
  If AppOptions.CompileType = asctBeforeCompileAll Then
    TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles;
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
