; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SimpleIDE"
#define MyDocName "SimpleIDE"
#define MyAppVersion "0-9-45"
#define MyAppPublisher "ParallaxInc"
#define MyAppURL "parallax.com"
#define MyAppExeName "bin\SimpleIDE.exe"

#define compiler "propeller-gcc"

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ---- IMPORTANT!!! ---- Set this to your QtPath
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#define MyQtPath "C:\Qt\4.8.0"
#define MyGccPath "C:\msys\opt\parallax"
#define MyGccMingwPath "C:\mingw"
#define MyTranslations "..\propside\translations"
#define MyUserGuide "..\SimpleIDE-User-Guide.pdf"
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
WizardImageFile=images\SimpleIDE-Install-Splash5.bmp
;WizardImageStretch=no
SetupIconFile=images\SimpleIDE-all.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; Flags: checkedonce;
;  GroupDescription: "{cm:AdditionalIcons}";
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; Flags: checkedonce; OnlyBelowVersion: 0,6.1
; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "association"; Description: "Associate *.side Files with SimpleIDE"; Flags: checkedonce;
; GroupDescription: "File Association:"; 
;Name: "modifypath"; Description: "&Add Propeller-GCC directory to your environment PATH"; Flags: checkedonce;
; GroupDescription: "Propeller-GCC Path:"

[Files]
;Source: "..\propside-build-desktop\debug\SimpleIDE.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "..\propside-build-desktop\release\SimpleIDE.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "IDE_LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LGPL_2_1.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LGPL_EXCEPTION.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: ..\ctags58\README; DestDir: {app}; Flags: ignoreversion; DestName: ctags-readme.txt; 
Source: ..\ctags58\COPYING; DestDir: {app}; Flags: ignoreversion; DestName: ctags-license.txt; 
Source: ..\icons\24x24-free-application-icons\readme.txt; DestDir: {app}; Flags: ignoreversion; DestName: aha-soft-license.txt; 
Source: "{#MyBoardFilter}"; DestDir: "{app}\propeller-gcc\propeller-load\"; Flags: ignoreversion
Source: "{#MyFont}"; DestDir: "{app}\bin"; Flags: ignoreversion

Source: "{#MyGccMingwPath}\bin\libgcc_s_dw2-1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\mingwm10.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\libstdc++*"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyQtPath}\bin\quazip1.dll"; DestDir: "{app}\bin"; Flags: ignoreversion

; Use only for debug version
;Source: "{#MyQtPath}\bin\QtGuid4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion

; remove temporarily for faster testing
; putback for package
Source: "{#MyQtPath}\bin\QtCore4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyQtPath}\bin\QtCored4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyQtPath}\bin\QtGui4.dll"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#MyGccPath}\*"; DestDir: "{app}\propeller-gcc"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyEduLibPath}\*"; DestDir: "{app}\Workspace"; Flags: ignoreversion recursesubdirs createallsubdirs

; Stephanie says not to include the Spin folder with all docs - this one trims the docs.
Source: "{#MySpinPath}\*"; DestDir: "{app}\propeller-gcc\spin"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "..\ctags-5.8\ctags.exe"; DestDir: "{app}\propeller-gcc\bin"; Flags: ignoreversion
Source: "{#MyGccMingwPath}\bin\libi*"; DestDir: "{app}\propeller-gcc\bin"; Flags: ignoreversion
Source: "{#MyTranslations}\SimpleIDE_es.qm"; DestDir: {app}/translations; Flags: IgnoreVersion recursesubdirs createallsubdirs; 
Source: "{#MyTranslations}\SimpleIDE_fr.qm"; DestDir: {app}/translations; Flags: IgnoreVersion recursesubdirs createallsubdirs; 
Source: "{#MyTranslations}\SimpleIDE_zh.qm"; DestDir: {app}/translations; Flags: IgnoreVersion recursesubdirs createallsubdirs; 
Source: "{#MyUserGuide}"; DestDir: "{app}\propeller-gcc\bin"; Flags: IgnoreVersion; 

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
;don't run: the environment variable will not be set until program restart.
;Filename: {app}\{#MyAppExeName}; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, "&", "&&")}}"; Flags: skipifsilent NoWait PostInstall; 

[Registry]
; would like to use HKLM for these things if possible for specifying compiler and user workspace fields.
Root: HKCU; SubKey: Software\{#MyAppPublisher}; Flags: DeleteKey UninsDeleteKey; 
Root: HKCU; SubKey: Software\{#MyAppPublisher}\SimpleIDE\*; Flags: DeleteKey UninsDeleteKey; 
;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Compiler; ValueData: "{app}\propeller-gcc\bin\propeller-elf-gcc.exe"; Flags: UninsDeleteKey; 
;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Includes; ValueData: "{app}\propeller-gcc\propeller-load\"; Flags: UninsDeleteKey; 
;;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Workspace; ValueData: "{userdocs}\Workspace"; Flags: UninsDeleteKey;
;;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_Library; ValueData: "{userdocs}\Workspace\Learn\Simple Libraries\"; Flags: UninsDeleteKey;
;;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinCompiler; ValueData: "{app}\propeller-gcc\bin\bstc.exe"; Flags: UninsDeleteKey; 
;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinLibrary; ValueData: "{app}\propeller-gcc\spin\"; Flags: UninsDeleteKey; 
;;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_SpinWorkspace; ValueData: "{userdocs}\Workspace\"; Flags: UninsDeleteKey;
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "PATH"; ValueData: "{olddata}"; Check: NeedPropGccBinPath();

; File Association. Doesn't work without ChangesAssociations=yes
Root: HKCR; Subkey: ".side"; ValueType: string; ValueData: "SimpleIDE"; Tasks: association;  Flags: UninsDeleteKey;
Root: HKCR; SubKey: "SimpleIDE"; ValueType: string; ValueData: "SimpleIDE Application"; Tasks: association;  Flags: UninsDeleteKey;
Root: HKCR; Subkey: "SimpleIDE\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\bin\SimpleIDE.exe"" ""%1""";  Flags: UninsDeleteKey;
Root: HKCR; SubKey: "SimpleIDE\DefaultIcon"; ValueType: string; ValueData: "{app}\bin\SimpleIDE.exe,3"; Tasks: association;  Flags: UninsDeleteKey;

; Startup File
;Root: HKCU; Subkey: "Software\{#MyAppPublisher}\SimpleIDE"; ValueType: string; ValueName: SimpleIDE_LastFileName; ValueData: "{userdocs}\Workspace\My Projects\Welcome.c"; Flags: UninsDeleteKey; 

[Code]
procedure InitializeWizard;
begin
  { Create the pages }
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
  S := S + 'Propeller-GCC folder:' + Newline + Space + ExpandConstant('{app}\{#compiler}') + NewLine + NewLine;
  S := S + 'SimpleIDE Workspace folder:' + NewLine + Space + 'Will copy to the user Documents\SimpleIDE folder on first SimpleIDE start.' + NewLine;
  S := S + Space + 'Remove the user Documents\SimpleIDE folder first to get a new workspace.' + NewLine;
  Result := S;
end;

function GetCompilerDir(Param: String): String;
begin
  { Return the selected CompilerDir }
  Result := ExpandConstant('{app}\{#compiler}');
end;

function CleanPathString(OldPath: string): boolean;
var
  OrigPath: string;
  PropPath: string;
  PropIndex: integer;
  PropLen: Integer;
  Deleted: boolean;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  then begin
    Result := False;
    exit;
  end;
  
  // look for string like "C:\propgcc\bin" in PATH
  // Pos() returns 0 if not found
  PropPath := OldPath;
  PropLen := Length(PropPath);
  repeat
    PropIndex := Pos(PropPath, UpperCase(OrigPath));
    if PropIndex <> 0  then begin
      Delete( OrigPath, PropIndex, PropLen );
      Deleted := true; 
    end;  
  until PropIndex = 0;

  if Deleted then
    RegWriteExpandStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  Result := True;
end;

{
// this doesn't seem to work! can't rely on it.
function CleanDoubleSemi(): boolean;
var
  OrigPath: string;
  Semi2: string;
  Semi2Index: integer;
  Deleted: boolean;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  then begin
    Result := False;
    exit;
  end;
  
  // remove one ; from any double ;;
  Semi2 := ';;';
  repeat
    Semi2Index := Pos(OrigPath, Semi2);
    if Semi2Index <> 0 then begin
      Delete( OrigPath, Semi2Index, 1 );
      Deleted := true; 
    end;
  until Semi2Index = 0;
  
  if Deleted then
    RegWriteExpandStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  Result := True;
end;
}

function SetPath(NewPath: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  then begin
    Result := False;
    exit;
  end;
  
  OrigPath := OrigPath + ';' + NewPath + ';';

  RegWriteExpandStringValue(HKEY_LOCAL_MACHINE,'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath)
  Result := True;
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
  // look for the path with leading semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + UpperCase(Param) + ';', ';' + UpperCase(OrigPath)) = 0;  
  //if Result = True then
  //   Result := Pos(';' + UpperCase(Param) + '\;', ';' + UpperCase(OrigPath) + ';') = 0; 
end;

function NeedPropGccBinPath(): boolean;
var
  str: string;
begin
  CleanPathString(';C:\PROPGCC\BIN');
  CleanPathString('C:\PROPGCC\BIN'); // incase it was the first entry
  str := ExpandConstant('{app}\{#compiler}')+'\bin';
  Result := NeedsAddPath(str);
  if Result then
    SetPath(str);
  //CleanDoubleSemi(); // can't make this work
end;

