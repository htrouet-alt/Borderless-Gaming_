[Setup]
#define MainProg "../BorderlessGaming/bin/Release/BorderlessGaming.exe"
#define Major
#define Minor
#define Rev
#define Build
#define Version GetVersionComponents(MainProg, Major, Minor, Rev, Build)
#define AppVersion Str(Major)+"."+Str(Minor)+(Rev > 0 ? "."+Str(Rev) : "")

AppName=Borderless Gaming
AppVersion={#AppVersion}
AppVerName=Borderless Gaming v{#AppVersion}
AppPublisher=Andrew Sampson
AppCopyright=Copyright (C) 2014-2018 Andrew Sampson

DefaultDirName={commonpf}\Borderless Gaming
DefaultGroupName=Borderless Gaming
DisableProgramGroupPage=yes
PrivilegesRequired=admin
DirExistsWarning=no

OutputDir=Output
OutputBaseFilename=BorderlessGaming{#AppVersion}_setup
SetupIconFile=../BorderlessGaming_new.ico
LicenseFile=../LICENSE

Compression=lzma
SolidCompression=yes

UninstallDisplayName=Borderless Gaming
UninstallDisplayIcon={app}\BorderlessGaming.exe

AppPublisherURL=https://github.com/Codeusa/Borderless-Gaming
AppSupportURL=https://github.com/Codeusa/Borderless-Gaming/issues
AppUpdatesURL=https://github.com/Codeusa/Borderless-Gaming/releases/latest

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Code]
var
  UserDataDir: string;

procedure InitializeWizard;
begin
  UserDataDir := ExpandConstant('{userappdata}\Andrew Sampson\Borderless Gaming');
end;

function GetUserDataDir(Param: string): string;
begin
  Result := UserDataDir;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then
  begin
    if MsgBox(
      'Do you want to delete your Borderless Gaming settings and preferences as well?',
      mbConfirmation, MB_YESNO
    ) = IDYES then
    begin
      DelTree(ExpandConstant('{userappdata}\Andrew Sampson\Borderless Gaming'), True, True, True);
    end;
  end;
end;

[Files]
; Main binaries
Source: "../BorderlessGaming/bin/Release/*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs; Excludes: "*.iss"

; License / readme
Source: "../LICENSE"; DestName: "License.txt"; DestDir: "{app}"
Source: "../README.md"; DestName: "Read Me.txt"; DestDir: "{app}"

; Language files -> AppData (do not overwrite user edits)
Source: "../BorderlessGaming/Languages/*"; DestDir: "{code:GetUserDataDir}"; Flags: recursesubdirs createallsubdirs onlyifdoesntexist

[Tasks]
Name: desktopicon; Description: "Create a desktop icon"

[Icons]
Name: "{commondesktop}\Borderless Gaming"; Filename: "{app}\BorderlessGaming.exe"; Tasks: desktopicon
Name: "{group}\Borderless Gaming"; Filename: "{app}\BorderlessGaming.exe"
Name: "{group}\Uninstall Borderless Gaming"; Filename: "{uninstallexe}"
Name: "{group}\License Agreement"; Filename: "{app}\License.txt"
Name: "{group}\Read Me"; Filename: "{app}\Read Me.txt"

[Run]
Filename: "{app}\BorderlessGaming.exe"; Flags: skipifsilent


