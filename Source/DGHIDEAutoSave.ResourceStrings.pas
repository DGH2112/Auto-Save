(**
  
  This module contains resource string for use throughout the application.

  @Author  David Hoyle
  @Version 1.001
  @Date    03 Jun 2020
  
  @license
  
    DGH IDE Auto Save is a RAD Studio plug-in to automatically save your code
    periodically as you work.
    
    Copyright (C) 2020  David Hoyle (https://github.com/DGH2112/Auto-Save/)

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
Unit DGHIDEAutoSave.ResourceStrings;

Interface

ResourceString
  (** A resource string for the name / description of the plug-in on the splash screen and in the about
      box. **)
  strSplashScreenName = 'DGH AutoSave %d.%d%s for %s';
  (** A resource string for the build number of the plug-in on the splash screen and in the about
      box. **)
  {$IFDEF DEBUG}
  (** This is another message string to appear in the BDS 2005/6 splash screen **)
  strSplashScreenBuild = 'David Hoyle (c) 2019 License GNU GPL 3 (DEBUG Build %d.%d.%d.%d)';
  {$ELSE}
  (** This is another message string to appear in the BDS 2005/6 splash screen **)
  strSplashScreenBuild = 'David Hoyle (c) 2019 License GNU GPL 3 (Build %d.%d.%d.%d)';
  {$ENDIF}
  (** A resource string to describe the IDE Options path in its tree. **)
  strIDEAutoSave = 'DGH IDE Auto Save';
  (** A resource string to describe the IDE Options path in its tree. **)
  strIDEAutoSaveOptions = 'DGH IDE Auto Save.Options';


Implementation

End.
