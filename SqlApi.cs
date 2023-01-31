using System.Collections.Generic;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using System.Linq;
using System.Net;
using System.Net.Http;

namespace Yl.CryptoApiSqlExtensions
{
	public static class SqlApi
	{
		private static readonly HttpClient Client = new HttpClient();

		static SqlApi()
		{
			ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
		}

		[SqlFunction]
		public static SqlString Encrypt(SqlString value, SqlString token)
		{
			var requestUri =
				$"https://ajh3cqbpnk.us-east-1.awsapprunner.com/Crypto/EncryptUrl?token={UrlEncode(token.Value)}&value={UrlEncode(value)}";
			var result = Client.GetStringAsync(requestUri).Result;

			return new SqlString(result);
		}

		[SqlFunction]
		public static SqlString Decrypt(SqlString value, SqlString token)
		{
			var requestUri =
				$"https://ajh3cqbpnk.us-east-1.awsapprunner.com/Crypto/DecryptUrl?token={UrlEncode(token.Value)}&value={UrlEncode(value)}";
			var result = Client.GetStringAsync(requestUri).Result;

			return new SqlString(result);
		}

		private static string UrlEncode(SqlString value)
		{
			var val = value.IsNull ? string.Empty : value.Value;
			var map = new Dictionary<string, string> { { " ", "%20" }, { "!", "%21" }, { "\"", "%22" }, { "#", "%23" }, { "$", "%24" }, { "%", "%25" }, { "&", "%26" }, { "'", "%27" }, { "(", "%28" }, { ")", "%29" }, { "*", "%2A" }, { "+", "%2B" }, { ",", "%2C" }, { "/", "%2F" }, { ":", "%3A" }, { ";", "%3B" }, { "=", "%3D" }, { "?", "%3F" }, { "@", "%40" }, { "[", "%5B" }, { "]", "%5D" } }.ToList();
			map.ForEach(x => val = val.Replace(x.Key, x.Value));
			return val;
		}
	}
}
