(*
   tvAPIThing

   Primary Author: Tim Victor - tvictor@erols.com
   With the help of the following:
      Wolfgang Wendefeuer
      William A. Portillo

   Version History

   1.00 17Aug1997 - Original
   1.01 14Sep1997 - Added disk formatting/GlobalMemoryStatus/ExitWindows,
                    with the input of Wolfgang Wendefeuer recoded the unit to
                    minimize compiler warning and tips
   1.1  11Nov1997 - Added properties to correspond to all fields in the
                    SYSTEM_INFO structure.
   1.2  26Dec1997 - Added Network dis/connection functions
   4.0  05Aug1998 - Upgraded component to D4

*)


unit mpiAPI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ShellAPI, Forms, Dialogs;

type
  TInformationStrings = ( isCompanyName,  isFileDescription, isFileVersion,
                          isInternalName, isLegalCopyright,  isOriginalFilename,
                          isProductName,  isProductVersion,  isComments,
                          isLegalTrademarks );

  TFileTimeComparision = ( ftError, ftFileOneIsOlder, ftFileTimesAreEqual, ftFileTwoIsOlder );

  TTimeOfWhat = ( ftCreationTime, ftLastAccessTime, ftLastWriteTime );

  TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM);

  TVolumeInfo = record
     Name               : String;
     SerialNumber       : DWORD;
     MaxComponentLength : DWORD;
     FileSystemFlags    : DWORD;
     FileSystemName     : String;
  end; // TVolumeInfo

  type
  PFixedFileInfo = ^TFixedFileInfo;
  TFixedFileInfo = record
     dwSignature       : DWORD;
     dwStrucVersion    : DWORD;
     wFileVersionMS    : WORD;  // Minor Version
     wFileVersionLS    : WORD;  // Major Version
     wProductVersionMS : WORD;  // Build Number
     wProductVersionLS : WORD;  // Release Version
     dwFileFlagsMask   : DWORD;
     dwFileFlags       : DWORD;
     dwFileOS          : DWORD;
     dwFileType        : DWORD;
     dwFileSubtype     : DWORD;
     dwFileDateMS      : DWORD;
     dwFileDateLS      : DWORD;
  end; // TFixedFileInfo

  TtvAPIThing = class( TComponent )
  private
    // System Information
    function myGetUserName            : String;
    function myGetComputerName        : String;
    function myGetWindowsDirectory    : String;
    function myGetSystemDirectory     : String;
    // Time Functions
    function myGetSystemTime          : String;
    function myGetLocalTime           : String;

    // File Functions
    function myGetCurrentDirectory                                                  : String;
    function myGetTempPath                                                          : String;
    function myGetLogicalDrives                                                     : String;

    function myGetFileTime( const FileName : String; ComparisonType : TTimeOfWhat ) : TFileTime;
    function myGetVersion                                                           : String;
    function myGlobalMemoryStatus( const Index : Integer )                          : DWORD;

    function myGetSystemInfoWORD( const Index : Integer )                           : WORD;
    function myGetSystemInfoDWORD( const Index : Integer )                          : DWORD;
    // Removed for D4
    function myGetSystemInfoPtr( const Index : Integer )                            : Pointer;

    function SystemTimeToDateTime(const SystemTime: TSystemTime)                    : TDateTime;
  protected

  public
    function GetFileInformation(    const FileName, Value : String ): String;
    function CompareFileTime(       const FileNameOne, FileNameTwo : String; ComparisonType : TTimeOfWhat ): TFileTimeComparision;
    function GetFileTime(           const FileName : String; ComparisonType : TTimeOfWhat ): TDateTime;
    function FileInfo(              const FileName : String ) : TFixedFileInfo;
    function ExtractIcon(           const FileName : String ): HIcon;
    function ExtractAssociatedIcon( const FileName : String ): HIcon;
    function GetFreeDiskSpace(      const Drive : Char ) : LongInt;
    function FileSize(              const FileName : String ) : LongInt;
    function GetShortPathName(      const Path : String ): String;
    function GetFullPathName(       const Path : String ): String;
    function GetVolumeInformation(  const Drive : Char ) : TVolumeInfo;
    function FindExecutable(        const FileName : String ): String;
    function DriveType(             const Drive : Char ) : TDriveType;
    function DisconnectNetworkDrive( const Drive : Char ): Boolean;
    function AddNetworkDrive( const Resource : String; const Drive : Char ): Boolean;
    function GetUniversalName( const Drive : Char ): String;

    procedure ShellAbout( const TitleBar, OtherText : String );
    procedure FormatDrive( const Drive : Char );
    procedure ShutDown;

    // Pointer Fields
    // D4 won't allow them to be published attributes
    property lpMinimumApplicationAddress : Pointer index 1 read myGetSystemInfoPtr;
    property lpMaximumApplicationAddress : Pointer index 2 read myGetSystemInfoPtr;
  published
    // System Information
    property UserName               : String read myGetUserName;
    property ComputerName           : String read myGetComputerName;
    property WindowsDirectory       : String read myGetWindowsDirectory;
    property SystemDirectory        : String read myGetSystemDirectory;
    // Time Functions
    property SystemTime             : String read myGetSystemTime;
    property LocalTime              : String read myGetLocalTime;
    // File Functions
    property CurrentDirectory       : String read myGetCurrentDirectory;
    property TempPath               : String read myGetTempPath;
    property LogicalDrives          : String read myGetLogicalDrives;
    property OSVersion              : String read myGetVersion;
    // From GlobalMemoryStatus
    property dwMemoryLoad           : DWORD index 1 read myGlobalMemoryStatus;
    property dwTotalPhys            : DWORD index 2 read myGlobalMemoryStatus;
    property dwAvailPhys            : DWORD index 3 read myGlobalMemoryStatus;
    property dwTotalPageFile        : DWORD index 4 read myGlobalMemoryStatus;
    property dwAvailPageFile        : DWORD index 5 read myGlobalMemoryStatus;
    property dwTotalVirtual         : DWORD index 6 read myGlobalMemoryStatus;
    property dwAvailVirtual         : DWORD index 7 read myGlobalMemoryStatus;

    // TSystemInfo
    // WORD Fields
    property ProcessorArchitecture       : WORD index 1 read myGetSystemInfoWORD;
    property ProcessorLevel              : WORD index 2 read myGetSystemInfoWORD;
    property ProcessorRevision           : WORD index 3 read myGetSystemInfoWORD;
    // DWORD Fields
    property PageSize                    : DWORD index 1 read myGetSystemInfoDWORD;
    property ActiveProcessorMask         : DWORD index 2 read myGetSystemInfoDWORD;
    property NumberOfProcessors          : DWORD index 3 read myGetSystemInfoDWORD;
    property ProcessorType               : DWORD index 4 read myGetSystemInfoDWORD;
    property AllocationGranularity       : DWORD index 5 read myGetSystemInfoDWORD;

  end;

  procedure Register;

const
   PROCESSOR_INTEL_386     = 386;
   PROCESSOR_INTEL_486     = 486;
   PROCESSOR_INTEL_PENTIUM = 586;
   PROCESSOR_MIPS_R4000    = 4000;
   PROCESSOR_ALPHA_21064   = 21064;

function SHFormatDrive(hWnd : HWND;Drive, fmtID, Options : WORD) : longint; stdcall; external  'shell32.dll';

implementation

// Goes right after the VS_FIXEDFILEINFO structure
function TtvAPIThing.FileInfo( const FileName :String ) : TFixedFileInfo;
var
  dwHandle, dwVersionSize : DWORD;
  strSubBlock             : String;
  pTemp                   : Pointer;
  pData                   : Pointer;
begin
   strSubBlock := '\';

   // get version information values
   dwVersionSize := GetFileVersionInfoSize( PChar( FileName ), // pointer to filename string
                                            dwHandle );        // pointer to variable to receive zero

   // if GetFileVersionInfoSize is successful
   if dwVersionSize <> 0 then
   begin
      GetMem( pTemp, dwVersionSize );
      try
         if GetFileVersionInfo( PChar( FileName ),             // pointer to filename string
                                dwHandle,                      // ignored
                                dwVersionSize,                 // size of buffer
                                pTemp ) then                   // pointer to buffer to receive file-version info.

            if VerQueryValue( pTemp,                           // pBlock     - address of buffer for version resource
                              PChar( strSubBlock ),            // lpSubBlock - address of value to retrieve
                              pData,                           // lplpBuffer - address of buffer for version pointer
                              dwVersionSize ) then             // puLen      - address of version-value length buffer
               Result := PFixedFileInfo( pData )^;
      finally
         FreeMem( pTemp );
      end; // try
   end; // if dwVersionSize
end;

function TtvAPIThing.GetFileInformation( const FileName, Value : String ): String;
var
  dwHandle, dwVersionSize   : DWORD;
  strLangCharSetInfoString  : String;
  pcBuffer                  : PChar;
  pTemp                     : Pointer;
begin
   //////////////////////////////////////////////////////////////////////////////////
   // The Win32 API contains the following predefined version information strings: //
   //////////////////////////////////////////////////////////////////////////////////
   //    CompanyName               FileDescription          FileVersion            //
   //    InternalName              LegalCopyright           OriginalFilename       //
   //    ProductName               ProductVersion           Comments               //
   //    LegalTrademarks                                                           //
   //////////////////////////////////////////////////////////////////////////////////

   //////////////////////////////////////////////////////////////////////////////////
   // Decription of lpSubBlock from the Win32 API (sLangCharSet)                   //
   //////////////////////////////////////////////////////////////////////////////////
   // Specifies a value in a language-specific structure. The lang-charset name is //
   // a concatenation of a language and character-set identifier pair found in the //
   // translation table for the resource. The lang-charset name must be specified  //
   // as a hexadecimal string. The string-name name is one of the predefined       //
   // strings described in the following Remarks section.                          //
   //////////////////////////////////////////////////////////////////////////////////

   strLangCharSetInfoString := '\StringFileInfo\040904E4\' + Value;

   // get version information values
   dwVersionSize := GetFileVersionInfoSize( PChar( FileName ),   // pointer to filename string
                                            dwHandle );          // pointer to variable to receive zero

   // if GetFileVersionInfoSize is successful
   if dwVersionSize <> 0 then
   begin
      GetMem( pcBuffer, dwVersionSize );
      try
         if GetFileVersionInfo( PChar( FileName ),               // pointer to filename string
                                dwHandle,                        // ignored
                                dwVersionSize,                   // size of buffer
                                pcBuffer ) then                  // pointer to buffer to receive file-version info.

            if VerQueryValue( pcBuffer,                          // pBlock     - address of buffer for version resource
                              PChar( strLangCharSetInfoString ), // lpSubBlock - address of value to retrieve
                              pTemp,                             // lplpBuffer - address of buffer for version pointer
                              dwVersionSize ) then               // puLen      - address of version-value length buffer

               Result := PChar( pTemp );
      finally
         FreeMem( pcBuffer );
      end; // try
   end;// if dwVersionSize
end; // GetFileInformation

function TtvAPIThing.myGetUserName : String;
var
   pcUser   : PChar;
   dwUSize : DWORD;
begin
   dwUSize := 21; // user name can be up to 20 characters
   GetMem( pcUser, dwUSize ); // allocate memory for the string
   try
      if Windows.GetUserName( pcUser, dwUSize ) then
         Result := pcUser
   finally
      FreeMem( pcUser ); // now free the memory allocated for the string
   end;
end;

function TtvAPIThing.myGetComputerName : String;
var
   pcComputer : PChar;
   dwCSize    : DWORD;
begin
   dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
   GetMem( pcComputer, dwCSize ); // allocate memory for the string
   try
      if Windows.GetComputerName( pcComputer, dwCSize ) then
         Result := pcComputer;
   finally
      FreeMem( pcComputer ); // now free the memory allocated for the string
   end;
end;

function TtvAPIThing.myGetWindowsDirectory : String;
var
   pcWindowsDirectory : PChar;
   dwWDSize           : DWORD;
begin
   dwWDSize := MAX_PATH + 1;
   GetMem( pcWindowsDirectory, dwWDSize ); // allocate memory for the string
   try
      if Windows.GetWindowsDirectory( pcWindowsDirectory, dwWDSize ) <> 0 then
         Result := pcWindowsDirectory;
   finally
      FreeMem( pcWindowsDirectory ); // now free the memory allocated for the string
   end;
end;

function TtvAPIThing.myGetSystemDirectory : String;
var
   pcSystemDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcSystemDirectory, dwSDSize ); // allocate memory for the string
   try
      if Windows.GetSystemDirectory( pcSystemDirectory, dwSDSize ) <> 0 then
         Result := pcSystemDirectory;
   finally
      FreeMem( pcSystemDirectory ); // now free the memory allocated for the string
   end;
end;

function TtvAPIThing.myGetSystemTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetSystemTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

function TtvAPIThing.myGetLocalTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetLocalTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

function TtvAPIThing.CompareFileTime( const FileNameOne, FileNameTwo : String; ComparisonType : TTimeOfWhat ): TFileTimeComparision;
var
   FileOneFileTime : TFileTime;
   FileTwoFileTime : TFileTime;
begin
   Result := ftError;

   FileOneFileTime := myGetFileTime( FileNameOne, ComparisonType );
   FileTwoFileTime := myGetFileTime( FileNameTwo, ComparisonType );

   case Windows.CompareFileTime( FileOneFileTime, FileTwoFileTime ) of
      -1 : Result := ftFileOneIsOlder;
       0 : Result := ftFileTimesAreEqual;
       1 : Result := ftFileTwoIsOlder;
   end;

end;

function TtvAPIThing.GetFileTime( const FileName : String; ComparisonType : TTimeOfWhat ): TDateTime;
var
   SystemTime : TSystemTime;
   FileTime   : TFileTime;
begin
   Result := StrToDate( '12/31/9999' );

   FileTime := myGetFileTime( FileName, ComparisonType );
   if FileTimeToSystemTime( FileTime, SystemTime ) then
      // Convert to TDateTime and return
      Result := SystemTimeToDateTime( SystemTime );
end;

function TtvAPIThing.myGetFileTime( const FileName : String; ComparisonType : TTimeOfWhat ) : TFileTime;
var
   FileTime, LocalFileTime : TFileTime;
   hFile                   : THandle;
begin
   // initialize TFileTime record in case of error
   Result.dwLowDateTime := 0;
   Result.dwHighDateTime := 0;
   hFile := FileOpen( FileName, fmShareDenyNone );
   try
      if hFile <> 0 then
      begin
         case ComparisonType of
            ftCreationTime   : Windows.GetFileTime( hFile, @FileTime, nil, nil );
            ftLastAccessTime : Windows.GetFileTime( hFile, nil, @FileTime, nil );
            ftLastWriteTime  : Windows.GetFileTime( hFile, nil, nil, @FileTime );
         end; // case FileTimeOf

         // Change the file time to local time
         FileTimeToLocalFileTime( FileTime, LocalFileTime );
         Result := LocalFileTime;
      end; // if hFile <> 0
   finally
      FileClose( hFile );
   end; // try
end;

procedure TtvAPIThing.ShellAbout( const TitleBar, OtherText : String );
begin
   ShellAPI.ShellAbout( Application.Handle,
                        PChar( TitleBar ),
                        PChar( OtherText ),
                        Application.Icon.Handle );
end;

function TtvAPIThing.ExtractIcon( const FileName : String ): HIcon;
begin
   Result := ShellAPI.ExtractIcon( Application.Handle,
                                   PChar( FileName ),
                                   0 );
end;

function TtvAPIThing.ExtractAssociatedIcon( const FileName : String ): HIcon;
var
   wIndex  : WORD;
   pcFileName : Pchar;
begin
   // with help from:
   // William A. Portillo.
   //wp@ois.com.au
   GetMem( pcFileName, MAX_PATH + 1 ); // Allocate memory for our pointer
   try
      StrPCopy( pcFilename, FileName ); // Copy the Filename into the Pchar var
      Result := ShellAPI.ExtractAssociatedIcon( Application.Handle,
                                                pcFileName,
                                                wIndex );
   finally
      // free allocated memory
      FreeMem( pcFileName );
   end; // try
end;

function TtvAPIThing.GetFreeDiskSpace( const Drive : Char ) : LongInt;
var
   lpRootPathName          : PChar;	// address of root path
   lpSectorsPerCluster     : DWORD;	// address of sectors per cluster
   lpBytesPerSector        : DWORD;	// address of bytes per sector
   lpNumberOfFreeClusters  : DWORD;	// address of number of free clusters
   lpTotalNumberOfClusters : DWORD;	// address of total number of clusters
begin
      lpRootPathName := PChar( Drive + ':\' );
      if Windows.GetDiskFreeSpace( lpRootPathName,
                                   lpSectorsPerCluster,
                                   lpBytesPerSector,
                                   lpNumberOfFreeClusters,
                                   lpTotalNumberOfClusters ) then
         Result := lpNumberOfFreeClusters * lpBytesPerSector * lpSectorsPerCluster
      else
         Result := -1;
end;

function TtvAPIThing.myGetCurrentDirectory: String;
var
   nBufferLength : DWORD; // size, in characters, of directory buffer
   lpBuffer 	 : PChar; // address of buffer for current directory
begin
   nBufferLength := MAX_PATH + 1;
   GetMem( lpBuffer, nBufferLength );
   try
      if Windows.GetCurrentDirectory( nBufferLength, lpBuffer ) > 0 then
         Result := lpBuffer;
   finally
      FreeMem( lpBuffer );
   end; // try
end;

function TtvAPIThing.FileSize( const FileName : String ) : LongInt;
var
   hFile          : THandle; // handle of file to get size of
   lpFileSizeHigh : DWORD;   // address of high-order WORD for file size
begin
   Result := -1;
   hFile := FileOpen( FileName, fmShareDenyNone );
   try
      if hFile <> 0 then
         Result := Windows.GetFileSize( hFile, @lpFileSizeHigh );
   finally
      FileClose( hFile );
   end; // try
end;

function TtvAPIThing.GetShortPathName( const Path : String ): String;
var
   lpszShortPath : PChar; // points to a buffer to receive the null-terminated short form of the path
begin
   GetMem( lpszShortPath, MAX_PATH + 1 );
   try
      Windows.GetShortPathName( PChar( Path ), lpszShortPath, MAX_PATH + 1 );
      Result := lpszShortPath;
   finally
      FreeMem( lpszShortPath );
   end;
end;

function TtvAPIThing.myGetTempPath: String;
var
    nBufferLength : DWORD; // size, in characters, of the buffer
    lpBuffer      : PChar; // address of buffer for temp. path
begin
   nBufferLength := MAX_PATH + 1; // initialize
   GetMem( lpBuffer, nBufferLength );
   try
      if GetTempPath( nBufferLength, lpBuffer ) <> 0 then
         Result := StrPas( lpBuffer )
      else
         Result := '';
   finally
      FreeMem( lpBuffer );
   end;
end;

function TtvAPIThing.GetVolumeInformation( const Drive : Char ) : TVolumeInfo;
var
   lpRootPathName           : PChar; // address of root directory of the file system
   lpVolumeNameBuffer       : PChar; // address of name of the volume
   nVolumeNameSize          : DWORD; // length of lpVolumeNameBuffer
   lpVolumeSerialNumber     : DWORD; // address of volume serial number
   lpMaximumComponentLength : DWORD; // address of system's maximum filename length
   lpFileSystemFlags        : DWORD; // address of file system flags
   lpFileSystemNameBuffer   : PChar; // address of name of file system
   nFileSystemNameSize      : DWORD; // length of lpFileSystemNameBuffer
begin
   GetMem( lpVolumeNameBuffer, MAX_PATH + 1 );
   GetMem( lpFileSystemNameBuffer, MAX_PATH + 1 );
   try
      nVolumeNameSize     := MAX_PATH + 1;
      nFileSystemNameSize := MAX_PATH + 1;

      lpRootPathName := PChar( Drive + ':\' );
      if Windows.GetVolumeInformation( lpRootPathName,
                                       lpVolumeNameBuffer,
                                       nVolumeNameSize,
                                       @lpVolumeSerialNumber,
                                       lpMaximumComponentLength,
                                       lpFileSystemFlags,
                                       lpFileSystemNameBuffer,
                                       nFileSystemNameSize ) then
      begin
      (*
         // to check disk flags do the following
         if (lpFileSystemFlags and FS_CASE_IS_PRESERVED) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_CASE_IS_PRESERVED'
            else
               flags := 'FS_CASE_IS_PRESERVED';

         if (lpFileSystemFlags and FS_CASE_SENSITIVE) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_CASE_SENSITIVE'
            else
               flags := 'FS_CASE_SENSITIVE';

         if (lpFileSystemFlags and FS_UNICODE_STORED_ON_DISK) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_UNICODE_STORED_ON_DISK'
            else
               flags := 'FS_UNICODE_STORED_ON_DISK';

         if (lpFileSystemFlags and FS_PERSISTENT_ACLS) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_PERSISTENT_ACLS'
            else
               flags := 'FS_PERSISTENT_ACLS';

         if (lpFileSystemFlags and FS_FILE_COMPRESSION) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_FILE_COMPRESSION'
            else
               flags := 'FS_FILE_COMPRESSION';

         if (lpFileSystemFlags and FS_VOL_IS_COMPRESSED) <> 0 then
            if Length( flags ) <> 0 then
               flags := flags + #13#10'FS_VOL_IS_COMPRESSED'
            else
               flags := 'FS_VOL_IS_COMPRESSED';
         *)

         with Result do
         begin
            Name               := lpVolumeNameBuffer;
            SerialNumber       := lpVolumeSerialNumber;
            MaxComponentLength := lpMaximumComponentLength;
            FileSystemFlags    := lpFileSystemFlags;
            FileSystemName     := lpFileSystemNameBuffer;
         end; // with Result
      end // if
      else
      begin
         with Result do
         begin
            Name               := '';
            SerialNumber       := 0;
            MaxComponentLength := 0;
            FileSystemFlags    := 0;
            FileSystemName     := '';
         end; // with Result
      end; // else
   finally
      FreeMem( lpVolumeNameBuffer );
      FreeMem( lpFileSystemNameBuffer );
   end; // try
end;

function TtvAPIThing.GetFullPathName( const Path : String ): String;
var
   nBufferLength : DWORD; // size, in characters, of path buffer
   lpBuffer      : PChar; // address of path buffer
   lpFilePart    : PChar; // address of filename in path
begin
   nBufferLength := MAX_PATH + 1;
   GetMem( lpBuffer, MAX_PATH + 1 );
   try
      if Windows.GetFullPathName( PChar( Path ), nBufferLength, lpBuffer, lpFilePart ) <> 0 then
         Result := lpBuffer
      else
         Result := 'ERROR';
   finally
      FreeMem( lpBuffer );
   end;
end;

function TtvAPIThing.myGetLogicalDrives : String;
var
   drives  : set of 0..25;
   drive   : integer;
begin
   Result := '';
   DWORD( drives ) := Windows.GetLogicalDrives;
   for drive := 0 to 25 do
      if drive in drives then
         Result := Result + Chr( drive + Ord( 'A' ));
end;

function TtvAPIThing.FindExecutable( const FileName : String ): String;
var
   lpResult : PChar;  // address of buffer for string for executable file on return
begin
   GetMem( lpResult, MAX_PATH + 1 );
   try
      if ShellAPI.FindExecutable( PChar( FileName ),
                                  PChar( CurrentDirectory ),
                                  lpResult ) > 32 then
         Result := lpResult
      else
         Result := 'ERROR_FILE_NOT_FOUND';
   finally
      FreeMem( lpResult );
   end; // try
end;

function TtvAPIThing.myGetVersion: String;
var
   VersionInfo : TOSVersionInfo;
   OSName      : String;
begin
   // set the size of the record
   VersionInfo.dwOSVersionInfoSize := SizeOf( TOSVersionInfo );

   if Windows.GetVersionEx( VersionInfo ) then
      begin
         with VersionInfo do
         begin
            case dwPlatformId of
               VER_PLATFORM_WIN32s	  : OSName := 'Win32s';
               VER_PLATFORM_WIN32_WINDOWS : OSName := 'Windows 95';
               VER_PLATFORM_WIN32_NT      : OSName := 'Windows NT';
            end; // case dwPlatformId
            Result := OSName + ' Version ' + IntToStr( dwMajorVersion ) + '.' + IntToStr( dwMinorVersion ) +
                      #13#10' (Build ' + IntToStr( dwBuildNumber ) + ': ' + szCSDVersion + ')';
         end; // with VersionInfo
      end // if GetVersionEx
   else
      Result := '';
end;

procedure TtvAPIThing.FormatDrive( const Drive : Char );
var
  wDrive       : WORD;
  dtDrive      : TDriveType;
  strDriveType : String;
begin
   // determine what type of drive is being
   dtDrive := DriveType( Drive );
   // if it's not a HDD or a FDD then raise an exception
   if  ( dtDrive <> dtFloppy ) and ( dtDrive <> dtFixed ) then
      begin
         strDriveType := 'Cannot format a ';
         case dtDrive of
            dtUnknown : strDriveType := 'Cannot determine drive type';
            dtNoDrive : strDriveType := 'Specified drive does not exist';
            dtNetwork : strDriveType := strDriveType + 'Network Drive';
            dtCDROM   : strDriveType := strDriveType + 'CD-ROM Drive';
            dtRAM     : strDriveType := strDriveType + 'RAM Drive';
         end; // case dtDrive

         raise Exception.Create( strDriveType + '.' );
      end // if DriveType
   else // proceed with the format
      begin
         wDrive := Ord( Drive ) - Ord( 'A' );
         // SHFormatDrive is an undocumented API function
         SHFormatDrive( Application.Handle, wDrive, $ffff, 0);
      end; // else
end;

function TtvAPIThing.myGlobalMemoryStatus( const Index : Integer ): DWORD;
var
   MemoryStatus : TMemoryStatus;
begin
   with MemoryStatus do
   begin
      dwLength := SizeOf( TMemoryStatus );
      Windows.GlobalMemoryStatus( MemoryStatus );
      case Index of
         1 : Result := dwMemoryLoad;
         2 : Result := dwTotalPhys     div 1024;
         3 : Result := dwAvailPhys     div 1024;
         4 : Result := dwTotalPageFile div 1024;
         5 : Result := dwAvailPageFile div 1024;
         6 : Result := dwTotalVirtual  div 1024;
         7 : Result := dwAvailVirtual  div 1024;
         else Result := 0;
      end; // case
   end; // with MemoryStatus
end;

function TtvAPIThing.DriveType( const Drive : Char ) : TDriveType;
begin
   Result := TDriveType(GetDriveType(PChar(Drive + ':\')));
end;

procedure TtvAPIThing.ShutDown;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';   // Borland forgot this declaration
var
  hToken       : THandle;
  tkp          : TTokenPrivileges;
  tkpo         : TTokenPrivileges;
  zero         : DWORD;
begin
  if Pos( 'Windows NT', OSVersion ) = 1  then // we've got to do a whole buch of things
     begin
        zero := 0;
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)


        // SE_SHUTDOWN_NAME
        if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[ 0 ].Luid ) then
           begin
              MessageBox( 0, 'Exit Error', 'LookupPrivilegeValue() Failed', MB_OK );
              Exit;
           end; // if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[0].Luid )
        tkp.PrivilegeCount := 1;
        tkp.Privileges[ 0 ].Attributes := SE_PRIVILEGE_ENABLED;

        AdjustTokenPrivileges( hToken, False, tkp, SizeOf( TTokenPrivileges ), tkpo, zero );
        if Boolean( GetLastError() ) then
           begin
              MessageBox( 0, 'Exit Error', 'AdjustTokenPrivileges() Failed', MB_OK );
              Exit;
           end // if Boolean( GetLastError() )
        else
           ExitWindowsEx( EWX_FORCE or EWX_SHUTDOWN, 0 );
      end // if OSVersion = 'Windows NT'
   else
      begin // just shut the machine down
        ExitWindowsEx( EWX_FORCE or EWX_SHUTDOWN, 0 );
      end; // else
end;

function TtvAPIThing.SystemTimeToDateTime(const SystemTime: TSystemTime): TDateTime;
begin
  with SystemTime do
    Result := EncodeDate(wYear, wMonth, wDay) +
      EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
end;

function TtvAPIThing.myGetSystemInfoWORD( const Index : Integer )  : WORD;
var
   SysInfo : TSystemInfo;
begin
   //property wProcessorArchitecture     : WORD index 1 read myGetSystemInfoWORD;
   //property wProcessorLevel            : WORD index 2 read myGetSystemInfoWORD;
   //property wProcessorRevision         : WORD index 3 read myGetSystemInfoWORD;

   Windows.GetSystemInfo( SysInfo );
   with SysInfo do
      case Index of
         1 : Result := wProcessorArchitecture;
         2 : Result := wProcessorLevel;
         3 : Result := wProcessorRevision;
         else Result := null;
      end; // case Index of
end;

function TtvAPIThing.myGetSystemInfoDWORD( const Index : Integer ) : DWORD;
var
   SysInfo : TSystemInfo;
begin
   //property dwPageSize                 : DWORD index 1 read myGetSystemInfoDWORD;
   //property dwActiveProcessorMask      : DWORD index 2 read myGetSystemInfoDWORD;
   //property dwNumberOfProcessors       : DWORD index 3 read myGetSystemInfoDWORD;
   //property dwProcessorType            : DWORD index 4 read myGetSystemInfoDWORD;
   //property dwAllocationGranularity    : DWORD index 5 read myGetSystemInfoDWORD;

   Windows.GetSystemInfo( SysInfo );

   with SysInfo do
      case Index of
         1 : Result := dwPageSize;
         2 : Result := dwActiveProcessorMask;
         3 : Result := dwNumberOfProcessors;
         4 : Result := dwProcessorType;
         5 : Result := dwAllocationGranularity;
         else Result := null;
      end; // case Index of
end;

// Removed for D4
function TtvAPIThing.myGetSystemInfoPtr( const Index : Integer ): Pointer;
var
   SysInfo : TSystemInfo;
begin
   //property lpMinimumApplicationAddress : Pointer index 1 read myGetSystemInfoPtr;
   //property lpMaximumApplicationAddress : Pointer index 2 read myGetSystemInfoPtr;
   Windows.GetSystemInfo( SysInfo );

   with SysInfo do
      case Index of
         1 : Result := lpMinimumApplicationAddress;
         2 : Result := lpMaximumApplicationAddress;
         else Result := nil;
      end; // case Index of
end;

function TtvAPIThing.DisconnectNetworkDrive( const Drive : Char ): Boolean;
var
   sDrive    : String;
   pResource : PChar;
begin
   (*
    WNetCancelConnection2(
    LPTSTR  lpszName,	// address of resource name to disconnect
    DWORD  fdwConnection,	// connection type flags
    BOOL  fForce 	// flag for unconditional disconnect
    );
   *)

   sDrive    := Drive + ':';
   pResource := PChar( sDrive );
   Result    := ( Windows.WNetCancelConnection2( pResource, 0, True ) = NO_ERROR );
end;

function TtvAPIThing.AddNetworkDrive( const Resource : String; const Drive : Char ): Boolean;
var
   sDrive : String;
   pDrive : PChar;
begin
   (*
    DWORD WNetAddConnection(
    LPTSTR  lpszRemoteName,	// address of network device name
    LPTSTR  lpszPassword,	// address of password
    LPTSTR  lpszLocalName 	// address of local device name
   );
   *)
   sDrive := Drive + ':';
   pDrive := PChar( sDrive );
   Result := ( Windows.WNetAddConnection( PChar( Resource ), '', pDrive ) = NO_ERROR );
end;

function TtvAPIThing.GetUniversalName( const Drive : Char ): String;
var
   pResource : PChar;
   lpBuffer  : PUniversalNameInfo;
   dwWDSize  : DWORD;
begin
   (*
     DWORD WNetGetUniversalName(
     LPCTSTR  lpLocalPath,	// address of drive-based path for a network resource
     DWORD  dwInfoLevel,	// specifies form of universal name to be obtained
     LPVOID  lpBuffer,   	// address of buffer that receives universal name data structure
     LPDWORD  lpBufferSize 	// address of variable that specifies size of buffer
     );
   *)
   pResource := PChar( Drive + ':\' );
   dwWDSize  := 1024;
   GetMem( lpBuffer, dwWDSize );
   try
      if WNetGetUniversalName( pResource, UNIVERSAL_NAME_INFO_LEVEL, lpBuffer, dwWDSize ) = NO_ERROR then
         Result := lpBuffer.lpUniversalName
      else
         Result := 'ERROR';
   finally
      FreeMem( lpBuffer );
   end;
end;

procedure Register;
begin
   RegisterComponents( 'Samples', [TtvAPIThing] );
end;

end.

