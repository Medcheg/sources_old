//---------------------------------------------------------------------------
#ifndef mpiTypesH
#define mpiTypesH
//---------------------------------------------------------------------------
#include "KeyLib\nvskey32.h"
//#include "KeyLib\nvkeyerr.h"
#include "Math.hpp"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------

enum TElementType  {etElement, etWork, etMaterial, etRashodnik, etMashine, etEnergo, etServise};
enum THideParam    {hpHideAllParam, hpHideElementParam, hpHideWorkParam, hpHideMaterialParam};
enum TProgType      {ptEstConf, ptEstimate};

enum  TWorkType    {wtMain, wtService};
enum  TZatratType  {ztMashiny, ztElectric, ztRashod};
const AnsiString   Type_Str[] = {"Материалл", "Расходный материалл", "Машины и механизмы", "Энергозатраты"};
const AnsiString   ElementType_Str[] = {"Элемент", "Работа", "Материалл", "Расходный материалл", "Машины и механизмы", "Энергозатраты", "Сервис"};

//---------------------------------------------------------------------------
/*    typedef struct {
      int   Id;
      int   ParentId;
      int            Level;
      TElementType   Type;

      ShortString    Name;
      double          Price;
      ShortString    Dimension;
      ShortString    CatalogNumber;
      ShortString    Parent;
      ShortString    NomenklatNumber;
      void Init ()
      {
           Id              = -999;
           ParentId        = -999;
           Level           = -999;
           Type            = etElement;
           Name            = " --- Название отсутсвует ---";
           Price           = 0;
           Dimension       = "";
           CatalogNumber   = "--------";
           Parent          = "--------";
           NomenklatNumber = "--------";
      }
    }TMaterial;*/


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++                                             +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++          TElement_2004_07_14;               +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++                                             +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    typedef struct {
      int   Level;
      int   Id;
      int   ParentId;
      int   CurId;
      int   CurParentId;
    // --------------------------
      ShortString    Name;
      TElementType   Type;   // {etElement, etWork, etMaterial, etZatrata};
      bool           ShowInExcel;
    // --------------------------
      double          CountUEPOD; /// Количество уловных единиц ---------
      double          Complexity; // --- Сложность -------
    // --------------------------
      double          fCalcPriceMat;         // Расчетное значение цены матеериалла -------
      double          fCalcPriceWork;        // ---- Расчетное значение цены работы --------
      double          fCalcAllPrice;         // ---- Расчетное занесение полной цены ----
      double          fCalcZatrataPrice;     // ----
        // -------- Параметры Елемента ----------
          struct { }Element;
        // -------- Параметры Работы ----------
          struct {
              double         Price;
              ShortString    Dimension;
              TWorkType      Type; // {wtMain, wtService};
          }Work;
        // -------- Параметры Материала ----------
          struct {
              double          Price;
              ShortString    Dimension;
              ShortString    CatalogNumber;
              ShortString    Parent;
              ShortString    NomenklatNumber;

              double         Reserved1;
              double         Reserved2;
              double         CoefRashodMaterial;
              bool           BlockParamCountUEPOD;
              bool           CompareRoomHeight;
          }Material;
        // -------- Параметры Затрат  ----------
          struct {
              double         Price;
              ShortString    Dimension;
              TZatratType    Type; // {ztMashiny, ztElectric, ztRashod};
          }Zatrata;
        // --------------------------
          void Init ()
          {
               Level        = -999;
               Type         = etElement;
               Name         = " --- Название отсутсвует ---";

               Id           = -999;
               ParentId     = -999;
               CurId        = -999;
               CurParentId  = -999;

               ShowInExcel  = true;
             // -------- Параметры Работы ----------
               Work.Price     = 0;
               Work.Dimension = "";
               Work.Type      = wtMain;
             // -------- Параметры Материала ----------
               Material.Price                = 0;
               Material.Dimension            = "";
               Material.CatalogNumber        = "--------";
               Material.Parent               = "--------";
               Material.NomenklatNumber      = "--------";
               Material.CoefRashodMaterial   = 1;
               Material.BlockParamCountUEPOD = false;
               Material.CompareRoomHeight    = false;
             // --------------------------
               Zatrata.Price               = 0;
               Zatrata.Dimension           = "";
               Zatrata.Type                = ztMashiny;
             // --------------------------
               CountUEPOD = 1;
               Complexity = 1;
             // --------------------------
               fCalcPriceMat     = -999999999;
               fCalcPriceWork    = -999999999;
               fCalcZatrataPrice = -999999999;
               fCalcAllPrice     = -999999999;
          }
        // --------------------------
          void CalcPrice ()
          {
                 fCalcPriceWork = CoefWork1 * CoefWork2 * CountUEPOD * Work.Price * Complexity;
             // ------------------
                 double CurUepod;

                 if (Material.BlockParamCountUEPOD) CurUepod = 1; else CurUepod = CountUEPOD;
                 if (Material.CompareRoomHeight   ) CurUepod = 2 * (CountUEPOD + RoomHeight * RoomHeight) / RoomHeight; else CurUepod = CountUEPOD;
                 fCalcPriceMat     = CoefMat1 * CoefMat2 * CurUepod   * Material.Price * Material.CoefRashodMaterial;

                 fCalcZatrataPrice = CoefWork1 * CoefWork2 * CountUEPOD * Zatrata.Price;
             // ------------------
                 fCalcAllPrice  = fCalcPriceMat + fCalcPriceWork;
          }
    }TElement_2004_07_14;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++                           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++          TElement         +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++                           +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    typedef struct {
      int   Level;
      int   Id;                  // ---- АйДи Елемента ------
      int   ParentId;            // ---- Кто редотель елемента (тобиш индекс) +--
      int   CurId;               // ---- С этим параметром я работаю в проге смета ----
      int   CurParentId;         // ---- С этим параметром я работаю в проге смета ----
      int   GlobalElementId;     // ---- Глобальний идентификатор елемента ----
    // --------------------------
      ShortString    Name;
      TElementType   Type;   // {etElement, etWork, etMaterial, etRashodnik, etMashine, etEnergo, etServise};
      bool           ShowInExcel;  // Отображать ли елемент дерева в таблице ексель ------------
    // --------------------------
      double          CountUEPOD;
      //double          CurCountUEPOD;   // ---- Текущее количество материалла с учетом всех коеффициентов -------
      double          Complexity;
    // --------------------------
      double          ElementPrice;
    // --------------------------
        // -------- Параметры других видов затрат  ----------
          struct {
              double         Price;
              ShortString    Dimension;
              ShortString    CatalogNumber;
              ShortString    Parent;
              ShortString    NomenklatNumber;
              double         ScaleFactorMaterial;

            // -----------
              //double         Reserved1;
              double         RoomHeight;

              double         Reserved1;
              double         Reserved2;
              double         Reserved3;

            // -----------
              double         CoefRashod;
              bool           BlockParamCountUEPOD;
              bool           CompareRoomHeight;


              //bool           RoomHeight;
              bool           Reserved11;
              bool           Reserved12;
              bool           Reserved13;
          }Data;
        // --------------------------
          void Init ()
          {
               Level        = -999;
               Type         = etElement;
               Name         = " --- Название отсутсвует ---";

               Id              = -999;
               ParentId        = -999;
               CurId           = -999;
               CurParentId     = -999;
               GlobalElementId = -999;

               ShowInExcel  = true;

/*             // -------- Параметры Работы ----------
               Work.Price     = 0;
               Work.Dimension = "";
               Work.Type      = wtMain;*/

             // -------- Параметры других видов затрат  ----------
               Data.Price                = 0;
               Data.Dimension            = "";
               Data.CatalogNumber        = "--------";
               Data.Parent               = "--------";
               Data.NomenklatNumber      = "--------";
               Data.ScaleFactorMaterial   = 1;

               Data.RoomHeight           = -999;
               Data.Reserved1            = -999;
               Data.Reserved2            = -999;
               Data.Reserved3            = -999;

               Data.CoefRashod           = 1;
               Data.BlockParamCountUEPOD = false;
               Data.CompareRoomHeight    = false;

               Data.Reserved11           = false;
               Data.Reserved12           = false;
               Data.Reserved13           = false;

             // -------- Параметры Материала ----------

               CountUEPOD = 1;
               Complexity = 1;
             // --------------------------

               /*fCalcPriceWork      = -999;
               fCalcPriceMaterial  = -999;
               fCalcPriceRashodnik = -999;
               fCalcPriceMashine   = -999;
               fCalcPriceEnergo    = -999;
               fCalcPriceServise   = -999;

               fCalcAllPrice       = -999;*/
               ElementPrice       = -999;
          }
        // --------------------------
          void CalcPrice ()
          {
              // -------------------------
                 ElementPrice  = 0;
              // -------------------------
                 //double CurCountUEPOD = CountUEPOD;
                 if (Data.CompareRoomHeight   ) CountUEPOD = Ceil(2 * (CountUEPOD + RoomHeight * RoomHeight) / RoomHeight * 100.0) / 100.0;
                 if (Data.BlockParamCountUEPOD) CountUEPOD = 1;

                 switch ( Type ) {
                     case etWork      :  ElementPrice  = Data.Price * CountUEPOD * Complexity; break;
                     case etMaterial  :  ElementPrice  = Data.Price * CountUEPOD * Data.CoefRashod / Data.ScaleFactorMaterial; break;
                     case etRashodnik :  ElementPrice  = Data.Price * CountUEPOD * Data.CoefRashod; break;
                     case etMashine   :  ElementPrice  = Data.Price * CountUEPOD * Data.CoefRashod; break;
                     case etEnergo    :  ElementPrice  = Data.Price * CountUEPOD * Data.CoefRashod; break;
                     case etServise   :  ElementPrice  = Data.Price * CountUEPOD * Data.CoefRashod; break;
                 }
                // ---- Округляем до копеек -------
                 ElementPrice = Ceil(ElementPrice * 100.0) / 100.0;
          }
    }TElement;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
extern TElement *BufferElementList; // ---------- Копируемая ветка дерева ---------
extern int       BufferElementList_Items_Count; // ------ Количество копируемых елементов -------

extern int   *MaterialListID;  extern int   MaterialListID_Count;
extern int   *RashodnikListID; extern int   RashodnikListID_Count;
extern int   *MashineListID;   extern int   MashineListID_Count;
extern int   *EnergoListID;    extern int   EnergoListID_Count;
extern int   *ServiseListID;   extern int   ServiseListID_Count;
//extern TElement      *ElementList;
//extern TMaterial     *MaterialList;
//extern int            Element_Count;     // --- Количество елементов м Масиве "ElementList"
//extern int            Material_Count;     // ---- Количество елементов в масиве "MaterialList"
//---------------------------------------------------------------------------
#endif
