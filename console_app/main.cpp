#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <conio.h>

#define _CONSOLE

#include "consolelib.h"
static void toLowerCase(char* str)
{
  if(!str) return;
  char* p = str;
  while(*p)
  {
    if((*p >= 'A') && (*p <= 'Z')) *p -= 'A' - 'a';
    p++;
  }
}

#define MAX_COMMANDS  8
#define CMD_UNKNOWN     -1
#define CMD_EXIT        0
#define CMD_SETFONT     1
#define CMD_SETSIZE     2
#define CMD_MAXIMIZE    3
#define CMD_HELP        4
#define CMD_TITLE       5
#define CMD_TEXTCOLOR   6
#define CMD_BACKCOLOR   7

const char cmd_list[MAX_COMMANDS][16] = {"exit", "font", "size", "max", "help", "title", "textcolor", "backcolor"};

int getCommandID(char* cmd)
{
  toLowerCase(cmd);
  for(int i = 0; i < MAX_COMMANDS; i++)
    if(strcmp(cmd, cmd_list[i]) == 0) return i;

  return CMD_UNKNOWN;
}
/*
#ifndef _CONSOLE
int __stdcall WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
#else
*/
int main()
//#endif
{
  ConsoleHandle handle = console_Create("My console", 0, 0, 80, 25, false);

  LPTSTR lpMsgBuf;
  if(!FormatMessage( 
    FORMAT_MESSAGE_ALLOCATE_BUFFER | 
    FORMAT_MESSAGE_FROM_SYSTEM | 
    FORMAT_MESSAGE_IGNORE_INSERTS,
    NULL,
    GetLastError(),
    MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
    (LPTSTR) &lpMsgBuf,
    0,
    NULL ));
  LocalFree( lpMsgBuf );

  bool end = true;
  for( ; end; )
  {
    char command[64] = {0};
    console_Scan(handle, ">%s", command);
    if(*command == 0) continue;
    int ID = getCommandID(command);
    switch(ID)
    {
      case CMD_EXIT:
        end = false;
      break;

      case CMD_SETFONT:
        {
          int font;
          int maxFont;
          font = console_GetCurrentFont(handle);
          console_Print(handle, "Current font index is %d\n", font);
          console_Scan(handle, "Set font index : %d", &font);
          maxFont = console_GetMaxFontsCount(handle);
          if((font < 0) || (font >= maxFont))
            console_Print(handle, "Error : Invalid font index <%d>. It must be betwean 0 and %d\n", font, maxFont-1);
          else
          {
            bool result = console_SetFont(handle, font);
            if(!result) console_Print(handle, "Error : Error during new font <%d> seting\n", font);
          }
        }
      break;

      case CMD_TITLE:
        {
          char title[128];
          console_Scan(handle, "Set new title (127 chars max) : %s", title);
          console_SetTitle(handle, title);
        }
      break;

      case CMD_HELP:
        console_Print(handle, "Supported commands:\n");
        for(int i = 0; i < MAX_COMMANDS; i++) console_Print(handle, "  %s\n", cmd_list[i]);
      break;

      case CMD_MAXIMIZE:
        console_ToMaxSize(handle);
      break;

      case CMD_SETSIZE:
        {
          int width, height;
          width = console_GetWidth(handle);
          height = console_GetHeight(handle);
          console_Print(handle, "Current console window size : %d rows %d columns\n", height, width);
          console_Scan(handle, "New width : %d New height : %d", &width, &height);
          console_Resize(handle, width, height);
        }
      break;

      case CMD_TEXTCOLOR:
        {
          int red, green, blue, intensity;
          console_Print(handle, "Set text color\n");
          console_Scan(handle, "Red peresent %d Green present %d Blue present %d Intensity %d", &red, &green, &blue, &intensity);
          console_SetTextColor(handle, red, green, blue, intensity);
        }
      break;

      case CMD_BACKCOLOR:
        {
          int red, green, blue, intensity;
          console_Print(handle, "Set background color\n");
          console_Scan(handle, "Red peresent %d Green present %d Blue present %d Intensity %d", &red, &green, &blue, &intensity);
          console_SetBackgroundColor(handle, red, green, blue, intensity);
        }
      break;

      case CMD_UNKNOWN:
        console_Print(handle, "Error : Unknown command <%s>\n", command);
      break;
    }
  }

  console_Free(handle);

  return 0;
}