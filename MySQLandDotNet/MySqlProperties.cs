using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlExampleDotNet
{
    class MySqlProperties
    {
        //Warning: For illustration only. Not a production code!!!
        #region Secret Credential 
        public static string ID = "a-user";
        public static string PWD = "a-password";
        public static string CONN_STR = $"mysqlx://{ID}:{PWD}@localhost:33060";
        #endregion
    }
}
