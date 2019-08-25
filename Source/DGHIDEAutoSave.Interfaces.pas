(**
  
  This module contains interfaces for use throughout the application.

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
Unit DGHIDEAutoSave.Interfaces;

Interface

Uses
  Graphics,
  DGHIDEAutoSave.Types;

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
    Function  GetMessages : Boolean;
    Procedure SetMessages(Const boolValue : Boolean);
    Function  GetMessageColour : TColor;
    Procedure SetMessageColour(Const iValue : TColor);
    Function  GetMessageStyles : TFontStyles;
    Procedure SetMessageStyles(Const setValue : TFontStyles);
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
    (**
      This property determines if savded messages are written to the message window for each file saved.
      @precon  None.
      @postcon Determines if savded messages are written to the message window for each file saved.
      @return  a Boolean
    **)
    Property Messages : Boolean Read GetMessages Write SetMessages;
    (**
      This property determines the colour of the custom messages.
      @precon  None.
      @postcon Gets or sets the colour of the custom messages.
      @return  a TColor
    **)
    Property MessageColour : TColor Read GetMessageColour Write SetMessageColour;
    (**
      This property determines the font style of the custom messages.
      @precon  None.
      @postcon Gets or sets the font style of the custom messages.
      @return  a TFontStyles
    **)
    Property MessageStyle : TFontStyles Read GetMessageStyles Write SetMessageStyles;
  End;

Implementation

End.
