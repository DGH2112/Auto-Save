(**

  This method contains a Delphi IDE wizard that auto saves the modules at a
  specified interval.

  @Date    07 Jul 2018
  @Version 2.1
  @Author  David Hoyle

**)
Unit
  DGHIDEAutoSaveModule;

Interface

Uses
  ToolsAPI;

{$INCLUDE CompilerDefinitions.inc}
{$R 'SplashScreenIcon.res' '..\Source\SplashScreenIcon.RC'}
{$R ..\Packages\IDEAutoSaveITHVerInfo.RES ..\Packages\IDEAutoSaveITHVerInfo.RC}

  Procedure Register;

  Function InitWizard(Const BorlandIDEServices : IBorlandIDEServices;
    RegisterProc : TWizardRegisterProc;
    var Terminate: TWizardTerminateProc) : Boolean; StdCall;

Exports
  InitWizard Name WizardEntryPoint;

Implementation

Uses
  System.SysUtils,
  WinAPI.Windows,
  VCL.Forms,
  DGHIDEAutoSaveUtilities,
  DGHIDEAutoSaveMainWizardInterface;

(**

  This method is called by the IDE for DLLs in order to initialise the wizard /
  expert.

  @precon  None.
  @postcon Initialises the wizard / expert.

  @nocheck MissingCONSTInParam
  @nohint  Terminate
  
  @param   BorlandIDEServices as an IBorlandIDEServices as a constant
  @param   RegisterProc       as a TWizardRegisterProc
  @param   Terminate          as a TWizardTerminateProc as a reference
  @return  a Boolean

**)
Function InitWizard(Const BorlandIDEServices : IBorlandIDEServices; RegisterProc : TWizardRegisterProc;
  var Terminate: TWizardTerminateProc) : Boolean; StdCall;

Begin
  Result := BorlandIDEServices <> Nil;
  If Result Then
    RegisterProc(TDGHAutoSaveWizard.Create);
End;

(**

  This method is called by the IDE for packages in order to initialise the
  wizard / expert.

  @precon  None.
  @postcon Initialises the wizard / expert.

**)
procedure Register;

begin
  RegisterPackageWizard(TDGHAutoSaveWizard.Create);
end;

End.
