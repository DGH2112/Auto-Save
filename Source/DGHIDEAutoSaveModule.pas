(**

  This method contains a Delphi IDE wizard that auto saves the modules at a
  specified interval.

  @Date    18 Dec 2016
  @Version 1.0
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
  DGHIDEAutoSaveUtilities,
  Windows,
  DGHIDEAutoSaveMainWizardInterface,
  Forms,
  SysUtils;

Type
  (** A type to distinguish between packages and DLL experts. **)
  TWizardType = (wtPackageWizard, wtDLLWizard);

Const
  (** A constant to define the failed state of a wizard / notifier interface. **)
  iWizardFailState = -1;

Var
  {$IFDEF D2005}
  (** A variable to hold the module`s version information. **)
  VersionInfo            : TVersionInfo;
  {$IFDEF D2007}
  (** A varaible to hold a reference to the splash screen bitmap. **)
  bmSplashScreen24x24    : HBITMAP;
  {$ENDIF}
  (** A varaible to hold a reference to the splash screen bitmap. **)
  bmSplashScreen48x48    : HBITMAP;
  {$ENDIF}
  (** This is an integer passed back by the IDE want the wizard is installed.
      it is needed when the wizard is uninstalled. **)
  iWizardIndex: Integer = iWizardFailState;
  {$IFDEF D0006}
  (** A varaible for referencing the About Plugin interface. **)
  iAboutPluginIndex      : Integer = iWizardFailState;
  {$ENDIF}

{$IFDEF D2005}
Const
  (** A constant string to represent bug fix letters. **)
  strRevision : String = ' abcdefghijklmnopqrstuvwxyz';

ResourceString
  (** A resource string for the splash screen name. **)
  strSplashScreenName = 'IDE AutoSave %d.%d%s for %s';
  (** A resource string for the splash screen build number. **)
  strSplashScreenBuild = 'Freeware by David Hoyle (Build %d.%d.%d.%d)';
{$ENDIF}

(**

  This function initialises the wizard / notifier interfaces for both packages
  and DLLs and returns the created instance of the main wizard / expert
  interface.

  @precon  None.
  @postcon Returns the main wizard template instance.

  @param   WizardType as a TWizardType
  @return  a TDGHAutoSaveWizard

**)
Function InitialiseWizard(WizardType : TWizardType) : TDGHAutoSaveWizard;

Var
  Svcs : IOTAServices;

Begin
  Svcs := BorlandIDEServices As IOTAServices;
  ToolsAPI.BorlandIDEServices := BorlandIDEServices;
  Application.Handle := Svcs.GetParentHandle;
  {$IFDEF D2005}
  // Aboutbox plugin
  bmSplashScreen48x48 := LoadBitmap(hInstance, 'SplashScreenBitMap48x48');
  With VersionInfo Do
    iAboutPluginIndex := (BorlandIDEServices As IOTAAboutBoxServices).AddPluginInfo(
      Format(strSplashScreenName, [iMajor, iMinor, Copy(strRevision, iBugFix + 1, 1), Application.Title]),
      'An auto save wizard for the RAD Studio IDE.',
      bmSplashScreen48x48,
      False,
      Format(strSplashScreenBuild, [iMajor, iMinor, iBugfix, iBuild]),
      Format('SKU Build %d.%d.%d.%d', [iMajor, iMinor, iBugfix, iBuild]));
  {$ENDIF}
  // Create Wizard / Menu Wizard
  Result := TDGHAutoSaveWizard.Create;
  If WizardType = wtPackageWizard Then // Only register main wizard this way if PACKAGE
    iWizardIndex := (BorlandIDEServices As IOTAWizardServices).AddWizard(Result);
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

(**

  This method is called by the IDE for DLLs in order to initialise the wizard /
  expert.

  @precon  None.
  @postcon Initialises the wizard / expert.

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

(** Get the modules building information from its resource and display an item
    in the D2005+ splash screen. **)
Initialization
  {$IFDEF D2005}
  BuildNumber(VersionInfo);
  // Add Splash Screen
  {$IFDEF D2007}
  bmSplashScreen24x24 := LoadBitmap(hInstance, 'SplashScreenBitMap24x24');
  {$ELSE}
  bmSplashScreen48x48 := LoadBitmap(hInstance, 'SplashScreenBitMap48x48');
  {$ENDIF}
  With VersionInfo Do
    (SplashScreenServices As IOTASplashScreenServices).AddPluginBitmap(
      Format(strSplashScreenName, [iMajor, iMinor, Copy(strRevision, iBugFix + 1, 1), Application.Title]),
      {$IFDEF D2007}
      bmSplashScreen24x24,
      {$ELSE}
      bmSplashScreen48x48,
      {$ENDIF}
      False,
      Format(strSplashScreenBuild, [iMajor, iMinor, iBugfix, iBuild]));
  {$ENDIF}
(** Remove all wizards the have been created. **)
Finalization
  // Remove Wizard Interface
  If iWizardIndex > iWizardFailState Then
    (BorlandIDEServices As IOTAWizardServices).RemoveWizard(iWizardIndex);
  {$IFDEF D2005}
  // Remove Aboutbox Plugin Interface
  If iAboutPluginIndex > iWizardFailState Then
    (BorlandIDEServices As IOTAAboutBoxServices).RemovePluginInfo(iAboutPluginIndex);
  {$ENDIF}
End.
