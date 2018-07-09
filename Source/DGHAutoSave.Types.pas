(**
  
  This module contains simepl types for use throughout the application.

  @Author  David Hoyle
  @Version 1.0
  @Date    07 Jul 2018
  
**)
Unit DGHAutoSave.Types;

Interface

Type
  (** An enumerate to define the is and when auto save is done before or after compilation.  **)
  TDGHIDEAutoSaveCompileType = (
    asctNone,
    asctBeforeCompileAll,
    asctBeforeCompileProject,
    asctAfterCompileProject,
    asctAfterCompileAll
  );
  
Implementation

End.
