# DGH IDE Auto Save

Author:   David Hoyle (davidghoyle@gmail.com / [https://github.com/DGH2112](https://github.com/DGH2112))

Version:  2.3

Date:     30 Dec 2021

Web Page: [http://www.davidghoyle.co.uk/WordPress/?page_id=918](http://www.davidghoyle.co.uk/WordPress/?page_id=918)

## Overview

This is a RAD Studio wizard / expert / plug-in which provide an Auto Save feature in the IDE. Files that have been modified can be saved on a timer or before and after compilation of a project or the whole project group.

## Compilation

This RAD Studio Open Tools API project uses a single DPR/DPROJ file for all version of RAD Studio from XE2 through to the current 10.2 Tokyo. If you need to compile the plug-in yourself just option the project in the IDE and compile and the correct IDE version suffix will be applied to the output DLL.

## Usage

The options are in the main IDEs options page under third parties. They can also be accessed via a sub-menu under the IDEs Help | Help Wizards menu.

The plug-in supports two types of auto save as follows:

* The first is a timer based auto save;
* The second is the ability to save all files or just the project's files before or after compilation.

## Current Limitations

It will only save file added to a project - files change that are on a search path will NOT be saved.

## Binaries

You can download a binary of this project if you don't want to compile it yourself from the web page above.
