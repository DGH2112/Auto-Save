(**
  
  This module contains code to save modified files in projects or in the entire IDE.

  @Author  David Hoyle
  @Version 1.0
  @Date    26 Jul 2018
  
**)
Unit DGHIDEAutoSave.ToolsAPIFunctions;

Interface

Uses
  ToolsAPI,
  DGHIDEAutoSave.Interfaces;

Type
  (** This is a record to encapsulate all the file saving code. **)
  TDGHIDEAutoSaveToolsAPIFunctions = Record
  Strict Private
    Class Procedure OutputMessage(Const Settings : IDGHIDEAutoSaveSettings;
      Const strFileName : String); Static;
    Class Procedure SaveModule(Const Settings : IDGHIDEAutoSaveSettings; Const Module : IOTAModule);
      Static;
  Public
    Class Procedure SaveAllModifiedFiles(Const Settings : IDGHIDEAutoSaveSettings); Static;
    Class Procedure SaveProjectModifiedFiles(Const Settings : IDGHIDEAutoSaveSettings;
      Const Project : IOTAProject); Static;
  End;

Implementation

Uses
  {$IFDEF DEBUG}
  CodeSiteLogging,
  {$ENDIF}
  System.SysUtils, DGHIDEAutoSave.CustomMessage;

(**

  This method outputs a simple tool message to the message view.

  @precon  None.
  @postcon Outputs a message to the message view for the filename saved.

  @param   Settings    as an IDGHIDEAutoSaveSettings as a constant
  @param   strFileName as a String as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.OutputMessage(Const Settings : IDGHIDEAutoSaveSettings;
  Const strFileName : String);

ResourceString
  strAutoSaveMsg = '[AutoSave] %s: Saved!';

Var
  MS : IOTAMessageServices;
  
Begin
  If Settings.Messages Then
    If Supports(BorlandIDEServices, IOTAMessageServices, MS) Then
      MS.AddCustomMessage(TDGHIDEAutoSaveCustomMessage.Create(
        Format(strAutoSaveMsg, [ExtractFileName(strFileName)]),
        Settings.MessageColour,
        Settings.MessageStyle
      ));
End;

(**

  This method iterators the editor buffer checking for modified files. If one is modified it save the 
  file. If Prompt is true then you are prompted to save the file else it is automatically saved.

  @precon  None.
  @postcon Iterates the files open in the IDE and if they are modified saves the files.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles(
  Const Settings : IDGHIDEAutoSaveSettings);

Var
  ES : IOTAEditorServices;
  Iterator: IOTAEditBufferIterator;
  i: Integer;
  E: IOTAEditBuffer;

Begin
  If Supports(BorlandIDEServices, IOTAEditorServices, ES) Then
    Begin
      If ES.GetEditBufferIterator(Iterator) Then
        Begin
          For i := 0 To Iterator.Count - 1 Do
            Begin
              E := Iterator.EditBuffers[i];
              If E.IsModified Then
                Begin
                  E.Module.Save(False, Not Settings.Prompt);
                  OutputMessage(Settings, E.FileName);
                End;
            End;
        End;
    End;
End;

(**

  This method attempts to save the given module is if the module is valid, its current editor are valid
  and the editor is modified.

  @precon  None.
  @postcon If the module has been modified it is saved.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant
  @param   Module   as an IOTAModule as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.SaveModule(Const Settings : IDGHIDEAutoSaveSettings;
  Const Module : IOTAModule);

Begin
  If Assigned(Module) And Assigned(Module.CurrentEditor) And Module.CurrentEditor.Modified Then
    Begin
      Module.Save(False, Not Settings.Prompt);
      OutputMessage(Settings, Module.FileName);
    End;
End;

(**

  This method iterate through the files in the project and saves any files that have been modified.

  @precon  None.
  @postcon An files int he project which have been modified are saved.

  @param   Settings as an IDGHIDEAutoSaveSettings as a constant
  @param   Project  as an IOTAProject as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(
  Const Settings : IDGHIDEAutoSaveSettings; Const Project : IOTAProject);

Var
  iModule: Integer;
  MI: IOTAModuleInfo;
  M: IOTAModule;
  MS: IOTAModuleServices;

Begin
  If Assigned(Project) Then
    If Supports(BorlandIDEServices, IOTAModuleServices, MS) Then
      Begin
        For iModule := 0 To Project.GetModuleCount - 1 Do
          Begin
            MI := Project.GetModule(iModule);
            M := MS.FindModule(MI.FileName);
            If Assigned(M) Then
              SaveModule(Settings, M);
          End;
        SaveModule(Settings, Project);
      End;
End;

End.
