using MikesBank.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace MikesBank.LogProvider
{
    public class SqlHelper
    {
        private string ConnectionString { get; set; }

        public SqlHelper(string connectionStr)
        {
            ConnectionString = connectionStr;
        }

        private bool ExecuteNonQuery(string commandStr, List<SqlParameter> paramList)
        {
            bool result = false;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                if (conn.State != System.Data.ConnectionState.Open)
                {
                    conn.Open();
                }

                using (SqlCommand command = new SqlCommand(commandStr, conn))
                {
                    command.Parameters.AddRange(paramList.ToArray());
                    int count = command.ExecuteNonQuery();
                    result = count > 0;
                }
            }
            return result;
        }

        public bool InsertLog(Logging log)
        {
            string command = $@"INSERT INTO [dbo].[Logging] ([Log_Severity],[Log_Source],[Log_Message],[Log_StackTrace],[Update_By],[Update_Time]) ";
            command += "VALUES (@Severity,@Source,@Message,@StackTrace,@UpdateBy,@UpdateTime)";
            List<SqlParameter> paramList = new List<SqlParameter>();
            paramList.Add(new SqlParameter("Severity", TruncateTo(log.LogSeverity, 50)));
            paramList.Add(new SqlParameter("Source", TruncateTo(log.LogSource, 1000)));
            paramList.Add(new SqlParameter("Message", TruncateTo(log.LogMessage, 4000)));
            paramList.Add(new SqlParameter("StackTrace", TruncateTo(log.LogStackTrace, 4000)));
            paramList.Add(new SqlParameter("UpdateBy", log.UpdateBy));
            paramList.Add(new SqlParameter("UpdateTime", DateTime.UtcNow));
            return ExecuteNonQuery(command, paramList);
        }

        private string TruncateTo(string str, int maxLength)
        {
            //  Make sure the strings we're trying to save to our database fields aren't longing than our nvarchar() lengths
            if (string.IsNullOrEmpty(str))
                return "";
            if (str.Length < maxLength)
                return str;

            return str.Substring(0, maxLength);
        }
    }
}
