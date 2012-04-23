using System;
using System.Data;
using System.Xml;

public class AsAllTestResultTable : CsvDataTable{

	public AsAllTestResultTable(){
		this.TableName = "AsAllTestResult";
		ColumnSettings = new[]{
			IdColumnName,
			"Internet Explorer 6.0",
			"Internet Explorer 7.0",
			"Internet Explorer 8.0",
			"Internet Explorer 9",
			"Firefox 3.5",
			"Firefox 4.0",
			"Safari 3.2",
			"Safari 5.0.3",
			"JAWS for Windows 9.0",
			"ホームページ・リーダー 3.04",
			"PC-Talker XP 3.06",
			"PC-Talker XP 3.06 + NetReader 1.18",
			"FocusTalk V3",
			"NVDA 2010.1j",
			"NVDA 2011.1",
		};
		CreateColumn();
	}

	public override XmlNode RowToXml(DataRow row, XmlDocument xml){
		XmlNode result = base.RowToXml(row,xml);
		foreach(string s in ColumnSettings){
//			Console.WriteLine(s);
			if(s == null) continue;
			if(s == IdColumnName) continue;
			Object data = row[s];
			XmlElement e = AppendElement(result, "result", data);
			if(e == null) continue;
			e.SetAttribute("useragent", s);
		}
		return result;
	}

}


