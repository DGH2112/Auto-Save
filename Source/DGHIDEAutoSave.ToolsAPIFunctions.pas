(**
  
  This module contains code to save modified files in projects or in the entire IDE.

  @Author  David Hoyle
  @Version 1.0
  @Date    09 Jul 2018
  
**)
Unit DGHIDEAutoSave.ToolsAPIFunctions;

Interface

Uses
  ToolsAPI;

Type
  (** This is a record to encapsulate all the file saving code. **)
  TDGHIDEAutoSaveToolsAPIFunctions = Record
  Strict Private
    Class Procedure OutputMessage(Const strFileName : String); Static;
  Public
    Class Procedure SaveAllModifiedFiles; Static;
    Class Procedure SaveProjectModifiedFiles(Const Project : IOTAProject); Static;
  End;

Implementation

Uses
  System.SysUtils,
  DGHIDEAutoSave.Settings;

(**

  This method outputs a simple tool message to the message view.

  @precon  None.
  @postcon Outputs a message to the message view for the filename saved.

  @param   strFileName as a String as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.OutputMessage(Const strFileName: String);

ResourceString
  strDGHIDEAutoSave = 'DGHIDEAutoSave';
  strSaved = 'Saved.';

Var
  MS : IOTAMessageServices;
  
Begin
  If Supports(BorlandIDEServices, IOTAMessageServices, MS) Then
    MS.AddToolMessage(
      strFileName,
      strSaved,
      strDGHIDEAutoSave,
      0,
      0
    );
End;

(**

  This method iterators the editor buffer checking for modified files. If one is modified
  it save the file. If Prompt is true then you are prompted to save the file else it is
  automatically saved.

  @precon  None.
  @postcon Iterates the files open in the IDE and if they are modified saves the files.

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.SaveAllModifiedFiles;

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
                  E.Module.Save(False, Not AppOptions.Prompt);
                  OutputMessage(E.FileName);
                End;
            End;
        End;
    End;
End;

(**

  This method iterate through the files in the project and saves any files that have been modified.

  @precon  None.
  @postcon An files int he project which have been modified are saved.

  @param   Project as an IOTAProject as a constant

**)
Class Procedure TDGHIDEAutoSaveToolsAPIFunctions.SaveProjectModifiedFiles(Const Project: IOTAProject);

Var
  iModule: Integer;
  MI: IOTAModuleInfo;
  M: IOTAModule;
  MS: IOTAModuleServices;

Begin
  If Assigned(Project) Then
    Begin
      For iModule := 0 To Project.GetModuleCount - 1 Do
        Begin
          MI := Project.GetModule(iModule);
          If Supports(BorlandIDEServices, IOTAModuleServices, MS) Then
            Begin
              M := MS.FindModule(MI.FileName);
              If Assigned(M) Then
                Begin 
                  M.Save(False, Not AppOptions.Prompt);
                  OutputMessage(MI.FileName);
                End;
            End;
        End;
    End;
End;

End.
