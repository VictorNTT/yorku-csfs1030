using System;

using MySqlX.XDevAPI;
using MySqlX.XDevAPI.Relational;

namespace SqlExampleDotNet
{
    //Warning: For illustration only. Not a production code!!!
    class MySqlExample
    {
        public static void test()
        {
            using (Session session = MySQLX.GetSession(MySqlProperties.CONN_STR)) { 

                Table countryTbl = session.GetSchema("world").GetTable("City");
                var myRows = countryTbl.Select("ID, Name, District, Population").Where("CountryCode = :ccode").Bind("ccode", "CAN").Execute();
                var rows = myRows.FetchAll();
                foreach (Row row in rows)
                {
                    Console.WriteLine(row["ID"] + ", " + row["Name"] + ", " + row["District"] + ", " + row["Population"]);
                }                
            }
        }

    }
}
