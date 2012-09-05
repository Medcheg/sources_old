//===========================================================================
#ifndef mpiElementsTreeH
#define mpiElementsTreeH
// ------------------------------------------------------------------------------
// -- Класс элемента дерева (нужен толоко для отображения информации в дереве) --
// ------------------------------------------------------------------------------
class TTreeNodeElement {
private:
   AnsiString    fParentNodeText;   // ---- Имя родительской ветки -----------------------
   AnsiString    fNodeText;         // ---- Имя ветки которой пренадлежит элемент --------
   TList        *fNodeElementList;  // ---- Список элементов ветки -----------------------
public:
  // ---  Создаем --
    TTreeNodeElement(AnsiString aNodeText, AnsiString aParentNodeText);
   ~TTreeNodeElement();
    void Add(void *aElement);

  // ---- Пропертя чтения ----
    __property  AnsiString   NodeText        = { read = fNodeText};
    __property  AnsiString   ParentNodeText  = { read = fParentNodeText};
    __property  TList       *NodeElementList = { read = fNodeElementList};
};
//===========================================================================
extern TList  *TreeNodeList;        // ---- Перечень еэементов на закладке ----
extern int GetCreateAddressByClassName(AnsiString aClassName);
extern void RegisterElement(AnsiString aParentNodeText, AnsiString aNodeText, int aCreateAdress);
#endif

