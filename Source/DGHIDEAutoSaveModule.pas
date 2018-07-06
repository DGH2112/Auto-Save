(**

  This method contains a Delphi IDE wizard that auto saves the modules at a
  specified interval.

  @Date    06 Jul 2018
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
  DGHIDEAutoSaveMainWizardInterface,
  DGHAutoSave.ResourceStrings,
  DGHAutoSave.Constants;

Type
  (** A type to distinguish between packages and DLL experts. **)
  TWizardType = (wtPackageWizard, wtDLLWizard);

Const
  (** A constant to define the failed state of a wizard / notifier interface. **)
  iWizardFailState = -1;

Var
  (** This is an integer passed back by the IDE want the wizard is installed.
      it is needed when the wizard is uninstalled. **)
  iWizardIndex: Integer = iWizardFailState;
  (** A varaible for referencing the About Plugin interface. **)
  iAboutPluginIndex      : Integer = iWizardFailState;

Const
  (** A constant name for the 48x48 splash screen bitmap in the packages resources. **)
  strSplashScreenBitMap = 'SplashScreenBitMap48x48';

(**

  This function initialises the wizard / notifier interfaces for both packages
  and DLLs and returns the created instance of the main wizard / expert
  interface.

  @precon  None.
  @postcon Returns the main wizard template instance.

  @param   WizardType as a TWizardType as a Constant
  @return  a TDGHAutoSaveWizard

**)
Function InitialiseWizard(Const WizardType : TWizardType) : TDGHAutoSaveWizard;

ResourceString
  strAutoSaveWizardForRADStudioIDE = 'An auto save wizard for the RAD Studio IDE.';
  strSKUBuild = 'SKU Build %d.%d.%d.%d';

Var
  Svcs : IOTAServices;
  bmSplashScreen : HBITMAP;
  VersionInfo: TVersionInfo;

Begin
  Svcs := BorlandIDEServices As IOTAServices;
  ToolsAPI.BorlandIDEServices := BorlandIDEServices;
  Application.Handle := Svcs.GetParentHandle;
  // Aboutbox plugin
  BuildNumber(VersionInfo);
  bmSplashScreen := LoadBitmap(hInstance, strSplashScreenBitMap);
  iAboutPluginIndex := (BorlandIDEServices As IOTAAboutBoxServices).AddPluginInfo(
    Format(strSplashScreenName, [VersionInfo.iMajor, VersionInfo.iMinor, Copy(strRevision,
      VersionInfo.iBugFix + 1, 1), Application.Title]),
    strAutoSaveWizardForRADStudioIDE,
    bmSplashScreen,
    False,
    Format(strSplashScreenBuild, [VersionInfo.iMajor, VersionInfo.iMinor, VersionInfo.iBugfix,
      VersionInfo.iBuild]),
    Format(strSKUBuild, [VersionInfo.iMajor, VersionInfo.iMinor, VersionInfo.iBugfix,
      VersionInfo.iBuild]));
  // Create Wizard / Menu Wizard
  Result := TDGHAutoSaveWizard.Create;
  If WizardType = wtPackageWizard Then // Only register main wizard this way if PACKAGE
    iWizardIndex := (BorlandIDEServices As IOTAWizardServices).AddWizard(Result);
End;

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
Function InitWizard(Const BorlandIDEServices : IBorlandIDEServices;
  RegisterProc : TWizardRegisterProc;
  var Terminate: TWizardTerminateProc) : Boolean; StdCall;

Begin
  Result := BorlandIDEServices <> Nil;
  If Result Then
    RegisterProc(InitialiseWizard(wtDLLWizard));
End;

(**

  This method is called by the IDE for packages in order to initialise the
  wizard / expert.

  @precon  None.
  @postcon Initialises the wizard / expert.

**)
procedure Register;

begin
  InitialiseWizard(wtPackageWizard);
end;

(** Get the modules building information from its resource and display an item
    in the D2005+ splash screen. **)
Initialization
(** Remove all wizards the have been created. **)
Finalization
  // Remove Wizard Interface
  If iWizardIndex > iWizardFailState Then
    (BorlandIDEServices As IOTAWizardServices).RemoveWizard(iWizardIndex);
  // Remove Aboutbox Plugin Interface
  If iAboutPluginIndex > iWizardFailState Then
    (BorlandIDEServices As IOTAAboutBoxServices).RemovePluginInfo(iAboutPluginIndex);
End.
