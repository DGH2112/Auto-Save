(**

  This module contains function used throughout the application.

  @Version 2.0
  @Author  David Hoyle
  @Date    07 Jul 2018

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
