#define _WIN32_WINNT 0x501

#include "consolelib.h"

#include <stdlib.h>
#include <windows.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <tchar.h>

typedef BOOL (WINAPI *SETCONSOLEDISPLAYMODE)(HANDLE,DWORD,LPDWORD);
typedef BOOL (WINAPI *SETCONSOLEFONT)(HANDLE, DWORD);
typedef BOOL (WINAPI *GETNUMBEROFCONSOLEFONTS)();

SETCONSOLEDISPLAYMODE SetConsoleDisplayMode;
SETCONSOLEFONT SetConsoleFont;
GETNUMBEROFCONSOLEFONTS GetNumberOfConsoleFonts;

typedef struct _structConsoleInfo
{
  HANDLE input;
  HANDLE output;
  HANDLE error;
  HWND wnd;
  FILE* _stdout;
  FILE* _stdin;
} structConsoleInfo;

//----------------------------------------------------------------
// console_Create
//----------------------------------------------------------------
// DESCRIPTION: Создает консольное окно для приложение Windows
//              либо перехватытвает управление для обычного
//              консольного приложения
//----------------------------------------------------------------
// PARMETERS:
//  title         - заголовок консольного окна
//  top, left     - координаты верхнего левого угла
//  width, height - ширина и высота окна
//  maxSize       - создать окна максимального размера для текущего
//                  шрифта (по умолчанию равно false)
//----------------------------------------------------------------
// OUTPUT: дескриптор консольного окна
//         в случае неудачи возвращается NULL
//----------------------------------------------------------------
ConsoleHandle console_Create(const char* title, int top, int left, int width, int height, bool maxSize)
{
  HMODULE hKernel32 = GetModuleHandle("kernel32");
  SetConsoleDisplayMode = (SETCONSOLEDISPLAYMODE)GetProcAddress(hKernel32, "SetConsoleDisplayMode");
  SetConsoleFont = (SETCONSOLEFONT)GetProcAddress(hKernel32, "SetConsoleFont");
  GetNumberOfConsoleFonts = (GETNUMBEROFCONSOLEFONTS)GetProcAddress(hKernel32, "GetNumberOfConsoleFonts");

  FILE* _stdin = NULL;
  FILE* _stdout = NULL;

  if(!GetStdHandle(STD_OUTPUT_HANDLE))
  {
    if(!AllocConsole()) return NULL;
    _stdout = freopen("CONOUT$", "w", stdout);
    _stdin = freopen("CONIN$", "r", stdin);
  }

  SMALL_RECT window;
  COORD size;
  CONSOLE_FONT_INFO font;
  COORD fontSize;
  COORD largest;

  structConsoleInfo* console = (structConsoleInfo *)malloc(sizeof(structConsoleInfo));
  memset(console, 0, sizeof(structConsoleInfo));
  console->input = GetStdHandle(STD_INPUT_HANDLE);
  console->output = GetStdHandle(STD_OUTPUT_HANDLE);
  console->error = GetStdHandle(STD_ERROR_HANDLE);
  console->wnd = GetConsoleWindow();
  console->_stdin = _stdin;
  console->_stdout = _stdout;

  int screenWidth = GetSystemMetrics(SM_CXSCREEN);
  int screenHeight = GetSystemMetrics(SM_CYSCREEN);
  int scrollHeight = GetSystemMetrics(SM_CYVSCROLL);
  int borderWidth = GetSystemMetrics(SM_CXBORDER);
  int borderHeight = GetSystemMetrics(SM_CYBORDER);
  int caption = GetSystemMetrics(SM_CYCAPTION);

  GetCurrentConsoleFont(console->output, FALSE, &font);
  fontSize = GetConsoleFontSize(console->output, font.nFont);
  largest = GetLargestConsoleWindowSize(console->output);

  if(maxSize)
  {
    size.X = (SHORT)((screenWidth - 2*borderWidth + fontSize.X - 1)/fontSize.X);
    size.Y = (SHORT)((screenHeight - 2*borderHeight - caption - scrollHeight + fontSize.Y - 1)/fontSize.Y);
  }
  else
  {
    size.X = (SHORT)width;
    size.Y = (SHORT)height;
  }
  
  if(size.X < font.dwFontSize.X) size.X = font.dwFontSize.X;
  if(size.Y < font.dwFontSize.Y) size.Y = font.dwFontSize.Y;
  if(size.X > largest.X) size.X = largest.X;
  if(size.Y > largest.Y) size.Y = largest.Y;
  window.Top = (SHORT)top;
  window.Left = (SHORT)left;
  window.Right = (SHORT)(left + size.X);
  window.Bottom = (SHORT)(top + size.Y);

  if(title)
    if(strlen(title) > 1) SetConsoleTitle(title);

  SetConsoleActiveScreenBuffer(console->output);
  SetConsoleDisplayMode(console->output, 2, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->output, size);
  SetConsoleWindowInfo(console->output, TRUE, &window);
/*
  SetConsoleActiveScreenBuffer(console->input);
  SetConsoleDisplayMode(console->input, FALSE, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->input, size);
  SetConsoleWindowInfo(console->input, TRUE, &window);

  SetConsoleActiveScreenBuffer(console->error);
  SetConsoleDisplayMode(console->error, FALSE, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->error, size);
  SetConsoleWindowInfo(console->error, TRUE, &window);

  SetConsoleActiveScreenBuffer(console->input);
*/
  if(maxSize)
  {
    ShowWindow(console->wnd, SW_MAXIMIZE);
  }
  return console;
}

//----------------------------------------------------------------
// console_Free
//----------------------------------------------------------------
// DESCRIPTION: Удалить консольное окно
//----------------------------------------------------------------
// PARMETERS:
//----------------------------------------------------------------
// OUTPUT:
//----------------------------------------------------------------
void console_Free(ConsoleHandle handle)
{
  if(!handle) return;
  structConsoleInfo* console = (structConsoleInfo *)handle;
  if(console->_stdin) fclose(console->_stdin);
  if(console->_stdout) fclose(console->_stdout);
  free(console);
  FreeConsole();
}

//----------------------------------------------------------------
// console_GetMaxFontsCount
//----------------------------------------------------------------
// DESCRIPTION: Определить максимальное количество шрифтов,
//              доступных консольному окну
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//----------------------------------------------------------------
// OUTPUT: Максимальное колличество шрифтов, в случае ошибки
//         возвращает -1
//----------------------------------------------------------------
int console_GetMaxFontsCount(ConsoleHandle handle)
{
  if(!handle) return -1;

  int maxFonts = GetNumberOfConsoleFonts();
  return maxFonts;
}

//----------------------------------------------------------------
// console_GetCurrentFont
//----------------------------------------------------------------
// DESCRIPTION: Определить текущий шрифт для консольного окна
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//----------------------------------------------------------------
// OUTPUT: Индекс текущего шрифта, в случае ошибки возвращает -1
//----------------------------------------------------------------
int console_GetCurrentFont(ConsoleHandle handle)
{
  if(!handle) return -1;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  CONSOLE_FONT_INFO font;
  GetCurrentConsoleFont(console->output, FALSE, &font);
  return font.nFont;
}

//----------------------------------------------------------------
// console_SetFont
//----------------------------------------------------------------
// DESCRIPTION: Установить текущий шрифт
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//  font   - индекс нового шрифта, который должен находиться в
//           пределах от 0 до числа, возвращаемого функцией
//           console_GetMaxFontsCount
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_SetFont(ConsoleHandle handle, int font)
{
  if(!handle) return false;
  if(font < 0) return false;
  structConsoleInfo* console = (structConsoleInfo *)handle;

  int maxFonts = GetNumberOfConsoleFonts();
  if(font >= maxFonts) return false;

  SetConsoleFont(console->output, font);
  return true;
}

//----------------------------------------------------------------
// console_ToMaxSize
//----------------------------------------------------------------
// DESCRIPTION: Установить размеры консольного окна, чтобы оно
//              занимало весь экран при текущем шрифте
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_ToMaxSize(ConsoleHandle handle)
{
  if(!handle) return false;
  
  structConsoleInfo* console = (structConsoleInfo *)handle;
  SMALL_RECT window;
  COORD size;
  CONSOLE_FONT_INFO font;
  COORD fontSize;
  COORD largest;

  int screenWidth = GetSystemMetrics(SM_CXSCREEN);
  int screenHeight = GetSystemMetrics(SM_CYSCREEN);
  int scrollHeight = GetSystemMetrics(SM_CYVSCROLL);
  int borderWidth = GetSystemMetrics(SM_CXBORDER);
  int borderHeight = GetSystemMetrics(SM_CYBORDER);
  int caption = GetSystemMetrics(SM_CYCAPTION);
  GetCurrentConsoleFont(console->output, FALSE, &font);
  fontSize = GetConsoleFontSize(console->output, font.nFont);
  largest = GetLargestConsoleWindowSize(console->output);

  size.X = (SHORT)((screenWidth - 2*borderWidth + fontSize.X - 1)/fontSize.X);
  size.Y = (SHORT)((screenHeight - 2*borderHeight - caption - scrollHeight + fontSize.Y - 1)/fontSize.Y);
  if(size.X > largest.X) size.X = largest.X;
  if(size.Y > largest.Y) size.Y = largest.Y;
  
  window.Top = 0;
  window.Left = 0;
  window.Right = size.X;
  window.Bottom = size.Y;

  SetConsoleActiveScreenBuffer(console->output);
  SetConsoleWindowInfo(console->output, TRUE, &window);
  SetConsoleScreenBufferSize(console->output, size);
  SetConsoleDisplayMode(console->output, FALSE, (LPDWORD)&size);

  SetConsoleActiveScreenBuffer(console->input);
  SetConsoleWindowInfo(console->input, TRUE, &window);
  SetConsoleScreenBufferSize(console->input, size);
  SetConsoleDisplayMode(console->input, FALSE, (LPDWORD)&size);

  SetConsoleActiveScreenBuffer(console->error);
  SetConsoleWindowInfo(console->error, TRUE, &window);
  SetConsoleScreenBufferSize(console->error, size);
  SetConsoleDisplayMode(console->error, FALSE, (LPDWORD)&size);

  SetConsoleActiveScreenBuffer(console->output);
  ShowWindow(console->wnd, SW_MAXIMIZE);
  return true;
}

//----------------------------------------------------------------
// console_SetTextColor
//----------------------------------------------------------------
// DESCRIPTION: Установить цвет текста
//----------------------------------------------------------------
// PARMETERS:
//  handle           - дескриптор консольного окна
//  red, green, blue - включить красную, зеленую, синюю составляющие
//  intensity        - увеличить яркость
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_SetTextColor(ConsoleHandle handle, int red, int green, int blue, int intensity)
{
  if(!handle) return false;
  structConsoleInfo* console = (structConsoleInfo *)handle;

  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(console->output, &info);
  info.wAttributes = info.wAttributes & (~(FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY));
  if(red) info.wAttributes |= FOREGROUND_RED;
  if(green) info.wAttributes |= FOREGROUND_GREEN;
  if(blue) info.wAttributes |= FOREGROUND_BLUE;
  if(intensity) info.wAttributes |= FOREGROUND_INTENSITY;
  SetConsoleTextAttribute(console->output, info.wAttributes);
  return true;
}

//----------------------------------------------------------------
// console_SetBackgroundColor
//----------------------------------------------------------------
// DESCRIPTION: Установить цвет фона
//----------------------------------------------------------------
// PARMETERS:
//  handle           - дескриптор консольного окна
//  red, green, blue - включить красную, зеленую, синюю составляющие
//  intensity        - увеличить яркость
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_SetBackgroundColor(ConsoleHandle handle, int red, int green, int blue, int intensity)
{
  if(!handle) return false;
  structConsoleInfo* console = (structConsoleInfo *)handle;

  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(console->output, &info);
  info.wAttributes = info.wAttributes & (~(BACKGROUND_BLUE | BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_INTENSITY));
  if(red) info.wAttributes |= BACKGROUND_RED;
  if(green) info.wAttributes |= BACKGROUND_GREEN;
  if(blue) info.wAttributes |= BACKGROUND_BLUE;
  if(intensity) info.wAttributes |= BACKGROUND_INTENSITY;
  SetConsoleTextAttribute(console->output, info.wAttributes);
  return true;
}

//----------------------------------------------------------------
// console_Resize
//----------------------------------------------------------------
// DESCRIPTION: Установить новые размеры консольного окна
//----------------------------------------------------------------
// PARMETERS:
//  handle        - дескриптор консольного окна
//  width, height - новые размеры окна
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_Resize(ConsoleHandle handle, int width, int height)
{
  if(!handle) return false;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  SMALL_RECT window;
  COORD size;
  CONSOLE_SCREEN_BUFFER_INFO info;

  GetConsoleScreenBufferInfo(console->output, &info);
  window.Top = info.srWindow.Top;
  window.Left = info.srWindow.Left;
  window.Right = (SHORT)(window.Left + width);
  window.Bottom = (SHORT)(window.Top + height);
  size.X = (SHORT)width;
  size.Y = (SHORT)height;

  SetConsoleActiveScreenBuffer(console->output);
  SetConsoleDisplayMode(console->output, FALSE, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->output, size);
  SetConsoleWindowInfo(console->output, TRUE, &window);

  SetConsoleActiveScreenBuffer(console->input);
  SetConsoleDisplayMode(console->input, FALSE, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->input, size);
  SetConsoleWindowInfo(console->input, TRUE, &window);

  SetConsoleActiveScreenBuffer(console->error);
  SetConsoleDisplayMode(console->error, FALSE, (LPDWORD)&size);
  SetConsoleScreenBufferSize(console->error, size);
  SetConsoleWindowInfo(console->error, TRUE, &window);

  SetConsoleActiveScreenBuffer(console->output);
  return true;
}

//----------------------------------------------------------------
// console_GetWidth
//----------------------------------------------------------------
// DESCRIPTION: Получить ширину текущего консольного окна
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//----------------------------------------------------------------
// OUTPUT: ширина текущего консольного окна
//----------------------------------------------------------------
int console_GetWidth(ConsoleHandle handle)
{
  if(!handle) return 0;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(console->output, &info);

  return info.dwSize.X;
}

//----------------------------------------------------------------
// console_GetHeight
//----------------------------------------------------------------
// DESCRIPTION: Получить высоту текущего консольного окна
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//----------------------------------------------------------------
// OUTPUT: высота текущего консольного окна
//----------------------------------------------------------------
int console_GetHeight(ConsoleHandle handle)
{
  if(!handle) return 0;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(console->output, &info);

  return info.dwSize.Y;
}

//----------------------------------------------------------------
// console_SetTitle
//----------------------------------------------------------------
// DESCRIPTION: Установить заголовок консоли
//----------------------------------------------------------------
// PARMETERS:
//  handle - дескриптор консольного окна
//  title  - новый заголовок
//----------------------------------------------------------------
// OUTPUT: true - в случае успеха и false, если произошла ошибка
//----------------------------------------------------------------
bool console_SetTitle(ConsoleHandle handle, const char* title)
{
  if(!handle) return false;

  SetConsoleTitle(title);
  return true;
}

//----------------------------------------------------------------
bool console_Print(ConsoleHandle handle, const char* msg, ...)
{
  if(!handle) return false;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  SetConsoleActiveScreenBuffer(console->output);
  char tempStr[1024];
  int result;

  CONSOLE_SCREEN_BUFFER_INFO info;

  GetConsoleScreenBufferInfo(console->output, &info);

	va_list argList;
	va_start(argList, msg);
	vsprintf(tempStr, msg, argList);
	va_end(argList);

  BOOL final = WriteConsole(console->output, _T(tempStr), (DWORD)strlen(tempStr), (LPDWORD)&result, NULL);

  if(!final) return false;
  if(result != (int)strlen(tempStr)) return false;

  return true;
}

//----------------------------------------------------------------
bool console_Scan(ConsoleHandle handle, const char* msg, ...)
{
  if(!handle) return false;

  structConsoleInfo* console = (structConsoleInfo *)handle;
  char buffer[1024];
  char tempStr[1024];
  char param[16];
  int result;

  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(console->output, &info);
  strcpy(buffer, msg);

	va_list argList;
	va_start(argList, msg);
  char* p = strstr(buffer, "%");
  char* message = (char *)buffer;
  while(p != NULL)
  {
    *p = 0;
    WriteConsole(console->output, _T(message), (DWORD)(p-message), (LPDWORD)&result, NULL);
    *p = '%';

    BOOL final = ReadConsole(console->input, tempStr, info.dwSize.X, (LPDWORD)&result, NULL);
    if(!final) return false;
    tempStr[result] = 0;
    void* arg = va_arg(argList, void *);
    char* space = strstr(p, " ");
    if(!space) space = strstr(p, "\t");
    if(!space) space = strstr(p, "\n");
    if(!space) space = p + strlen(p);
    int len = (int)(space - p);
    strncpy(param, p, len);
    param[len] = 0;
    sscanf(tempStr, param, arg);
    p = strstr(space, "%");
    message = space;
  }
	va_end(argList);

  return true;
}


void console_GetClassName(ConsoleHandle handle, char* name)
{
  if(!handle) return;
  
  structConsoleInfo* console = (structConsoleInfo *)handle;
  GetClassName(console->wnd, name, 1024);
}

