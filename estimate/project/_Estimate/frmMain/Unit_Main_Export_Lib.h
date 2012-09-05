//=====================  Установка формата Ячейки ======================================================
//void SetCellFormat(Variant aCurSheet, int aRow, int aCol)
//{
//   aCurSheet.OlePropertyGet("Cells", aRow, aCol).OlePropertySet("NumberFormat", "@");
//}

//=====================  Вывод только строки ======================================================
void SetCellValue(Variant aCurSheet, int aRow, int aCol, char *aChar)
{
   aCurSheet.OlePropertyGet("Cells", aRow, aCol).OlePropertySet("Value", aChar);
}

//=====================  Атрибуты ачейки  ======================================================
void SetCellAttribut(Variant aCurSheet, int aRow, int aCol, char *aStyle, int aSize)
{
   Variant aFont = aCurSheet.OlePropertyGet("Cells", aRow, aCol).OlePropertyGet("Font");

   aFont.OlePropertySet("FontStyle", aStyle);
   aFont.OlePropertySet("Size"     , aSize);
}

//=====================  Выравнивание ячейки ======================================================
void SetCellAligment(Variant aCurSheet, int aRow, int aCol, int axAligment, int ayAligment)
{
   Variant aCell = aCurSheet.OlePropertyGet("Cells", aRow, aCol);

   aCell.OlePropertySet("HorizontalAlignment", axAligment);   // где 1 - Left, 3 - Center, )
   aCell.OlePropertySet("VerticalAlignment"  , ayAligment);   // где 1 - Top, 2 - Center, 3 - Bottom)
}

//=====================  Объединение ячеек ======================================================
void MergeCell(Variant aCurSheet, int aY1, int aX1, int aY2, int aX2)
{
  AnsiString aa = AnsiString(char(65 + aX1 - 1)) + IntToStr(aY1) + AnsiString(":") +  AnsiString(char(65 + aX2 - 1))+ IntToStr(aY2);
  aCurSheet.OlePropertyGet("Range", aa.c_str()).OleProcedure("Merge");
}

// ========================= Рисование бордюра ячейки ================================
void DrawCellBorder(Variant aCurSheet, int aY1, int aX1, int aY2, int aX2, TCellBorder aCellBorder)
{
  AnsiString aa = AnsiString(char(65 + aX1 - 1)) + IntToStr(aY1) + AnsiString(":") +  AnsiString(char(65 + aX2 - 1))+ IntToStr(aY2);

  Variant Border = aCurSheet.OlePropertyGet("Range", aa.c_str()).OlePropertyGet("Borders");
  // ---------------
     if (aCellBorder == cbAll) {
        for (int i = 1 ; i <= 4; i ++)
            Border.OlePropertyGet("Item", i).OlePropertySet("LineStyle", 1);
     }
  // ---------------
     if (aCellBorder == cbAll) {
        for (int i = 1 ; i <= 4; i ++)
            Border.OlePropertyGet("Item", i).OlePropertySet("LineStyle", 1);
     } else
     if (aCellBorder == cbLeftRight) {
            Border.OlePropertyGet("Item", 1).OlePropertySet("LineStyle", 1);
            Border.OlePropertyGet("Item", 2).OlePropertySet("LineStyle", 1);
     } else
     if (aCellBorder == cbTopBottom) {
            Border.OlePropertyGet("Item", 3).OlePropertySet("LineStyle", 1);
            Border.OlePropertyGet("Item", 4).OlePropertySet("LineStyle", 1);
     } else {
            Border.OlePropertyGet("Item", aCellBorder + 1).OlePropertySet("LineStyle", 1);
     }
}


//=====================  Ширина столбца ======================================================
void SetCellWidth(Variant aCurSheet, int aColumns, int aWidth)
{
  aCurSheet.OlePropertyGet("Columns").OlePropertyGet("Item",aColumns).OlePropertySet("ColumnWidth", aWidth);
}



void OutExcelCellValue(Variant &aCurSheet, AnsiString aRange)
{
/*
сходный код:


var
  xls: Variant;
const
  xlCenter = -4108;

procedure MerCen(ran: string);
begin
  xls.Range[ran].Select;
  xls.Selection.HorizontalAlignment := xlCenter;
  xls.Selection.VerticalAlignment := xlCenter;
  xls.Selection.WrapText:= false;
  xls.Selection.Orientation := 0;
  xls.Selection.ShrinkToFit := False;
  xls.Selection.MergeCells := False;
  xls.Selection.Merge;
end;*/
/*    _Cells .ClearArgs();
    _Value .ClearArgs();
    aCurSheet.Exec(_Cells << aRow << aCol).Exec(_Value << aOutString);*/
}
//=====================  Вывод только строки ======================================================
void OutExcelCellValue(Variant &aCurSheet, int aRow, int aCol, AnsiString aOutString)
{
    _Cells .ClearArgs();
    _Value .ClearArgs();
    aCurSheet.Exec(_Cells << aRow << aCol).Exec(_Value << aOutString);
/*
   // ----- Привязка к левому краю = 2 ; к средине = 3; к правому = 4 ----
   for i := 1 to 1  do MyExcel.Sheets.item[3].Columns[i].HorizontalAlignment := 2;
   for i := 2 to 13 do MyExcel.Sheets.item[3].Columns[i].HorizontalAlignment := 3;
*/
}

//====================  Вывод строки с заданием размера шрифта =======================================================
void OutExcelCellValue(Variant &aCurSheet, int aRow, int aCol, AnsiString aOutString, int aFontSize)
{
    _Cells .ClearArgs();
    _Value .ClearArgs();
    _Font  .ClearArgs();
    aCurSheet.Exec(_Cells << aRow << aCol).Exec(_Value << aOutString);
    aCurSheet.Exec(_Cells).Exec(_Font).Exec(_FontSize  << aFontSize);
}
//====================   Вывод строки с заданием стиля шрифта=======================================================
void OutExcelCellValue(Variant &aCurSheet, int aRow, int aCol, AnsiString aOutString, AnsiString aFontStyle)
{
    _Cells .ClearArgs();
    _Value .ClearArgs();
    _Font  .ClearArgs();
    aCurSheet.Exec(_Cells << aRow << aCol).Exec(_Value << aOutString);
   aCurSheet.Exec(_Cells).Exec(_Font).Exec(_FontStyle << aFontStyle);
}
//=====================   Вывод строки с заданием стиля и размера шрифта======================================================
void OutExcelCellValue(Variant &aCurSheet, int aRow, int aCol, AnsiString aOutString, AnsiString aFontStyle, int aFontSize)
{
    _Cells .ClearArgs();
    _Value .ClearArgs();
    _Font  .ClearArgs();
    aCurSheet.Exec(_Cells << aRow << aCol).Exec(_Value << aOutString);
    aCurSheet.Exec(_Cells).Exec(_Font).Exec(_FontStyle << aFontStyle);
    aCurSheet.Exec(_Cells).Exec(_Font).Exec(_FontSize  << aFontSize);
}
