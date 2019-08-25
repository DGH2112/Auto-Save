(**

  This modulel contains a frame for the root node of the BADI Options frame in the IDE.

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
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

**)
Unit DGHIDEAutoSave.ParentFrame;

Interface

Uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls;

Type
  (** A class to represent the options frame. **)
  TfmDIASParentFrame = Class(TFrame)
    lblBADI: TLabel;
    lblAuthor: TLabel;
    lblBuild: TLabel;
    lblPleaseSelect: TLabel;
    lblBuildDate: TLabel;
    lblInformation: TMemo;
  Strict Private
  Strict Protected
  Public
    Constructor Create(AOwner : TComponent); Override;
  End;

Implementation

{$R *.dfm}

Uses
  DGHIDEAutoSave.Functions;

(**

  This method intialises the frame with build information.

  @precon  None.
  @postcon The frame is initialised.

  @nocheck MissingCONSTInParam

  @param   AOwner as a TComponent

**)
Constructor TfmDIASParentFrame.Create(AOwner: TComponent);

Const
  strBugFix = ' abcdefghijklmnopqrstuvwxyz';
  strBrowseAndDocIt = 'DGH IDE Auto Save %d.%d%s';
  {$IFDEF DEBUG}
  strDEBUGBuild = 'DEBUG Build %d.%d.%d.%d';
  {$ELSE}
  strBuild = 'Build %d.%d.%d.%d';
  {$ENDIF}
  strBuildDateFmt = 'ddd dd/mmm/yyyy hh:nn';
  strBuildDate = 'Build Date: %s';

Var
  VerInfo : TVersionInfo;
  dtDate : TDateTime;
  strModuleName : String;
  iSize : Integer;

Begin
  Inherited Create(AOwner);
  {$IFDEF CODESITE}CodeSite.TraceMethod(Self, 'LoadSettings', tmoTiming);{$ENDIF}
  BuildNumber(VerInfo);
  lblBADI.Caption := Format(strBrowseAndDocIt, [VerInfo.iMajor, VerInfo.iMinor,
    strBugFix[Succ(VerInfo.iBugFix)]]);
  {$IFDEF DEBUG}
  lblBuild.Caption := Format(strDEBUGBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugFix,
    VerInfo.iBuild]);
  lblBuild.Font.Color := clRed;
  {$ELSE}
  lblBuild.Caption := Format(strBuild, [VerInfo.iMajor, VerInfo.iMinor, VerInfo.iBugFix,
    VerInfo.iBuild]);
  {$ENDIF}
  SetLength(strModuleName, MAX_PATH);
  iSize := GetModuleFileName(hInstance, PChar(strModuleName), MAX_PATH);
  SetLength(strModuleName, iSize);
  FileAge(strModuleName, dtDate);
  lblBuildDate.Caption := Format(strBuildDate, [FormatDateTime(strBuildDateFmt, dtDate)]);
  {$IFDEF EUREKALOG}
  lblEurekaLog.Caption := Format(strEurekaLogStatus, [
    BoolToStr(IsEurekaLogInstalled, True),
    BoolToStr(IsEurekaLogActive, True)
  ]);
  lblEurekaLog.Font.Color := clGreen;
  {$ELSE}
  {$ENDIF}
End;

End.

