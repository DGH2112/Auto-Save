(**

  This module contains a wizard interface for creating an options page frame within the
  IDEs main option dialogue.

  @Author  David Hoyle
  @Version 1.1
  @Date    09 Jul 2018

**)
Unit DGHIDEAutoSave.IDEOptionsInterface;

Interface

Uses
  ToolsAPI,
  VCL.Forms,
  DGHIDEAutoSave.OptionsFrame;

{$INCLUDE CompilerDefinitions.inc}

{$IFDEF DXE00}
Type
  (** A class to create an options frame page for the IDEs options dialogue. **)
  TDGHIDEAutoSaveOptionsInterface = Class(TInterfacedObject, INTAAddInOptions)
  Strict Private
    FFrame: TfmIDEAutoSaveOptions;
  Strict Protected
  Public
    Procedure DialogClosed(Accepted: Boolean);
    Procedure FrameCreated(AFrame: TCustomFrame);
    Function GetArea: String;
    Function GetCaption: String;
    Function GetFrameClass: TCustomFrameClass;
    Function GetHelpContext: Integer;
    Function IncludeInIDEInsight: Boolean;
    Function ValidateContents: Boolean;
  End;
{$ENDIF}

Implementation

{TDGHAutoSaveOptions}

Uses
  DGHIDEAutoSave.Types,
  DGHIDEAutoSave.Settings;

{$IFDEF DXE00}
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

Var
  iInterval: Integer;
  boolPrompt, boolEnabled: Boolean;
  eCompileType: TDGHIDEAutoSaveCompileType;

Begin
  If Accepted Then
    Begin
      FFrame.FinaliseFrame(iInterval, boolPrompt, boolEnabled, eCompileType);
      AppOptions.Interval := iInterval;
      AppOptions.Prompt := boolPrompt;
      AppOptions.Enabled := boolEnabled;
      AppOptions.CompileType := eCompileType;
    End;
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
      FFrame.InitialiseFrame(AppOptions.Interval, AppOptions.Prompt,
        AppOptions.Enabled, AppOptions.CompileType);
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

ResourceString
  strIDEAutoSaveOptions = 'IDE Auto Save.Options';

Begin
  Result := strIDEAutoSaveOptions;
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
  Result := TfmIDEAutoSaveOptions;
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
{$ENDIF}

End.
