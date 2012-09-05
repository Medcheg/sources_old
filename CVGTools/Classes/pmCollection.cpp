//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmCollection.h"

///

//---------------------------------------------------------------------------

/*
        public class CFile
        {
            private List<string>      _names;
            private List<bool>        _visible;
            private List<List<float>> _items;
            private Param             _param;
            private int               _last_saved_pos;

            public CFile( List<string> names, List<bool> visible, List<List<float>> items, Param param )
            {
                _names   = names;
                _visible = visible;
                _items   = items;
                _param   = param;

                _last_saved_pos = 0;
            }

            public void Write_HeadTextFile( System.IO.StreamWriter sw, int head_type )
            {
                sw.WriteLine("FileVersion\t\t= "         + _param.FileVersion.ToString());
                sw.WriteLine("SamplingTime[seconds]\t= " + _param.SamplingTime.ToString());
                sw.WriteLine("ScaleFactor\t\t= "         + _param.ScaleFactor.ToString());
                sw.WriteLine("CanalCount\t\t= "          + _param.CanalCount.ToString());

                // -----
                string local_str = "";
                foreach (string str in _names)
                    local_str = local_str + str + " ";

                // -----

                sw.WriteLine("CanalNames\t\t" + local_str);
                sw.WriteLine("");
                sw.WriteLine("");

                _last_saved_pos = 0;
            }
            public void Write_UnsavedDataToTextFile( System.IO.StreamWriter sw)
            {
                // = 0;
                // -----
                string str_to_write;
                double temp_double_val;

                int items_count  = _items.Count;
                int values_count = _items[0].Count;
                for ( int k = _last_saved_pos; k < values_count; k++)
                {
                    temp_double_val =  _items[0][k];
                    str_to_write    = temp_double_val.ToString("f9");
                    for ( int i = 1; i < items_count; i++)
                    {
                       temp_double_val =  _items[i][k];
                       str_to_write = str_to_write + "\t" + temp_double_val.ToString("f9");
                    }
                    sw.WriteLine(str_to_write);
                }
                _last_saved_pos = values_count;
                sw.Flush();
            }

            public void Load_TextFile( string FileName, object ProgressBar )
            {
                System.IO.StreamReader sr = new System.IO.StreamReader(FileName);


                while ( sr.EndOfStream == false )
                {
                    // ---- ������ ������ � �����
                    string []SplitedStringArray = sr.ReadLine().Split('\t','=',' ');
                    int ssa_length = SplitedStringArray.Length;

                    #region ������������� ����� �����
                        if (SplitedStringArray[0] == "FileVersion")
                            for (int i = 1; i < ssa_length; i++)
                                if ( Int32.TryParse(SplitedStringArray[i], out _param.FileVersion) == true) break;

                        if (SplitedStringArray[0] == "SamplingTime[seconds]")
                            for (int i = 1; i < ssa_length; i++)
                                if (Single.TryParse(SplitedStringArray[i], out _param.SamplingTime) == true) break;

                        if (SplitedStringArray[0] == "ScaleFactor")
                            for (int i = 1; i < ssa_length; i++)
                                if (Single.TryParse(SplitedStringArray[i], out _param.ScaleFactor) == true) break;

                        if (SplitedStringArray[0] == "CanalCount")
                            for (int i = 1; i < ssa_length; i++)
                                if (Int32.TryParse(SplitedStringArray[i], out _param.CanalCount) == true) break;

                        if (SplitedStringArray[0] == "CanalNames")
                        {
                            _names.Clear();
                            _visible.Clear();
                            for (int i = 1; i < ssa_length; i++)
                            {
                                if (SplitedStringArray[i] != "")
                                {
                                    _names.Add(SplitedStringArray[i]);
                                    _visible.Add(true);
                                }
                            }
                        }
                    #endregion

                    // �������� ������ ������ ( ��������, ���� �� � ������������� ������ �� �����)
                    float temporary_float;
                    if ( Single.TryParse(SplitedStringArray[0], out temporary_float) == false ) continue;

                    // ������� ����� �����
                    _items.Clear();
                    int ListsCount = SplitedStringArray.Length;
                    for (int i = 0; i < ListsCount; i++)
                        _items.Add(new List<float>());

                    // ������� ������ ������� "������"
                    float[] fArray = Array.ConvertAll<string, float>(SplitedStringArray, float.Parse);
                    for (int i = 0; i < ListsCount; i++)
                        _items[i].Add(fArray[i]);

                    //Console.Beep();

                    // ������ ��������� ������, ���� �� ����� �����
                    while (sr.EndOfStream == false)
                    {
                        // ������ ������ � �����
                        SplitedStringArray = sr.ReadLine().Split('\t');
                        fArray = Array.ConvertAll<string, float>(SplitedStringArray, float.Parse);

                        for (int i = 0; i < ListsCount; i++)
                            _items[i].Add(fArray[i]);
                    }
                }

                //Console.WriteLine("loaded");
                sr.Close();
            }
            public void Save_TextFile( string FileName, object ProgressBar )
            {
                System.IO.StreamWriter sw = new System.IO.StreamWriter(FileName);

                Write_HeadTextFile(sw, 1);
                Write_UnsavedDataToTextFile( sw );

                //Console.WriteLine("saved");
                //Console.ReadLine();

                sw.Close();
            }

            public void Load_Binary(string FileName)
            {
                System.IO.FileStream fs = new System.IO.FileStream(FileName, System.IO.FileMode.Open);
                fs.Close();

                throw new Exception(" todo ");
            }
            public void Save_Binary(string FileName)
            {
                System.IO.FileStream fs = new System.IO.FileStream(FileName, System.IO.FileMode.CreateNew);
                fs.Close();

                throw new Exception(" todo ");
            }
*/
