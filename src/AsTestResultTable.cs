using System;
using System.Data;
using System.Xml;
using System.Text.RegularExpressions;

public class AsTestResultTable : CsvDataTable{

	public static Regex TitleRegex = new Regex("^(.+)アクセシビリティサポーテッド検証結果\\s*\\[等級(A+)\\]");
	public string UserAgent{get; private set;}
	public string Grade{get; private set;}

	public AsTestResultTable(){
		this.TableName = "AsTestResult";
		ColumnSettings = new[]{
			null,
			IdColumnName,
			"検証結果",
			"操作手順",
			"備考"
		};
		CreateColumn();
	}
	
	
	public override void Load(string[][] alldata){
		base.Load(alldata);
		string titleData = alldata[0][1];
		Match m = TitleRegex.Match(titleData);
		if(m.Groups.Count < 3){
			throw new Exception("タイトルからブラウザと等級のデータを読みとれませんでした。読もうとしたデータ: " + titleData);
		}
		UserAgent = m.Groups[1].Value.Trim();
		Grade = m.Groups[2].Value.Trim();
		this.Name = UserAgent + " - " + Grade;
	}
	

	public override XmlNode RowToXml(DataRow row, XmlDocument xml){
		XmlNode result = base.RowToXml(row,xml);
		foreach(string s in ColumnSettings){
			if(s == null) continue;
			if(s == IdColumnName) continue;
			XmlElement e = AppendElement(result, s, row[s]);
		}
		return result;
	}

}


