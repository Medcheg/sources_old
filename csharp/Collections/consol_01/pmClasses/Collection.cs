namespace pmClasses
{
    public class Collection<T1> where T1 : System.IComparable<T1>
    {
        private class CItems<T2> where T2 : System.IComparable<T2>
        {
            private const int DEFAULT_REALOC_SIZE = 16000;

            public T2[] _values;
            private int _valuesCount;
            private int _maxSaveArrayPos;

            //private T2 _maximum;
            //private T2 _minimum;


            public CItems()
            {
                _values = null;
                _valuesCount = 0;
                _maxSaveArrayPos = 0;
                //((object)(T2)).ToString     
                //fMaximum = -10000.0;
                //fMinimum = 10000.0;
            }

            public void Add(T2 value)
            {
                if (_valuesCount >= _maxSaveArrayPos)
                {
                    T2[] temp_array = new T2[_maxSaveArrayPos + DEFAULT_REALOC_SIZE];
                    System.Array.Copy(_values, temp_array, _valuesCount);
                    _values = temp_array;
                }

                _values[_valuesCount++] = value;
            }
        }


        private CItems<T1>[] Items;
        private int fItemsCount;

        public Collection()
        {
            Init();
            SetItemsCount(1);
        }

        public Collection(int aItemsCount)
        {
            Init();
            SetItemsCount(aItemsCount);
        }

        public void SetItemsCount(int aItemsCount)
        {

            // Проверки на то, надоли увеличивать размер масива
            if (fItemsCount == aItemsCount) return;
            if (fItemsCount >= aItemsCount)
            {
                fItemsCount = aItemsCount;
                return;
            }

            // увеличиваем размер масива 
            CItems<T1>[] tempArray = new CItems<T1>[aItemsCount];
            
            if (Items != null)
                System.Array.Copy(Items, tempArray, fItemsCount);

            for (int i = fItemsCount; i < aItemsCount; i++)
                tempArray[i] = new CItems<T1>();

            Items = tempArray;
            fItemsCount = aItemsCount;
        }

        public void Add(T1 value)
        {
            Items[0].Add(value);
        }
        public void Add(int aItemIndex, T1 value)
        {
            Items[aItemIndex].Add(value);
        }

        private void Init()
        {
            fItemsCount = 0;
            Items = null;
        }

        public T1 Values
        {
            get { return Items[0]._values[0]; }
        }


    }
}