//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include <windows.h>
#include <objbase.h>
#include "..\include\ioctl.h"
#include "..\include\ifc_ldev.h"

#include "..\include\create.h"

CREATEFUNCPTR CreateInstance = NULL;
HINSTANCE hComponent = NULL;

ULONG CallCreateInstance(char* name)
{
   CreateInstance = NULL;
  // ------------
   hComponent = ::LoadLibrary(name);
   if(hComponent==NULL)
   {
//      cout << "Unable load dll" << endl;
      return 0;
   }

   CreateInstance = (CREATEFUNCPTR)::GetProcAddress(hComponent,"CreateInstance");
   if(CreateInstance==NULL)
   {
//      cout << "Unable find CreateInstance" << endl;
      return 0;
   }
   return 1;
}

ULONG CallFreeInstance()
{
   if ( hComponent != NULL )
       ::FreeLibrary(hComponent);

   hComponent = NULL;
   
   return 1;    
}

// CreateInstance(PCIA);