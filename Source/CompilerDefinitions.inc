(**

  An include unit to define compiler definitions for versions of Delphi. If the
  definition exists it means that that version of the compiler or high is
  available.

  @Version 1.199
  @Date    15 Jul 2023
  @Author  David Hoyle

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

// Borland Delphi 1, Version 1
{$IFDEF VER80}
  {$DEFINE D0001}
{$ENDIF}

// Borland Delphi 2, Version 2
{$IFDEF VER90}
  {$DEFINE D0001}
  {$DEFINE D0002}
{$ENDIF}

// Borland C++ Builder update
{$IFDEF VER93}
  {$DEFINE D0001}
  {$DEFINE D0002}
{$ENDIF}

// Borland Delphi 3, Version 3
{$IFDEF VER100}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
{$ENDIF}

// Borland C++ Builder Update, Version 3
{$IFDEF VER110}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
{$ENDIF}

// Borland Delphi 4, Version 4
{$IFDEF VER120}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
{$ENDIF}

// Borland C++ Builder Update, Version 4
{$IFDEF VER125}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
{$ENDIF}

// Borland Delphi 5, Version 5, Package version 50
{$IFDEF VER130}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
{$ENDIF}

// Borland Delphi 6, Version 6, Package version 60
{$IFDEF VER140}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
{$ENDIF}

// Borland Delphi 7 & 7.1, Version 7, Package version 70
{$IFDEF VER150}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
{$ENDIF}

// Borland Delphi 8 for .NET, Version 8, Package version 80
{$IFDEF VER160}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
{$ENDIF}

// Borland Delphi 2005 (BDS 3.0?), Version 9, Package version 90
{$IFDEF VER170}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
{$ENDIF}

// Borland Delphi 2006 (BDS 4.0), Version 10, Package version 100
{$IFDEF VER180}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
{$ENDIF}

// CodeGear Delphi 2007 (RAD Studio 5.0), Version 11, Package version 110
{$IFDEF VER185}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
{$ENDIF}

// CodeGear Delphi 2007 for .NET (RAD Studio 5.0), Version 11, Package version 110
{$IFDEF VER190}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
{$ENDIF}

// CodeGear Delphi 2009 (RAD Studio 6.0), Version 12, Package version 12
{$IFDEF VER200}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
{$ENDIF}

// Embarcadero Delphi 2010 (RAD Studio 7.0), Version 14, Package version 140
{$IFDEF VER210}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
{$ENDIF}

// Embarcadero Delphi XE (RAD Studio 8.0), Version 15, Package version 15
{$IFDEF VER220}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
{$ENDIF}

// Embarcadero Delphi XE2 (RAD Studio 9.0), Version 16, Package version 160
{$IFDEF VER230} // 161 is the version for the five FireMonkey packages at XE2 Update 2
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
{$ENDIF}

// Embarcadero Delphi XE3 (RAD Studio 10.0), Version 17, Package version 170
{$IFDEF VER240}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
{$ENDIF}

// Embarcadero Delphi XE4 (RAD Studio 11.0), Version 18, Package version 180
{$IFDEF VER250}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
{$ENDIF}

// Embarcadero Delphi XE5 (RAD Studio 12.0), Version 19, Package version 190
{$IFDEF VER260}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
{$ENDIF}

// Embarcadero Delphi XE6 (RAD Studio 14.0), Version 20, Package version 200
{$IFDEF VER270}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
{$ENDIF}

// Embarcadero Delphi XE7 (Studio 15.0), Version 21, Package version 210
{$IFDEF VER280}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
{$ENDIF}

// Embarcadero Delphi XE8 (Studio 16.0), Version 22, Package version 220
{$IFDEF VER290}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
{$ENDIF}

// Embarcadero Delphi XE10 Seattle (Studio 17.0), Version 23, Package version 230
{$IFDEF VER300}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
{$ENDIF}

// Embarcadero Delphi XE10.1 Berlin (Studio 18.0), Version 24, Package version 240
{$IFDEF VER310}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
{$ENDIF}

// Embarcadero Delphi XE10.2 Tokyo (Studio 19.0), Version 25, Package version 250
{$IFDEF VER320}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
  {$DEFINE RS102}
{$ENDIF}

// Embarcadero Delphi XE10.3 Rio (Studio 20.0), Version 26, Package version 260
{$IFDEF VER330}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
  {$DEFINE RS102}
  {$DEFINE RS103}
{$ENDIF}

// Embarcadero Delphi XE10.4 Sydney (Studio 21.0), Version 27, Package version 270
{$IFDEF VER340}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
  {$DEFINE RS102}
  {$DEFINE RS103}
  {$DEFINE RS104}
{$ENDIF}

// Embarcadero Delphi 11.0 Alexandria (Studio 22.0), Version 28, Package version 280
{$IFDEF VER350}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
  {$DEFINE RS102}
  {$DEFINE RS103}
  {$DEFINE RS104}
  {$DEFINE RS110}
{$ENDIF}

// Embarcadero Delphi 12.0 Athens (Studio 23.0), Version 29, Package version 290
{$IFDEF VER360}
  {$DEFINE D0001}
  {$DEFINE D0002}
  {$DEFINE D0003}
  {$DEFINE D0004}
  {$DEFINE D0005}
  {$DEFINE D0006}
  {$DEFINE D0007}
  {$DEFINE D0008}
  {$DEFINE D2005}
  {$DEFINE D2006}
  {$DEFINE D2007}
  {$DEFINE D2009}
  {$DEFINE D2010}
  {$DEFINE DXE00}
  {$DEFINE DXE20}
  {$DEFINE DXE30}
  {$DEFINE DXE40}
  {$DEFINE DXE50}
  {$DEFINE DXE60}
  {$DEFINE DXE70}
  {$DEFINE DXE80}
  {$DEFINE RS100}
  {$DEFINE RS101}
  {$DEFINE RS102}
  {$DEFINE RS103}
  {$DEFINE RS104}
  {$DEFINE RS110}
  {$DEFINE RS120}
{$ENDIF}

{$IFNDEF D0001}
  {$MESSAGE ERROR 'The Condition Definitions need to be updated!!!!!'}
{$ENDIF}



