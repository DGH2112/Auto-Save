Library IDEAutoSaveXE10;

{Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.}

{$R 'SplashScreenIcon.res' '..\Source\SplashScreenIcon.RC'}
{$R 'IDEAutoSaveITHVerInfo.res' 'IDEAutoSaveITHVerInfo.RC'}

uses
  System.SysUtils,
  System.Classes,
  DGHIDEAutoSaveIDEOptionsInterface in '..\Source\DGHIDEAutoSaveIDEOptionsInterface.pas',
  DGHIDEAutoSaveMainWizardInterface in '..\Source\DGHIDEAutoSaveMainWizardInterface.pas',
  DGHIDEAutoSaveModule in '..\Source\DGHIDEAutoSaveModule.pas',
  DGHIDEAutoSaveOptionsForm in '..\Source\DGHIDEAutoSaveOptionsForm.pas' {frmAutoSaveOptions},
  DGHIDEAutoSaveOptionsFrame in '..\Source\DGHIDEAutoSaveOptionsFrame.pas' {fmIDEAutoSaveOptions: TFrame},
  DGHIDEAutoSaveSettings in '..\Source\DGHIDEAutoSaveSettings.pas',
  DGHIDEAutoSaveUtilities in '..\Source\DGHIDEAutoSaveUtilities.pas';

{$R *.res}


Begin

End.
