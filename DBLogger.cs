using Microsoft.Extensions.Logging;
using MikesBank.Models;
using System;

namespace MikesBank.LogProvider
{
    public class DBLogger : ILogger
    {
        //  Taken from:
        //  https://code.msdn.microsoft.com/How-to-implement-logging-4cbcfc64/sourcecode?fileId=171576&pathId=676232873
        //
        private string _categoryName;
        private Func<string, LogLevel, bool> _filter;
        private SqlHelper _helper;
        private int MessageMaxLength = 4000;

        public DBLogger(string categoryName, Func<string, LogLevel, bool> filter, string connectionString)
        {
            _categoryName = categoryName;
            _filter = filter;
            _helper = new SqlHelper(connectionString);
        }

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception ex, Func<TState, Exception, string> formatter)
        {
            System.Diagnostics.Trace.WriteLine(ex);

            if (!IsEnabled(logLevel))
                return;

            if (formatter == null)
                throw new ArgumentNullException(nameof(formatter));

            var message = formatter(state, ex);
            if (string.IsNullOrEmpty(message))
                return;

            if (ex != null)
            {
                message += "  " + ex.Message;
                if (ex.InnerException != null)
                    message += "  " + ex.InnerException.Message;
            }
            message = message.Length > MessageMaxLength ? message.Substring(0, MessageMaxLength) : message;

            Logging eventLog = new Logging()
            {
                LogSeverity = logLevel.ToString(),
                LogMessage = message,
                LogSource = "",
                LogStackTrace = (ex == null) ? null : ex.StackTrace,
                UpdateBy = "logging",
                UpdateTime = DateTime.Now
            };
            _helper.InsertLog(eventLog);
        }
        public bool IsEnabled(LogLevel logLevel)
        {
            return (_filter == null || _filter(_categoryName, logLevel));
        }

        public IDisposable BeginScope<TState>(TState state)
        {
            return null;
        }
    }
}
