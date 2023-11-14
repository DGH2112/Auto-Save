(**
  
  This module contains simepl types for use throughout the application.

  @Author  David Hoyle
  @Version 1.001
  @Date    03 Jun 2020
  
  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2023  David Hoyle (https://github.com/DGH2112/Auto-Save/)

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
Unit DGHIDEAutoSave.Types;

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
