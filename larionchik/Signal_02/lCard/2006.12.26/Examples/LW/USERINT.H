/*---------------------------------------------------------------------------*/
/*                            L a b W i n d o w s                            */
/*---------------------------------------------------------------------------*/
/*    Copyright (c) National Instruments 1987-1992.  All Rights Reserved.    */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/* Title   : USERINT.H                                                       */
/* Purpose : Include file for Microsoft C and Borland C programs using the   */
/*           LabWindows User Interface Library.                              */
/*                                                                           */
/*---------------------------------------------------------------------------*/

/*- Defines -----------------------------------------------------------------*/

#if (__STDC__ == 1) && (_MSC_VER != 600)
  #if (__TURBOC__ >= 1040) || (_MSC_VER >= 700)
    #define LW_CDECL far __cdecl
  #else
    #define LW_CDECL far
  #endif
#elif (_MSC_VER != 500)
  #define LW_CDECL far _cdecl
#else
  #define LW_CDECL far
#endif

#ifdef __cplusplus
  extern "C" {
#endif

/*- Interface Manager -------------------------------------------------------*/

int LW_CDECL OpenInterfaceManager  (void);
int LW_CDECL CloseInterfaceManager (void);

/*- Menu Bars ---------------------------------------------------------------*/

int LW_CDECL LoadMenuBar          (char far [], int);
int LW_CDECL UnloadMenuBar        (void);
int LW_CDECL SetMenuItemCheckmark (int, int);
int LW_CDECL GetMenuBarAttribute  (int, int, ...);
int LW_CDECL SetMenuBarAttribute  (int, int, ...);

/*- Panels ------------------------------------------------------------------*/

int LW_CDECL LoadPanel         (char far [], int);
int LW_CDECL UnloadPanel       (int);
int LW_CDECL DisplayPanel      (int);
int LW_CDECL HidePanel         (int);
int LW_CDECL GetActivePanel    (int far *);
int LW_CDECL SetActivePanel    (int);
int LW_CDECL SetPanelPos       (int, int, int);
int LW_CDECL DefaultPanel      (int);
int LW_CDECL SavePanelState    (int, char far []);
int LW_CDECL RecallPanelState  (int, char far []);
int LW_CDECL GetPanelAttribute (int, int, ...);
int LW_CDECL SetPanelAttribute (int, int, ...);

/*- Pop-up Panels -----------------------------------------------------------*/

int LW_CDECL InstallPopup       (int);
int LW_CDECL GetPopupEvent      (int, int far *);
int LW_CDECL RemovePopup        (int);
int LW_CDECL MessagePopup       (char far []);
int LW_CDECL PromptPopup        (char far [], char far [], int);
int LW_CDECL ConfirmPopup       (char far []);
int LW_CDECL FileSelectPopup    (char far [], char far [], char far [], int, int, int, char far []);
int LW_CDECL XGraphPopup        (void far *, int, int);
int LW_CDECL YGraphPopup        (void far *, int, int);
int LW_CDECL XYGraphPopup       (void far *, void far *, int, int, int);
int LW_CDECL WaveformGraphPopup (void far *, int, int, double, double, double, double);

/*- Controls ----------------------------------------------------------------*/

int LW_CDECL GetActiveCtrl    (int far *);
int LW_CDECL SetActiveCtrl    (int);
int LW_CDECL DefaultCtrl      (int, int);
int LW_CDECL SetCtrlVal       (int, int, ...);
int LW_CDECL GetCtrlVal       (int, int, ...);
int LW_CDECL GetCtrlAttribute (int, int, int, ...);
int LW_CDECL SetCtrlAttribute (int, int, int, ...);

/*- List Controls -----------------------------------------------------------*/

int LW_CDECL InsertListItem   (int, int, int, char far []);
int LW_CDECL DeleteListItem   (int, int, int, int);
int LW_CDECL ReplaceListItem  (int, int, int, char far []);
int LW_CDECL RefreshListCtrl  (int, int);
int LW_CDECL GetListItem      (int, int, int, char far []);
int LW_CDECL GetListItemIndex (int, int, int far *);

/*- Graph Controls ----------------------------------------------------------*/

int LW_CDECL PlotX                (int, int, void far *, int, int, int, int, int, int);
int LW_CDECL PlotY                (int, int, void far *, int, int, int, int, int, int);
int LW_CDECL PlotXY               (int, int, void far *, void far *, int, int, int, int, int, int, int);
int LW_CDECL PlotWaveform         (int, int, void far *, int, int, double, double, double, double, int, int, int, int);
int LW_CDECL PlotText             (int, int, double, double, char far [], int, int, int);
int LW_CDECL PlotPoint            (int, int, double, double, int, int);
int LW_CDECL PlotStripChart       (int, int, void far *, int, int, int, int);
int LW_CDECL DeletePlots          (int, int);
int LW_CDECL ConfigureAxes        (int, int, int, double, double, int, double, double);
int LW_CDECL GetGraphAttribute    (int, int, int, ...);
int LW_CDECL SetGraphAttribute    (int, int, int, ...);
int LW_CDECL GetTraceAttribute    (int, int, int, int, int far *);
int LW_CDECL SetTraceAttribute    (int, int, int, int, int);
int LW_CDECL GetGraphCursor       (int, int, int, double far *, double far *);
int LW_CDECL SetGraphCursor       (int, int, int, double, double);
int LW_CDECL SetActiveGraphCursor (int, int, int);
int LW_CDECL GetActiveGraphCursor (int, int, int far *);
int LW_CDECL GetCursorAttribute   (int, int, int, int, int far *);
int LW_CDECL SetCursorAttribute   (int, int, int, int, int);

/*- User Input --------------------------------------------------------------*/

int LW_CDECL GetUserEvent (int, int far *, int far *);
int LW_CDECL SetInputMode (int, int, int);

/*- Screen Operations -------------------------------------------------------*/

int LW_CDECL ClearGraphicsScreen (int);
int LW_CDECL SetBackgroundColor  (int);
int LW_CDECL DisplayPCXFile      (char far [], int, int);
int LW_CDECL SetMouseCursor      (int);

/*- Hardcopy Operations -----------------------------------------------------*/

int LW_CDECL ConfigurePrinter          (char far [], int, double, double, int);
int LW_CDECL ConfigureGPIBPlotter      (int);
int LW_CDECL ConfigureRS232Plotter     (int, int, int, int, int);
int LW_CDECL ConfigurePlotFile         (char far []);
int LW_CDECL ConfigurePlotterPenCount  (int);
int LW_CDECL ConfigurePlotterPenColors (int, int, int, int, int, int, int, int, int, int, int, int, int, int, int, int);
int LW_CDECL ConfigurePlotterSpeed     (int);
int LW_CDECL OutputGraph               (int, char far [], int, int, int);
int LW_CDECL OutputPanel               (int, char far [], int, int);
int LW_CDECL OutputScreen              (int, char far []);

#ifdef __cplusplus
  }
#endif

/*- The End -----------------------------------------------------------------*/
