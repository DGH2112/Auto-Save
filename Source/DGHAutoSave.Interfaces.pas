(**
  
  This module contains interfaces for use throughout the application.

  @Author  David Hoyle
  @Version 1.0
  @Date    07 Jul 2018
  
**)
Unit DGHAutoSave.Interfaces;

Interface

Uses
  DGHAutoSave.Types;

Type
  (** An interface to describe the applications settings. **)
  IDGHIDEAutoSaveSettings = Interface
  ['{27386FAD-A5BE-4ADF-BF42-266B48D41ECE}']
    Function  GetEnabled : Boolean;
    Procedure SetEnabled(Const boolValue : Boolean);
    Function  GetInterval : Integer;
    Procedure SetInterval(Const iValue : Integer);
    Function  GetPrompt : Boolean;
    Procedure SetPrompt(Const boolValue : Boolean);
    Function  GetCompileType : TDGHIDEAutoSaveCompileType;
    Procedure SetCompileType(Const eCompileType : TDGHIDEAutoSaveCompileType);
    (**
      This property determines whether the autosave functionality is enabled or disabled.
      @precon  None.
      @postcon Gets or sets whether the autosave functionality is enabled or disabled.
      @return  a Boolean
    **)
    Property Enabled: Boolean Read GetEnabled Write SetEnabled;
    (**
      This property defines the timer interval in second between autosaves.
      @precon  None.
      @postcon Gets or sets the interval between autosaves.
      @return  an Integer
    **)
    Property Interval: Integer Read GetInterval Write SetInterval;
    (**
      This property determines whether the user is prompted to save the file or the file
      is simply saved in the background.
      @precon  None.
      @postcon Gets or sets whether the user is prompted to save the modified files.
      @return  a Boolean
    **)
    Property Prompt: Boolean Read GetPrompt Write SetPrompt;
    (**
      This property gets and set whether files should be saved at different position in the compilation
      process.
      @precon  None.
      @postcon gets and set whether files should be saved at different position in the compilation
               process.
      @return  a TDGHIDEAutoSaveCompileType
    **)
    Property CompileType : TDGHIDEAutoSaveCompileType Read GetCompileType Write SetCompileType;
  End;

Implementation

End.
