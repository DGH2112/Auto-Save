(**

  This module contains function used throughout the application.

  @Version 2.0
  @Author  David Hoyle
  @Date    25 Aug 2019

  @license
  
    Auto Save is a RAD Studio plug-in to automatically save your code
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
Unit DGHIDEAutoSave.Functions;

Interface

{$INCLUDE CompilerDefinitions.inc}

Type
  (** A record to hold version information. **)
  TVersionInfo = Record
    iMajor  : Integer;
    iMinor  : Integer;
    iBugfix : Integer;
    iBuild  : Integer;
  End;

  Procedure BuildNumber(var VersionInfo : TVersionInfo);

Implementation

Uses
  WinAPI.Windows;

(**

  This method extracts the Major, Minor, Bugfix and Build version numbers from
  this modules resource information.

  @precon  None.
  @postcon Returns the version information in the var parameter.

  @param   VersionInfo as a TVersionInfo as a reference

**)
Procedure BuildNumber(Var VersionInfo: TVersionInfo);

Const
  iRightShift = 16;
  iWORDMask = $FFFF;

Var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  strBuffer: Array [0 .. MAX_PATH] Of Char;

Begin
  GetModuleFileName(hInstance, strBuffer, MAX_PATH);
  VerInfoSize := GetFileVersionInfoSize(strBuffer, Dummy);
  If VerInfoSize <> 0 Then
    Begin
      GetMem(VerInfo, VerInfoSize);
      Try
        GetFileVersionInfo(strBuffer, 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        VersionInfo.iMajor := VerValue^.dwFileVersionMS Shr iRightShift;
        VersionInfo.iMinor := VerValue^.dwFileVersionMS And iWORDMask;
        VersionInfo.iBugfix := VerValue^.dwFileVersionLS Shr iRightShift;
        VersionInfo.iBuild := VerValue^.dwFileVersionLS And iWORDMask;
      Finally
        FreeMem(VerInfo, VerInfoSize);
      End;
    End;
End;

End.
