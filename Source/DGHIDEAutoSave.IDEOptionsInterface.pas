(**

  This module contains a wizard interface for creating an options page frame within the
  IDEs main option dialogue.

  @Author  David Hoyle
  @Version 1.1
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
Unit DGHIDEAutoSave.IDEOptionsInterface;

Interface

Uses
  ToolsAPI,
  VCL.Forms,
  DGHIDEAutoSave.Interfaces,
  DGHIDEAutoSave.OptionsFrame,
  DGHIDEAutoSave.ResourceStrings;

Type
  (** An enumerate to define the frame type to be created. **)
  TDIASFrameType = (ftParent, ftOptions);

  (** A class to create an options frame page for the IDEs options dialogue. **)
  TDGHIDEAutoSaveOptionsInterface = Class(TInterfacedObject, INTAAddInOptions)
  Strict Private
    FFrame     : TfmIDEAutoSaveOptions;
    FSettings  : IDGHIDEAutoSaveSettings;
    FFrameType : TDIASFrameType;
  Strict Protected
    Procedure DialogClosed(Accepted: Boolean);
    Procedure FrameCreated(AFrame: TCustomFrame);
    Function GetArea: String;
    Function GetCaption: String;
    Function GetFrameClass: TCustomFrameClass;
    Function GetHelpContext: Integer;
    Function IncludeInIDEInsight: Boolean;
    Function ValidateContents: Boolean;
  Public
    Constructor Create(Const Settings : IDGHIDEAutoSaveSettings; Const eFrameType : TDIASFrameType);
  End;

Implementation

Uses
  DGHIDEAutoSave.Types,
  DGHIDEAutoSave.Settings,
  DGHIDEAutoSave.ParentFrame;

(**

  A constructor for the TDGHIDEAutoSaveOptionsInterface class.

  @precon  None.
  @postcon Saves a reference to the settings interface.

  @param   Settings   as an IDGHIDEAutoSaveSettings as a constant
  @param   eFrameType as a TDIASFrameType as a constant

**)
Constructor TDGHIDEAutoSaveOptionsInterface.Create(Const Settings : IDGHIDEAutoSaveSettings;
  Const eFrameType : TDIASFrameType);

Begin
  FSettings := Settings;
  FFrameType := eFrameType;
End;

(**

  This method is call when the IDEs Options dialogue is closed. Accepted = True if the
  dialogue is confirmed and settings should be saved or Accepted = False if the dialogue
  if dismissed and setting changes should not be saved.

  @precon  None.
  @postcon If the dialogue is accepted then the options frame settings are retreived and
           saved back to the applications options class.

  @nocheck MissingCONSTInParam

  @param   Accepted as a Boolean

**)
Procedure TDGHIDEAutoSaveOptionsInterface.DialogClosed(Accepted: Boolean);

Begin
  If Accepted Then
    If FFrame Is TfmIDEAutoSaveOptions Then
      FFrame.FinaliseFrame(FSettings);
End;

(**

  This method is called when IDE creates the Options dialogue and creates your options
  frame for you and should be used to initialise the frame information.

  @precon  None.
  @postcon Checks the frame is the corrct frames and is so initialises the frame through
           its InitialiseFrame method.

  @nocheck MissingCONSTInParam

  @param   AFrame as a TCustomFrame

**)
Procedure TDGHIDEAutoSaveOptionsInterface.FrameCreated(AFrame: TCustomFrame);

Begin
  If AFrame Is TfmIDEAutoSaveOptions Then
    Begin
      FFrame := AFrame As TfmIDEAutoSaveOptions;
      FFrame.InitialiseFrame(FSettings);
    End;
End;

(**

  This is called by the IDE to get the primary area in the options tree where your options
  frame is to be displayed. Recommended to return a null string to have your options
  displayed under a third party node.

  @precon  None.
  @postcon Returns a null string to place the options under the Third Parrty node.

  @return  a String

**)
Function TDGHIDEAutoSaveOptionsInterface.GetArea: String;

Begin
  Result := '';
End;

(**

  This method is caled by the IDE to get the sub node tre items where the page is to be
  displayed. The period acts as a separator for another level of node in the tree.

  @precon  None.
  @postcon Returns the name of the expert then the page name separated by a period.

  @return  a String

**)
Function TDGHIDEAutoSaveOptionsInterface.GetCaption: String;

Begin
  Case FFrameType Of
    ftParent:  Result := strIDEAutoSave;
    ftOptions: Result := strIDEAutoSaveOptions;
  End;
  
End;

(**

  This method should return a class reference to your frame for so that the IDe can create
  an instance of your frame for you.

  @precon  None.
  @postcon Returns a class reference to the options frame form.

  @return  a TCustomFrameClass

**)
Function TDGHIDEAutoSaveOptionsInterface.GetFrameClass: TCustomFrameClass;

Begin
  Result := Nil;
  Case FFrameType Of
    ftParent:  Result := TfmDIASParentFrame;
    ftOptions: Result := TfmIDEAutoSaveOptions;
  End;
End;

(**

  This method returns the help context reference for the optins page.

  @precon  None.
  @postcon Returns 0 for no context.

  @return  an Integer

**)
Function TDGHIDEAutoSaveOptionsInterface.GetHelpContext: Integer;

Begin
  Result := 0;
End;

(**

  This method determines whether your options frame page appears in the IDE Insight
  search. Its recommended you return true.

  @precon  None.
  @postcon Returns true to include in IDE Insight.

  @return  a Boolean

**)
Function TDGHIDEAutoSaveOptionsInterface.IncludeInIDEInsight: Boolean;

Begin
  Result := True;
End;

(**

  This method should be used to valdate you options frame. You should display an error
  message if there is something wrong and return false else if all is okay return true.

  @precon  None.
  @postcon Checks the interval is a valid integer greater than zero.

  @return  a Boolean

**)
Function TDGHIDEAutoSaveOptionsInterface.ValidateContents: Boolean;

Var
  iInterval: Integer;
  iErrorCode: Integer;

Begin
  Val(FFrame.edtAutosaveInterval.Text, iInterval, iErrorCode);
  Result := (iErrorCode = 0) And (iInterval > 0);
End;

End.
