//===========================================================================
#ifndef mpiElementsTreeH
#define mpiElementsTreeH
// ------------------------------------------------------------------------------
// -- ����� �������� ������ (����� ������ ��� ����������� ���������� � ������) --
// ------------------------------------------------------------------------------
class TTreeNodeElement {
private:
   AnsiString    fParentNodeText;   // ---- ��� ������������ ����� -----------------------
   AnsiString    fNodeText;         // ---- ��� ����� ������� ����������� ������� --------
   TList        *fNodeElementList;  // ---- ������ ��������� ����� -----------------------
public:
  // ---  ������� --
    TTreeNodeElement(AnsiString aNodeText, AnsiString aParentNodeText);
   ~TTreeNodeElement();
    void Add(void *aElement);

  // ---- �������� ������ ----
    __property  AnsiString   NodeText        = { read = fNodeText};
    __property  AnsiString   ParentNodeText  = { read = fParentNodeText};
    __property  TList       *NodeElementList = { read = fNodeElementList};
};
//===========================================================================
extern TList  *TreeNodeList;        // ---- �������� ��������� �� �������� ----
extern int GetCreateAddressByClassName(AnsiString aClassName);
extern void RegisterElement(AnsiString aParentNodeText, AnsiString aNodeText, int aCreateAdress);
#endif

