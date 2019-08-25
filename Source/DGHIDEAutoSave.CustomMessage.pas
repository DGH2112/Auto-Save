(**
  
  This module contains a class that imlpements custom messages in the IDE so that the messages can be
  nested.

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
Unit DGHIDEAutoSave.CustomMessage;

Interface

Uses
  ToolsAPI,
  DGHIDEAutoSave.Interfaces,
  Graphics,
  Windows;

Type
  (** This is a class which implements the custom messaging interfaces for the IDE. **)
  TDGHIDEAutoSaveCustomMessage = Class(TInterfacedObject, IOTACustomMessage , INTACustomDrawMessage)
  Strict Private
    FMsg    : String;
    FColour : TColor;
    FStyles : TFontStyles;
    FMsgPtr : Pointer;
  Strict Protected
    // IOTA Custom Message
    Function  GetColumnNumber: Integer;
    Function  GetFileName: String;
    Function  GetLineNumber: Integer;
    Function  GetLineText: String;
    Procedure ShowHelp;
    // INTACustomMessage
    Function  CalcRect(Canvas: TCanvas; MaxWidth: Integer; Wrap: Boolean): TRect;
    Procedure Draw(Canvas: TCanvas; Const Rect: TRect; Wrap: Boolean);
  Public
    Constructor Create(Const strMsg: String; Const iColour: TColor; Const setStyles: TFontStyles);
  End;

Implementation

Uses
  SysUtils;

(**

  This method calculates the rectangle for the custom message.

  @precon  None.
  @postcon Returns the size of the custom message rectangle.

  @nocheck MissingCONSTInParam
  @nohint  MaxWidth Wrap
  
  @param   Canvas   as a TCanvas
  @param   MaxWidth as an Integer
  @param   Wrap     as a Boolean
  @return  a TRect

**)
Function TDGHIDEAutoSaveCustomMessage.CalcRect(Canvas: TCanvas; MaxWidth: Integer; Wrap: Boolean): TRect; //FI:O804

Const
  strTextHeightTest = 'Wp';

Begin
  Canvas.Font.Style := FStyles;
  Result := Canvas.ClipRect;
  Result.Bottom := Result.Top + Canvas.TextHeight(strTextHeightTest) + 1;
  Result.Right := Result.Left + Canvas.TextWidth(FMsg);
End;

(**

  A constructor for the TDGHIDEFontCustomMessage class.

  @precon  None.
  @postcon Constructor the custom message saving the parameters to internal fields.

  @param   strMsg    as a String as a constant
  @param   iColour   as a TColor as a constant
  @param   setStyles as a TFontStyles as a constant

**)
Constructor TDGHIDEAutoSaveCustomMessage.Create(Const strMsg: String; Const iColour: TColor;
  Const setStyles: TFontStyles);

Begin
  FMsg := strMsg;
  FColour := iColour;
  FStyles := setStyles;
  FMsgPtr := Nil;
End;

(**

  This method draws the custom message on the canvas.

  @precon  None.
  @postcon The message is drawn.

  @nocheck MissingCONSTInParam
  @nohint  Wrap

  @param   Canvas as a TCanvas
  @param   Rect   as a TRect as a constant
  @param   Wrap   as a Boolean

**)
Procedure TDGHIDEAutoSaveCustomMessage.Draw(Canvas: TCanvas; Const Rect: TRect; Wrap: Boolean); //FI:O804

Var
  R: TRect;
  strMsg: String;

Begin
  R := Rect;
  strMsg := FMsg;
  Canvas.Font.Color := FColour;
  Canvas.Font.Style := FStyles;
  Canvas.TextRect(R, strMsg, [tfLeft, tfVerticalCenter, tfEndEllipsis]);
End;

(**

  This is a getter method for the ColumnNumber property.

  @precon  None.
  @postcon Returns 0 as we are not using this interface property.

  @return  an Integer

**)
Function TDGHIDEAutoSaveCustomMessage.GetColumnNumber: Integer;

Begin
  REsult := 0;
End;

(**

  This is a getter method for the FileName property.

  @precon  None.
  @postcon Returns a nul string as we are not using this interface property.

  @return  a String

**)
Function TDGHIDEAutoSaveCustomMessage.GetFileName: String;

Begin
  Result := '';
End;

(**

  This is a getter method for the LineNumber property.

  @precon  None.
  @postcon returns zero as we are not using this property

  @return  an Integer

**)
Function TDGHIDEAutoSaveCustomMessage.GetLineNumber: Integer;

Begin
  Result := 0;
End;

(**

  This is a getter method for the LineText property.

  @precon  None.
  @postcon We return a null string here due to not using this interface property.

  @return  a String

**)
Function TDGHIDEAutoSaveCustomMessage.GetLineText: String;

Begin
  Result := FMsg;
End;

(**

  This method does nothing and is not used.

  @precon  None.
  @postcon None.

  @nocheck EmptyMethod

**)
Procedure TDGHIDEAutoSaveCustomMessage.ShowHelp;

Begin //FI:W519
  // Do nothing
End;

End.
