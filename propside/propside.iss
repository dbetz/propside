; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SimpleIDE"
#define MyDocName "SimpleIDE"
#define MyAppVersion "0-9-23x"
#define MyAppPublisher "ParallaxInc"
#define MyAppURL "parallax.com"
#define MyAppExeName "bin\SimpleIDE.exe"

#define compiler "C:\propgcc"

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ---- IMPORTANT!!! ---- Set this to your QtPath
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#define MyQtPath "C:\Qt\4.8.0"
#define MyGccPath "C:\msys\opt\parallax"
#define MyGccMingwPath "C:\mingw"
#define MyTranslations "..\propside\translations"
#define MyUserGuide "..\propside\userguide"
#define MySpinPath "..\spin"
#define MyEduLibPath "..\edulib"
#define MyAppBin "{app}\bin"
#define MyBoardFilter "..\boards.txt"
#define MyFont "Parallax.ttf"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
; AppID={{4FA91D9B-6633-4229-B3BE-DF96DFD916F3} - old v0-7-2 AppID
AppID={{CE380BA3-F51E-4DCB-A068-216961358E89}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=..\propside-build-desktop
OutputBaseFilename=Simple-IDE_{#MyAppVersion}_setup
Compression=lzma/Max
SolidCompression=true
AlwaysShowDirOnReadyPage=true
UserInfoPage=false
UsePreviousUserInfo=false
ChangesEnvironment=true
ChangesAssociations=yes
LicenseFile=.\IDE_LICENSE.txt
WizardImageFile=images\SimpleIDE-Install-Splash3.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; Flags: checkedonce;
;  GroupDescription: "{cm:AdditionalIcons}";
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; Flags: checkedonce; OnlyBelowVersion: 0,6.1
; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "association"; Description: "Associate *.side Files with SimpleIDE"; Flags: checkedonce;
; GroupDescription: "File Association:"; 
Name: "modifypath"; Description: "&Add Propeller-GCC directory to your environment PATH"; Flags: checkedonce;
; GroupDescription: "Propeller-GCC Path:"

[Files]
Source: "..\propside-build-desktop\debug\SimpleIDE.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "IDE_LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LGPL_2_1.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LGPL_EXCEPTION.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: ..\ctags58\README; DestDir: {app}; Flags: ignoreversion; DestName: ctags-readme.txt; 
Source: ..\ctags58\COPYING; DestDir: {app}; Flags: ignoreversion; DestName: ctags-license.txt; 
Source: ..\icons\24x24-free-application-icons\readme.txt; DestDir: {app}; Flags: ignoreversion; DestName: aha-soft-license.txt; 
Source: "{#MyBoardFilter}"; DestDir: "{code:GetCompilerDir}\propeller-load\"; Flags: ignoreversion
Source: "{#MyFont}"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MySpinPath}\*"; DestDir: "{code:GetCompilerDir}\spin"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyEduLibPath}\*"; DestDir: "{code:GetDataDir}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyEduLibPath}\My Projects\*"; DestDir: "{app}\templates"; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "..\propside-demos\*"; DestDir: "{code:GetDataDir}"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#MyGccMingwPath}\bin\libgcc_s_dw2-1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\mingwm10.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\libstdc++*"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyQtPath}\bin\quazip1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion

; remove temporarily for faster testing
; putback for package
Source: "{#MyQtPath}\bin\QtCored4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyQtPath}\bin\QtGuid4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccPath}\*"; DestDir: "{code:GetCompilerDir}"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "..\ctags58\ctags.exe"; DestDir: "{code:GetCompilerDir}\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\libi*"; DestDir: "{code:GetCompilerDir}\bin"; Flags: ignoreversion
Source: "{#MyTranslations}\*"; DestDir: {app}/translations; Flags: IgnoreVersion recursesubdirs createallsubdirs; 
;Source: "{#MyUserGuide}\*"; DestDir: {app}/userguide/; Flags: IgnoreVersion recursesubdirs createallsubdirs; 

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
;don't run: the environment variable will not be set until program restart.
;Filename: {app}\{#MyAppExeName}; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, "&", "&&")}}"; Flags: skipifsilent NoWait PostInstall; 

[Registry]
Root: HKCU; SubKey: "Software\{#MyAppPublisher}"; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Compiler; ValueData: {code:GetCompilerDir}\bin\propeller-elf-gcc.exe; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Includes; ValueData: {code:GetCompilerDir}\propeller-load\; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Workspace; ValueData: {code:GetDataDir}; Flags: UninsDeleteKey;
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Library; ValueData: "{code:GetDataDir}\Learn\Simple Libraries\"; Flags: UninsDeleteKey;
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinCompiler; ValueData: {code:GetCompilerDir}\bin\bstc.exe; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinLibrary; ValueData: {code:GetCompilerDir}\spin\; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinWorkspace; ValueData: {code:GetDataDir}; Flags: UninsDeleteKey;
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "PATH"; ValueData: "{olddata};{code:GetCompilerDir}\bin;"; Check: NeedsAddPropGccBinPath();

; File Association. Doesn't work without ChangesAssociations=yes
Root: HKCR; Subkey: ".side"; ValueType: string; ValueData: "SimpleIDE"; Flags: UninsDeleteValue; Tasks: association; 
Root: HKCR; SubKey: "SimpleIDE"; ValueType: string; ValueData: "SimpleIDE Application"; Flags: UninsDeleteKey; Tasks: association
Root: HKCR; Subkey: "SimpleIDE\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\MYPROG.EXE"" ""%1"""
Root: HKCR; SubKey: "SimpleIDE\DefaultIcon"; ValueType: string; ValueData: {app}\bin\SimpleIDE.exe,0; Tasks: association

; Startup File
; Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_LastFileName; ValueData: {code:GetDataDir}\hello\hello.c; Flags: UninsDeleteKey; 
Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_LastFileName; ValueData: "{code:GetDataDir}\My Projects\Welcome.c"; Flags: UninsDeleteKey; 

[Code]
var
  DataDirPage: TInputDirWizardPage;
  CompilerPage: TInputDirWizardPage;
  
procedure InitializeWizard;
begin
  { Create the pages }
  CompilerPage := CreateInputDirPage(wpSelectDir,
    'Select Compiler Folder', 'Where is Propeller-GCC installed?',
    'Select the folder where Propeller-GCC tools will be installed.    Please do not use a folder having spaces in the folder name.',
    False, '');
  CompilerPage.Add('');
  CompilerPage.Values[0] := GetPreviousData('CompilerDir', ExpandConstant('{#compiler}'));

  DataDirPage := CreateInputDirPage(wpSelectDir,
    'Select Workspace Folder', 'Where should source files be installed?',
    'Select the folder where Setup will install source files, then click Next.',
    False, '');
  DataDirPage.Add('');
  DataDirPage.Values[0] := GetPreviousData('DataDir', ExpandConstant('{userdocs}')+'\SimpleIDE');
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo,
  MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  { Fill the 'Ready Memo' with the normal settings and the custom settings }
  S := '';
  S := S + MemoGroupInfo + Newline + Newline;
  S := S + MemoDirInfo + Newline + Newline;
  S := S + 'SimpleIDE Workspace folder:' + Newline + Space + DataDirPage.Values[0] + NewLine + NewLine;
  S := S + 'Propeller-GCC folder:' + Newline + Space + CompilerPage.Values[0] + NewLine + NewLine;
  Result := S;
end;

function GetDataDir(Param: String): String;
begin
  { Return the selected DataDir }
  Result := DataDirPage.Values[0];
end;

function GetCompilerDir(Param: String): String;
begin
  { Return the selected CompilerDir }
  Result := CompilerPage.Values[0];
end;

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + UpperCase(Param) + ';', ';' + UpperCase(OrigPath) + ';') = 0;  
  if Result = True then
     Result := Pos(';' + UpperCase(Param) + '\;', ';' + UpperCase(OrigPath) + ';') = 0; 
end;

function NeedsAddPropGccBinPath(): boolean;
var
  str: string;
begin
  str := CompilerPage.Values[0]+'\bin';
  Result := NeedsAddPath(str);
end;

{
const
    ModPathName = 'modifypath';
    ModPathType = 'user';

function ModPathDir(): TArrayOfString;
begin
    setArrayLength(Result, 1);
    Result[0] := ExpandConstant('{#compiler}\bin');
end;
include "modpath.iss"
}
