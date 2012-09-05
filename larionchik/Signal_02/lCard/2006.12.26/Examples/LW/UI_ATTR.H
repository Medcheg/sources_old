/*---------------------------------------------------------------------------*/
/*                            L a b W i n d o w s                            */
/*---------------------------------------------------------------------------*/
/*    Copyright (c) National Instruments 1987-1992.  All Rights Reserved.    */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/*  Title   : UI_ATTR.H                                                      */
/*  Purpose : Include file for Microsoft C and Borland C programs using the  */
/*            LabWindows User Interface Library. Contains defined constants  */
/*            for:                                                           */
/*                                                                           */
/*               - colors                                                    */
/*               - fonts                                                     */
/*               - plot data types                                           */
/*               - trace styles                                              */
/*               - point styles                                              */
/*               - mouse cursor styles                                       */
/*               - menu bar attributes                                       */
/*               - panel attributes                                          */
/*               - control attributes                                        */
/*               - graph/strip chart attributes                              */
/*               - cursor attributes                                         */
/*               - trace attributes                                          */
/*               - hot keys                                                  */
/*                                                                           */
/*  Note    : In the LabWindows interactive program, you must explicitly     */
/*            include this file in your program. LabWindows does not         */
/*            automatically insert the include statement for this file in    */
/*            your program when you select the 'Insert All Includes' or      */
/*            'Create .EXE' command.                                         */
/*                                                                           */
/*---------------------------------------------------------------------------*/

/*- Colors ------------------------------------------------------------------*/

#define  COLOR_BLACK       0
#define  COLOR_BLUE        1
#define  COLOR_GREEN       2
#define  COLOR_CYAN        3
#define  COLOR_RED         4
#define  COLOR_MAGENTA     5
#define  COLOR_BROWN       6
#define  COLOR_LT_GRAY     7
#define  COLOR_GRAY        8
#define  COLOR_LT_BLUE     9
#define  COLOR_LT_GREEN    10
#define  COLOR_LT_CYAN     11
#define  COLOR_LT_RED      12
#define  COLOR_LT_MAGENTA  13
#define  COLOR_YELLOW      14
#define  COLOR_WHITE       15

/*- Fonts -------------------------------------------------------------------*/

#define  FONT_SYSTEM      0
#define  FONT_8x8         1
#define  FONT_6x10        2
#define  FONT_ARMONK      3
#define  FONT_BOSTON_12   4
#define  FONT_BOSTON_15   5
#define  FONT_BOSTON_24   6
#define  FONT_BOSTON_30   7
#define  FONT_CHICAGO_12  8
#define  FONT_CHICAGO_15  9
#define  FONT_CHICAGO_24  10
#define  FONT_CHICAGO_30  11
#define  FONT_LED         12
#define  FONT_MODERN      13
#define  FONT_7_SEG       14
#define  FONT_SHADOW      15

/*- Plot Data Types ---------------------------------------------------------*/

#define  PLOT_DATA_TYPE_CHAR    0
#define  PLOT_DATA_TYPE_INT     1
#define  PLOT_DATA_TYPE_LONG    2
#define  PLOT_DATA_TYPE_SINGLE  3
#define  PLOT_DATA_TYPE_DOUBLE  4

/*- Trace Styles ------------------------------------------------------------*/

#define  TS_LINE         0
#define  TS_CONNECT_PTS  1
#define  TS_SCATTER      2
#define  TS_VER_BAR      3
#define  TS_HOR_BAR      4

/*- Point Styles ------------------------------------------------------------*/

#define  PS_EMPTY_SQUARE       0
#define  PS_SOLID_SQUARE       1
#define  PS_ASTERISK           2
#define  PS_EMPTY_SQUARE_DOT   3
#define  PS_SOLID_SQUARE_DOT   4
#define  PS_SOLID_DIAMOND      5
#define  PS_EMPTY_SQUARE_X     6
#define  PS_EMPTY_SQUARE_PLUS  7
#define  PS_BOLD_X             8
#define  PS_SMALL_SQUARE       9
//#define  PS_DOT						10
#define  PS_NONE               11

/*- Mouse Cursor Styles -----------------------------------------------------*/

#define  MOUSE_ARROW       0
#define  MOUSE_CHECKMARK   1
#define  MOUSE_XHAIR       2
#define  MOUSE_BOX         3
#define  MOUSE_FINGER      4
#define  MOUSE_HAND        5
#define  MOUSE_QUESTION    6
#define  MOUSE_HOUR_GLASS  7
#define  MOUSE_HIDDEN      8
#define  MOUSE_DISABLE    -1

/*- Menu Bar Attributes -----------------------------------------------------*/

#define  ATTR_MENU_BAR_BACK_COLOR      0
#define  ATTR_MENU_BAR_LABEL_COLOR     1
#define  ATTR_MENU_BAR_FRAME_COLOR     2
#define  ATTR_MENU_BAR_LABEL           3
#define  ATTR_MENU_BAR_ENABLED         4
#define  ATTR_MENU_BAR_ITEM_LABEL      5
#define  ATTR_MENU_BAR_ITEM_ENABLED    6
#define  ATTR_MENU_BAR_ITEM_CHECKMARK  7
#define  ATTR_MENU_BAR_ITEM_HOTKEY     8

/*- Panel Attributes --------------------------------------------------------*/

#define  ATTR_PANEL_TITLE        0
#define  ATTR_PANEL_TITLE_FONT   1
#define  ATTR_PANEL_TITLE_COLOR  2
#define  ATTR_PANEL_BAR_COLOR    3
#define  ATTR_PANEL_BACK_COLOR   4
#define  ATTR_PANEL_FRAME_COLOR  5
#define  ATTR_PANEL_X_POSITION   6
#define  ATTR_PANEL_Y_POSITION   7

/*- Control Attributes ------------------------------------------------------*/

#define  ATTR_CTRL_LABEL          0
#define  ATTR_CTRL_LABEL_FONT     1
#define  ATTR_CTRL_LABEL_COLOR    2
#define  ATTR_CTRL_TEXT_FONT      3
#define  ATTR_CTRL_TEXT_COLOR     4
#define  ATTR_CTRL_COLOR          5
#define  ATTR_CTRL_BACK_COLOR     6
#define  ATTR_CTRL_LED_ON_COLOR   7
#define  ATTR_CTRL_LED_OFF_COLOR  8
#define  ATTR_CTRL_BUTTON_HOTKEY  9
#define  ATTR_CTRL_MODE           10
#define  ATTR_CTRL_DATA_TYPE      11
#define  ATTR_CTRL_MIN            12
#define  ATTR_CTRL_MAX            13
#define  ATTR_CTRL_DFLT           14
#define  ATTR_CTRL_ENABLED        15
#define  ATTR_CTRL_HIDDEN         16
#define  ATTR_CTRL_PRECISION      17

#define  CTRL_MODE_NORMAL         0
#define  CTRL_MODE_INDICATOR      1
#define  CTRL_MODE_HOT            2
#define  CTRL_MODE_VALIDATE       3

#define  CTRL_DATA_TYPE_INT       0
#define  CTRL_DATA_TYPE_LONG      1
#define  CTRL_DATA_TYPE_SINGLE    2
#define  CTRL_DATA_TYPE_DOUBLE    3
#define  CTRL_DATA_TYPE_STRING    4

/*- Graph/Strip Chart Attributes --------------------------------------------*/

#define  ATTR_GRAPH_TITLE               0
#define  ATTR_GRAPH_TITLE_FONT          1
#define  ATTR_GRAPH_TITLE_COLOR         2
#define  ATTR_GRAPH_GRID_COLOR          3
#define  ATTR_GRAPH_BACK_COLOR          4
#define  ATTR_GRAPH_PLOT_BACK_COLOR     5
#define  ATTR_GRAPH_AXIS_NAME_FONT      6
#define  ATTR_GRAPH_AXIS_NAME_COLOR     7
#define  ATTR_GRAPH_AXIS_LABEL_FONT     8
#define  ATTR_GRAPH_AXIS_LABEL_COLOR    9
                                        
#define  ATTR_GRAPH_X_AXIS_NAME         10
#define  ATTR_GRAPH_X_AXIS_SHOW_GRID    11
#define  ATTR_GRAPH_X_AXIS_SHOW_LABELS  12
#define  ATTR_GRAPH_X_AXIS_LOG_SCALE    13
#define  ATTR_GRAPH_X_AXIS_ENG_FORMAT   14
#define  ATTR_GRAPH_X_AXIS_DIVISIONS    15
#define  ATTR_GRAPH_X_AXIS_PRECISION    16
#define  ATTR_GRAPH_X_AXIS_ENG_UNITS    17
                                        
#define  ATTR_GRAPH_Y_AXIS_NAME         18
#define  ATTR_GRAPH_Y_AXIS_SHOW_GRID    19
#define  ATTR_GRAPH_Y_AXIS_SHOW_LABELS  20
#define  ATTR_GRAPH_Y_AXIS_LOG_SCALE    21
#define  ATTR_GRAPH_Y_AXIS_ENG_FORMAT   22
#define  ATTR_GRAPH_Y_AXIS_DIVISIONS    23
#define  ATTR_GRAPH_Y_AXIS_PRECISION    24
#define  ATTR_GRAPH_Y_AXIS_ENG_UNITS    25

#define  ATTR_GRAPH_NUM_CURSORS         26

#define  ATTR_STRIP_NUM_TRACES          27
#define  ATTR_STRIP_PTS_SCREEN          28
#define  ATTR_STRIP_SCROLL_MODE         29

#define  ATTR_DELETE_PLOT_MODE          30

#define  AXIS_LINEAR                    0
#define  AXIS_LOG                       1
#define  AXIS_AUTO                     -1
#define  AXIS_DEC_FMT                   0
#define  AXIS_ENG_FMT                   1

#define  SCROLL_MODE_CONTINUOUS         0
#define  SCROLL_MODE_BLOCK              1

/*- Graph Cursor Attributes -------------------------------------------------*/

#define  ATTR_CURSOR_MODE         0
#define  ATTR_CURSOR_PT_STYLE     1
#define  ATTR_CURSOR_XHAIR_STYLE  2
#define  ATTR_CURSOR_COLOR        3

#define  CURSOR_FREE_FORM         0
#define  CURSOR_SNAP_TO_POINT     1

#define  XHAIR_CROSS              0
#define  XHAIR_VER_LINE           1
#define  XHAIR_HOR_LINE           2
#define  XHAIR_NONE               3
#define  XHAIR_SHORT_CROSS        4

/*- Strip Chart Trace Attributes --------------------------------------------*/

#define  ATTR_TRACE_COLOR     0
#define  ATTR_TRACE_STYLE     1
#define  ATTR_TRACE_PT_STYLE  2

/*- Hot Keys ----------------------------------------------------------------*/
  
#define  HOTKEY_NONE      0
#define  HOTKEY_ESC       1
#define  HOTKEY_F1        2
#define  HOTKEY_F2        3
#define  HOTKEY_F3        4
#define  HOTKEY_F4        5
#define  HOTKEY_F5        6
#define  HOTKEY_F6        7
#define  HOTKEY_F7        8
#define  HOTKEY_F8        9
#define  HOTKEY_F9        10
#define  HOTKEY_F10       11
#define  HOTKEY_SH_F1     12
#define  HOTKEY_SH_F2     13
#define  HOTKEY_SH_F3     14
#define  HOTKEY_SH_F4     15
#define  HOTKEY_SH_F5     16
#define  HOTKEY_SH_F6     17
#define  HOTKEY_SH_F7     18
#define  HOTKEY_SH_F8     19
#define  HOTKEY_SH_F9     20
#define  HOTKEY_SH_F10    21
#define  HOTKEY_ALT_F1    22
#define  HOTKEY_ALT_F2    23
#define  HOTKEY_ALT_F3    24
#define  HOTKEY_ALT_F4    25
#define  HOTKEY_ALT_F5    26
#define  HOTKEY_ALT_F6    27
#define  HOTKEY_ALT_F7    28
#define  HOTKEY_ALT_F8    29
#define  HOTKEY_ALT_F9    30
#define  HOTKEY_ALT_F10   31
#define  HOTKEY_CTRL_F1   32
#define  HOTKEY_CTRL_F2   33
#define  HOTKEY_CTRL_F3   34
#define  HOTKEY_CTRL_F4   35
#define  HOTKEY_CTRL_F5   36
#define  HOTKEY_CTRL_F6   37
#define  HOTKEY_CTRL_F7   38
#define  HOTKEY_CTRL_F8   39
#define  HOTKEY_CTRL_F9   40
#define  HOTKEY_CTRL_F10  41
#define  HOTKEY_CTRL_A    42
#define  HOTKEY_CTRL_B    43
#define  HOTKEY_CTRL_C    44
#define  HOTKEY_CTRL_D    45
#define  HOTKEY_CTRL_E    46
#define  HOTKEY_CTRL_F    47
#define  HOTKEY_CTRL_G    48
#define  HOTKEY_CTRL_H    49
#define  HOTKEY_CTRL_I    50
#define  HOTKEY_CTRL_J    51
#define  HOTKEY_CTRL_K    52
#define  HOTKEY_CTRL_L    53
#define  HOTKEY_CTRL_M    54
#define  HOTKEY_CTRL_N    55
#define  HOTKEY_CTRL_O    56
#define  HOTKEY_CTRL_P    57
#define  HOTKEY_CTRL_Q    58
#define  HOTKEY_CTRL_R    59
#define  HOTKEY_CTRL_S    60
#define  HOTKEY_CTRL_T    61
#define  HOTKEY_CTRL_U    62
#define  HOTKEY_CTRL_V    63
#define  HOTKEY_CTRL_W    64
#define  HOTKEY_CTRL_X    65
#define  HOTKEY_CTRL_Y    66
#define  HOTKEY_CTRL_Z    67

/*- The End -----------------------------------------------------------------*/
