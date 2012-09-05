#define PVERS "1.00"
#define PDATE "31 August, 2004"


#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


void help( const char* );


HANDLE con;
CONSOLE_SCREEN_BUFFER_INFO csbi;
COORD cur_win, max_win;

void buf_size( SHORT, SHORT );
void win_size( SHORT, SHORT );
void font_size( void );
void win_pos( void );


// Undocumented console font functions.

// Console font structure.
typedef struct _CONSOLE_FONT {
  DWORD index;			// Index into list of fonts
  COORD dim;			// Window dimensions
} CONSOLE_FONT, *PCONSOLE_FONT;

typedef BOOL  (WINAPI *GetConsoleFontInfoT)( HANDLE,BOOL,DWORD,PCONSOLE_FONT );
typedef COORD (WINAPI *GetConsoleFontSizeT)( HANDLE, DWORD );
typedef BOOL  (WINAPI *GetCurrentConsoleFontT)( HANDLE, BOOL, PCONSOLE_FONT );
typedef DWORD (WINAPI *GetNumberOfConsoleFontsT)( VOID );
typedef BOOL  (WINAPI *SetConsoleFontT)( HANDLE, DWORD );

GetConsoleFontInfoT	 GetConsoleFontInfo;
GetConsoleFontSizeT	 GetConsoleFontSize;
GetCurrentConsoleFontT	 GetCurrentConsoleFont;
GetNumberOfConsoleFontsT GetNumberOfConsoleFonts;
SetConsoleFontT 	 SetConsoleFont;

// End console font functions.


#define MAX_FONTS 40

CONSOLE_FONT cur_font;

BOOL InitConsoleFont( VOID );


struct
{
  COORD buf;			// Buffer size
  COORD win;			// Window size
  COORD font;			// Font size
  BOOL	quiet;			// Prevent display
  BOOL	a;			// Set both buffer & window sizes
  BOOL	b;			// Set buffer size
  BOOL	w;			// Set window size
  int	f;			// Set font size
  int	p;			// Set position
} option;

// Bitmasks of values to display.
#define WIN_COLS  0x001 	// [-w] -c [-m]
#define WIN_ROWS  0x002 	// [-w] -r [-m]
#define BUF_COLS  0x004 	// -b -c
#define BUF_ROWS  0x008 	// -b -r
#define FONT_WID  0x010 	// -f -c
#define FONT_HYT  0x020 	// -f -r
#define WIN	  0x040 	// -w
#define BUF	  0x080 	// -b
#define MAX	  0x100 	// -m
#define FONT	  0x200 	// -f

#define ALL_DIM   0x03f 	// all dimensions


// Return codes.
#define E_OK	   0		// no problem
#define E_OPTION  -1		// problem with option, unknown option
#define E_CONSOLE -2		// invalid parameters to console function
#define E_SYSTEM  -3		// problem accessing console functions


int main( int argc, char* argv[] )
{
  char	 opt;
  COORD* size = &option.win;
  SHORT  num;
  char*  end;
  int	 j, k;
  int	 display = 0;
  int	 rc = E_OK;

  if (argc == 1)
    help( argv[0] );

  con = GetStdHandle( STD_ERROR_HANDLE );
  if (!GetConsoleScreenBufferInfo( con, &csbi ))
  {
    fputs( "Unable to retrieve console information.\n", stderr );
    return E_SYSTEM;
  }
  max_win = GetLargestConsoleWindowSize( con );
  cur_win.X = csbi.srWindow.Right - csbi.srWindow.Left + 1;
  cur_win.Y = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;

  for (j = 1; j < argc; ++j)
  {
    for (k = 0; argv[j][k]; )
    {
      opt = argv[j][k++];
      if ((opt == '/' || opt == '-')  &&  argv[j][k] != '\0')
	opt = argv[j][k++];
      if (opt == '?')
	help( argv[0] );
      if (isdigit( opt ))
	opt = 'c', --k;
      else
	opt = tolower( opt );
      num = -1;
      if (opt == 'c' || opt == 'r' || opt == 'x' || opt == 'p' || opt == ',')
      {
	if (argv[j][k] == '\0'  &&  argv[j+1] != NULL  &&  opt != ',')
	  ++j, k = 0;
	if (isdigit( argv[j][k] ))
	{
	  num = strtol( argv[j] + k, &end, 10 );
	  k = end - argv[j];
	}
      }
      switch (opt)
      {
	case 'a':
	  if (display & MAX)
	  {
	    option.buf.X = max_win.X;
	    option.buf.Y = max_win.Y;
	    display &= ~MAX;
	  }
	  size = &option.buf;
	  display |= BUF | WIN;
	  rc = *(int*)&csbi.dwSize;
	  option.a = TRUE;
	break;

	case 'b':
	  if (display & MAX)
	  {
	    option.buf.X = max_win.X;
	    option.buf.Y = max_win.Y;
	    display &= ~MAX;
	  }
	  size = &option.buf;
	  display |= BUF;
	  rc = *(int*)&csbi.dwSize;
	  option.b = TRUE;
	break;

	case 'w':
	  if (display & MAX)
	  {
	    option.win.X = max_win.X;
	    option.win.Y = max_win.Y;
	    display &= ~MAX;
	  }
	  size = &option.win;
	  display |= WIN;
	  rc = *(int*)&cur_win;
	  option.w = TRUE;
	break;

	case 'm':
	  display |= MAX;
	  rc = *(int*)&max_win;
	break;

	case 'f':
	  if (display & MAX)
	  {
	    fputs( "Font cannot be maximized.\n", stderr );
	    return E_OPTION;
	  }
	  if (!option.f && !InitConsoleFont())
	  {
	    fputs( "Console font functions not available.\n", stderr );
	    return E_SYSTEM;
	  }
	  size = &option.font;
	  display |= FONT;
	  rc = *(int*)&cur_font.dim;
	  option.f = 1;
	break;

	case ',':
	  if (num <= 0)
	    ++option.f;
	  else
	    option.f = num;
	break;

	case 'c':
	  if (display & MAX)
	  {
	    size->X = max_win.X;
	    display &= ~MAX;
	  }
	  else if (num < 0)
	  {
	    if (size == &option.buf)
	    {
	      display |= BUF_COLS;
	      rc = csbi.dwSize.X;
	    }
	    else if (size == &option.win)
	    {
	      display |= WIN_COLS;
	      rc = cur_win.X;
	    }
	    else
	    {
	      display |= FONT_WID;
	      rc = cur_font.dim.X;
	    }
	  }
	  else if (!option.a && !option.b && !option.w && !option.f)
	  {
	    option.buf.X = option.win.X = num;
	  }
	  else
	  {
	    size->X = num;
	  }
	break;

	case 'x':
	case 'r':
	  if (display & MAX)
	  {
	    size->Y = max_win.Y;
	    display &= ~MAX;
	  }
	  else if (num < 0)
	  {
	    if (size == &option.buf)
	    {
	      display |= BUF_ROWS;
	      rc = csbi.dwSize.Y;
	    }
	    else if (size == &option.win)
	    {
	      display |= WIN_ROWS;
	      rc = cur_win.Y;
	    }
	    else
	    {
	      display |= FONT_HYT;
	      rc = cur_font.dim.Y;
	    }
	  }
	  else
	  {
	    size->Y = num;
	  }
	break;

	case 'p':
	  if (num < 0) num = 0;
	  option.p = num + 1;
	break;

	case 'q':
	  option.quiet = TRUE;
	break;

	default:
	  fprintf( stderr, "Unknown option: %c\n", opt );
	return E_OPTION;
      }
    }
  }

  if (!option.buf.X  && !option.buf.Y  &&
      !option.win.X  && !option.win.Y  &&
      !option.font.X && !option.font.Y && !option.p)
  {
    if (!option.quiet)
    {
      if ((display & ALL_DIM) == 0)
      {
	if (display & BUF)
	{
	  printf( "Buffer: %d x %d\n", csbi.dwSize.X, csbi.dwSize.Y );
	}
	if (display & WIN)
	{
	  printf( "Window: %d x %d\n", cur_win.X, cur_win.Y );
	}
	if (display & MAX)
	{
	  printf( "Largest%s: %d x %d\n", (display & WIN) ? "" : " window",
					  max_win.X, max_win.Y );
	}
	if (display & FONT)
	{
	  printf( "Font: %d x %d\n", cur_font.dim.X, cur_font.dim.Y );
	}
      }
      else
      {
	if (display & BUF_COLS)
	{
	  printf( "Buffer: %d columns\n", csbi.dwSize.X );
	}
	if (display & BUF_ROWS)
	{
	  printf( "Buffer: %d rows\n", csbi.dwSize.Y );
	}
	if (display & WIN_COLS)
	{
	  if (display & MAX)
	    printf( "Largest window: %d columns\n", max_win.X );
	  else
	    printf( "Window: %d columns\n", cur_win.X );
	}
	if (display & WIN_ROWS)
	{
	  if (display & MAX)
	    printf( "Largest window: %d rows\n", max_win.Y );
	  else
	    printf( "Window: %d rows\n", cur_win.Y );
	}
	if (display & FONT_WID)
	{
	  printf( "Font: %d pixels wide\n", cur_font.dim.X );
	}
	if (display & FONT_HYT)
	{
	  printf( "Font: %d pixels high\n", cur_font.dim.Y );
	}
      }
    }
    return rc;
  }

  if (option.f	&&  !option.buf.X && !option.buf.Y
		&&  !option.win.X && !option.win.Y)
  {
    max_win = cur_win;
    font_size();
    if (max_win.X != cur_win.X	||  max_win.Y != cur_win.Y)
    {
      if (max_win.X != cur_win.X)
      {
	if (max_win.Y != cur_win.Y)
	{
	  option.quiet ||
	  fprintf(stderr, "Window reduced to %d x %d.\n", cur_win.X,cur_win.Y);
	  rc = *(int*)&cur_win;
	}
	else
	{
	  option.quiet ||
	  fprintf( stderr, "Window reduced to %d columns.\n", cur_win.X );
	  rc = cur_win.X;
	}
      }
      else
      {
	option.quiet ||
	fprintf( stderr, "Window reduced to %d rows.\n", cur_win.Y );
	rc = cur_win.Y;
      }
    }
  }

  if (option.buf.X == 0) option.buf.X = csbi.dwSize.X;
  if (option.buf.Y == 0) option.buf.Y = csbi.dwSize.Y;
  if (option.win.X == 0) option.win.X = (option.a) ? option.buf.X : cur_win.X;
  if (option.win.Y == 0) option.win.Y = (option.a) ? option.buf.Y : cur_win.Y;

  // Resize the buffer to at least fit the window.
  if (option.win.X > option.buf.X) option.buf.X = option.win.X;
  if (option.win.Y > option.buf.Y) option.buf.Y = option.win.Y;

  if (option.f)
  {
    font_size();
  }
  else if (option.win.X > max_win.X)
  {
    if (option.win.Y > max_win.Y)
      fprintf( stderr, "Window too big: %d x %d (max. %d x %d)\n",
		       option.win.X, option.win.Y, max_win.X, max_win.Y );
    else
      fprintf( stderr, "Window too wide: %d (max. %d)\n",
		       option.win.X, max_win.X );
    return E_OPTION;
  }
  else if (option.win.Y > max_win.Y)
  {
    fprintf( stderr, "Window too high: %d (max. %d)\n",
		     option.win.Y, max_win.Y );
    return E_OPTION;
  }

  // Resizing needs to be done in a particular order, since the buffer
  // cannot be made smaller than the window, and the window cannot be
  // made bigger than the buffer.
  if (option.buf.X < cur_win.X)
  {
    win_size( option.win.X, cur_win.Y );
    cur_win.X = option.win.X;
  }
  if (option.buf.Y < cur_win.Y)
  {
    win_size( cur_win.X, option.win.Y );
  }
  buf_size( option.buf.X, option.buf.Y );
  win_size( option.win.X, option.win.Y );

  win_pos();

  return E_OK;
}


void buf_size( SHORT x, SHORT y )
{
  COORD size;

  if (x == csbi.dwSize.X  &&  y == csbi.dwSize.Y)
    return;

  size.X = x;
  size.Y = y;
  if (!SetConsoleScreenBufferSize( con, size ))
  {
    fprintf( stderr, "Unable to set buffer size: %d x %d.\n", x, y );
    exit( E_CONSOLE );
  }
}


void win_size( SHORT x, SHORT y )
{
  SMALL_RECT win;

  if (x == cur_win.X  &&  y == cur_win.Y)
    return;

  win.Left   = 0;
  win.Top    = 0;
  win.Right  = x - cur_win.X;
  win.Bottom = y - cur_win.Y;
  if (!SetConsoleWindowInfo( con, FALSE, &win ))
  {
    fprintf( stderr, "Unable to set console window: %d x %d.\n", x, y );
    exit( E_CONSOLE );
  }
}


void font_size( void )
{
  CONSOLE_FONT font[MAX_FONTS];
  DWORD fonts;
  int	fnt = -1, d, d1;
  int	j;

  fonts = GetNumberOfConsoleFonts();
  if (fonts > MAX_FONTS)
    fonts = MAX_FONTS;

  // These don't appear to fail.
  GetConsoleFontInfo( con, 0, fonts, font );
  for (j = fonts; --j >= 0;)
    font[j].dim = GetConsoleFontSize( con, font[j].index );

  // Find the largest font capable of displaying the window.
  if (option.font.X == 0  &&  option.font.Y == 0)
  {
    RECT desktop;
    GetWindowRect( GetDesktopWindow(), &desktop );
    desktop.bottom -= GetSystemMetrics( SM_CYCAPTION );
    for (j = fonts; --j >= 0;)
    {
      desktop.left = desktop.right / font[j].dim.X;
      desktop.top = desktop.bottom / font[j].dim.Y;
      if (option.win.X <= desktop.left	&&  option.win.Y <= desktop.top)
      {
	fnt = j;
	break;
      }
    }
  }
  else
  {
    d = 255;
    // Find a font of a particular height, closest to the current width.
    if (option.font.X == 0)
    {
      for (j = 0; j < fonts; ++j)
      {
	if (font[j].dim.Y == option.font.Y)
	{
	  d1 = font[j].dim.X - cur_font.dim.X;
	  if (d1 < 0) d1 = -d1;
	  if (d1 < d)
	  {
	    fnt = j;
	    if (d1 == 0)
	      break;
	    d = d1;
	  }
	}
      }
    }
    else
    {
      for (j = 0; j < fonts; ++j)
      {
	if (font[j].dim.X == option.font.X)
	{
	  // Find a font of a particular width, closest to the current height.
	  if (option.font.Y == 0)
	  {
	    d1 = font[j].dim.Y - cur_font.dim.Y;
	    if (d1 < 0) d1 = -d1;
	    if (d1 < d)
	    {
	      fnt = j;
	      if (d1 == 0)
		break;
	      d = d1;
	    }
	  }
	  // Find an exact font size.
	  else if (font[j].dim.Y == option.font.Y)
	  {
	    fnt = j;
	    break;
	  }
	}
      }
    }
  }

  if (fnt < 0)
  {
    fputs( "Unable to find font ", stderr );
    if (option.font.X == 0  &&	option.font.Y == 0)
      fprintf( stderr, "to fit the window %d x %d on screen.\n",
		       option.win.X, option.win.Y );
    else if (option.font.X == 0)
      fprintf( stderr, "of height %d.\n", option.font.Y );
    else if (option.font.Y == 0)
      fprintf( stderr, "of width %d.\n", option.font.X );
    else
      fprintf( stderr, "%d x %d.\n", option.font.X, option.font.Y );
    exit( E_OPTION );
  }

  for (j = option.f; j > 1; --j)
  {
    if (fnt+1 < fonts  &&
	font[fnt+1].dim.X == font[fnt].dim.X  &&
	font[fnt+1].dim.Y == font[fnt].dim.Y)
      ++fnt;
  }

  if (font[fnt].index == cur_font.index)
    return;

  if (!SetConsoleFont( con, font[fnt].index ))
  {
    fprintf( stderr, "Unable to set font: %d x %d.\n",
		     font[fnt].dim.X, font[fnt].dim.Y );
    exit( E_CONSOLE );
  }

  // Setting a larger font may reduce the size of the window.
  CONSOLE_SCREEN_BUFFER_INFO csbi;
  GetConsoleScreenBufferInfo( con, &csbi );
  cur_win.X = csbi.srWindow.Right - csbi.srWindow.Left + 1;
  cur_win.Y = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
}


// Reposition the window to keep it on-screen, or at a specific location.
void win_pos( void )
{
  RECT desktop, window;
  HWND win;
  BOOL move = FALSE;

  GetWindowRect( GetDesktopWindow(), &desktop );
  win = GetForegroundWindow();
  // Needs a bit of time to resize.
  Sleep( 10 );
  GetWindowRect( win, &window );
  if (option.p)
  {
    int top, left, wid, hyt;

    wid = window.right - window.left;
    hyt = window.bottom - window.top;
    left = desktop.right - wid;
    top  = desktop.bottom - hyt;
    if (option.p == 1)
    {
      // Center the actual screen, not the window.
      window.left = left;
      window.top  = top - GetSystemMetrics( SM_CYCAPTION );
      if (option.buf.Y > option.win.Y)
	window.left += GetSystemMetrics( SM_CXVSCROLL );
      if (option.buf.X > option.win.X)
	window.top += GetSystemMetrics( SM_CYHSCROLL );
      window.left /= 2;
      window.top  /= 2;
    }
    else
    {
      window.left = (option.p & 1) ? left : 0;
      window.top  = (option.p & 2) ? 0 : top;
    }
    window.right = window.left + wid;
    window.bottom = window.top + hyt;
    move = TRUE;
  }
  // If the new size has gone off-screen, bring it back.
  if (window.right > desktop.right  ||	window.bottom > desktop.bottom)
  {
    if (window.right > desktop.right)
    {
      window.left -= window.right - desktop.right;
      if (window.left < 0)
	window.left = -GetSystemMetrics( SM_CXFRAME ) - 2; // SM_CXBORDER * 2 ?
    }
    if (window.bottom > desktop.bottom)
      window.top -= window.bottom - desktop.bottom;
    move = TRUE;
  }
  if (move)
    SetWindowPos( win, 0, window.left, window.top, 0, 0,
		  SWP_NOSIZE | SWP_NOZORDER );
}


/*
  Undocumented console font functions.

  These functions are only available under NT (only tested in XP, though).
  The definitions below are pretty self-explanatory, with two exceptions:

  1. The window size is based on the current buffer size (cf.
     GetConsoleScreenBuffer), not the actual maximum window size (cf.
     GetLargestConsoleWindowSize).
  2. It appears the TrueType fonts are only indexed after being used. To be
     able to select a different TrueType font, it is still necessary to go
     through the Properties once. The font (and its bold/normal counterpart)
     are then inserted into the list, potentially changing the order of the
     current fonts.
*/

#if 0

// Retrieve a list of available console fonts.
// Returns 0 for failure, nonzero for success.
BOOL GetConsoleFontInfo(
  HANDLE hConsoleOutput,	// handle of console screen buffer
  BOOL	 bMax,			// FALSE for current window size, TRUE for max.
  DWORD  nSize, 		// size of array
  PCONSOLE_FONT lpConsoleFont	// pointer to array to receive font info
);

// Determine the current font used by the console.
// Returns 0 for failure, nonzero for success.
BOOL GetCurrentConsoleFont(
  HANDLE hConsoleOutput,	// handle of console screen buffer
  BOOL	 bMax,			// FALSE for current window size, TRUE for max.
  PCONSOLE_FONT lpConsoleFont	// pointer to structure to receive font
);

// Retrieve the size of a console font.
// Returns the width and height of the font, in pixels.
COORD WINAPI GetConsoleFontSize(
  HANDLE hConsoleOutput,	// handle of console screen buffer
  DWORD  dwIndex		// font index fron lpConsoleFont
);

// Determine the number of available console fonts.
DWORD GetNumberOfConsoleFonts( VOID );

// Set the console font.
// Returns 0 for failure, nonzero for success.
BOOL SetConsoleFont(
  HANDLE hConsoleOutput,	// handle of console screen buffer
  DWORD  dwIndex		// font index fron lpConsoleFont
}

#endif

// Get the functions and the current font.
BOOL InitConsoleFont( VOID )
{
  HINSTANCE hLib;
  BOOL	    ok;

  hLib = LoadLibrary( "KERNEL32.DLL" );
  if (hLib == NULL)
    return FALSE;

  ok = TRUE;

  #define GetProc( proc ) \
    do { \
      proc = (proc##T)GetProcAddress( hLib, #proc ); \
      if (proc == NULL) \
      { \
	ok = FALSE; \
	goto done; \
      } \
    } while (0)

  GetProc( GetConsoleFontInfo );
  GetProc( GetConsoleFontSize );
  GetProc( GetCurrentConsoleFont );
  GetProc( GetNumberOfConsoleFonts );
  GetProc( SetConsoleFont );

  #undef GetProc

  if (!GetCurrentConsoleFont( con, 0, &cur_font ))
  {
    // Redirected stderr?
    cur_font.dim.X = cur_font.dim.Y = 1;
  }
  else
  {
    cur_font.dim = GetConsoleFontSize( con, cur_font.index );
  }

done:
  FreeLibrary( hLib );

  return ok;
}


void help( const char* prog )
{
  int len = -1;
  while (prog[++len]) ;

  printf(

"Console Size by Jason Hood <jadoxa@yahoo.com.au>.\n"
"Version "PVERS" ("PDATE"). Public Domain.\n"
"http://misc.adoxa.cjb.net/\n"
"\n"
"Display or change the sizes of the console buffer, window and font.\n"
"\n"
"Usage: %s [-a|b|w|f] [<cols>][x<rows>] [-c[<cols>]] [-r[<rows>]]\n"
"       %*c [-p[<n>]] [-q]\n"
"\n"
"cols  width of the buffer/window/font\n"
"rows  height of the buffer/window/font\n"
"-a    apply to buffer and window\n"
"-b    apply to buffer\n"
"-w    apply to window\n"
"-m    maximum window size (see below)\n"
"-f    apply to font; automatically select font (see below)\n"
"-p    position the window (see below)\n"
"-q    prevent output of messages (error messages are still displayed)\n"
"\n"
"* By default, columns will apply to both the buffer and window,\n"
"  but rows will only apply to the window.\n"
"* Buffer size will always be made to fit the window (eg: if the\n"
"  current window size is 80, \"-b40\" will have no affect).\n"
"* If no values are given, the current values will be displayed;\n"
"  Errorlevel is set to the last specified.\n"
"* Prefixed 'm' will select the maximum window columns/rows;\n"
"  suffixed 'm' will display it (\"-cmc\" is regarded as prefix).\n"
"* TrueType fonts must first be selected in \"Properties\" before being\n"
"  available via -f; add ',' to select it instead of the raster\n"
"  (eg: \"-f 8x12\" for raster; \"-f 8x12,\" for TrueType, once available).\n"
"* <n> is 0 for the middle of the screen (default);\n"
"         1 for the top-left corner;\n"
"         2 for the top-right corner;\n"
"         3 for the bottom-left corner;\n"
"         4 for the bottom-right corner.\n"

  , prog, len, ' ' );

  exit( E_OK );
}

