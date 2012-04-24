using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Xsl;


public class CsvLoader{

	public const string InputCsvDirName = "csv";
	public const string InputXsltDirName = "xslt";
	public const string OutputXmlDirName = "xml";
	public const string OutputHtmlDirName = "html";

	private DirectoryInfo CsvDir{get;set;}
	private DirectoryInfo OutputXmlDir{get;set;}
	private DirectoryInfo OutputHtmlDir{get;set;}
	private DirectoryInfo InputXsltDir{get;set;}
	private SuccessCriteriaTable SuccessCriteriaTable{get;set;}
	private AsAllTestResultTable AsAllTestResultTable{get;set;}
	private AsTestResultTable[] AsTestResultTables{get;set;}
	private AsDescriptionTable[] AsDescriptionTables{get;set;}

	private Dictionary<string, XslCompiledTransform> xslts = new Dictionary<string, XslCompiledTransform>();
	private readonly string[] XsltFileNames = new string[]{"doc", "index", "cover"};

	public CsvLoader(DirectoryInfo baseDir){
		CsvDir = new DirectoryInfo(baseDir.FullName + '\\' + InputCsvDirName);
		if(!CsvDir.Exists){
			throw new Exception(string.Format("Directory not found: {0}", CsvDir.FullName));
		}
		OutputXmlDir = new DirectoryInfo(baseDir.FullName + '\\' + OutputXmlDirName);
		OutputHtmlDir = new DirectoryInfo(baseDir.FullName + '\\' + OutputHtmlDirName);
		InputXsltDir = new DirectoryInfo(baseDir.FullName + '\\' + InputXsltDirName);

		foreach(string s in XsltFileNames){
			var xslt = new XslCompiledTransform();
			FileInfo xsltFile = GetFileInfo(InputXsltDir, s + ".xsl");
			xslt.Load(xsltFile.FullName);
			xslts.Add(s, xslt);
		}

	}

	public void Execute(){
		Console.WriteLine("start.");
		Console.WriteLine();

		LoadTables(CsvDir);

		// テスト全体XMLを作成
		FileInfo allTestXmlFile = GetFileInfo(OutputXmlDir, "testresult.xml");
		if(AsAllTestResultTable != null){
			SaveXml(AsAllTestResultTable, allTestXmlFile);
		} else {
			Console.WriteLine("AsAllTestResultTableのロードに失敗したため、ファイル{0}を作成できませんでした。", allTestXmlFile.FullName);
		}

		// 説明XML/HTMLを保存、
		foreach(AsDescriptionTable adt in AsDescriptionTables){
			FileInfo outputFile = GetFileInfo(OutputXmlDir, adt.Name + ".xml");
			XmlDocument xml = adt.ToXml();
			SuccessCriteriaTable.SetSuccessCriteriaInfo(xml, adt.Name);

			SaveXml(xml, outputFile);
			SaveAllChildren(adt);
			FileInfo indexHtml = GetFileInfo(OutputHtmlDir, adt.Name + ".html");
			CreateHtml("index", xml, indexHtml);
		}

		// カバーページHTMLを保存
		var criteriaXml = SuccessCriteriaTable.ToXml();
		SaveXml(criteriaXml, GetFileInfo(OutputXmlDir, "success-criteria.xml"));
		CreateHtml("cover", criteriaXml, GetFileInfo(OutputHtmlDir, "index.html"));

		Console.WriteLine();
		Console.WriteLine("done.");
	}


	// 特定ディレクトリからCsvDataTableを一気に読み込みます。
	private void LoadTables(DirectoryInfo csvDir){
		FileInfo[] csvFiles = csvDir.GetFiles("*.csv");
		List<AsDescriptionTable> descTableList = new List<AsDescriptionTable>();
		List<AsTestResultTable> resultTableList = new List<AsTestResultTable>();
		foreach(FileInfo f in csvFiles){
			CsvDataTable cdt = CsvDataTable.CreateCsvDataTable(f);
			if(cdt is AsAllTestResultTable){
				AsAllTestResultTable = cdt as AsAllTestResultTable;
			} else if(cdt is AsDescriptionTable) {
				descTableList.Add(cdt as AsDescriptionTable);
			} else if(cdt is AsTestResultTable) {
				resultTableList.Add(cdt as AsTestResultTable);
			} else if(cdt is SuccessCriteriaTable) {
				SuccessCriteriaTable = cdt as SuccessCriteriaTable;
				// 達成基準リストXMLにはファイル有無の情報を追加する
				SuccessCriteriaTable.CheckFileExists(csvDir);
			}
		}
		AsDescriptionTables = descTableList.ToArray();
		AsTestResultTables = resultTableList.ToArray();
		Console.WriteLine("Load Completed.");
	}

	public static void SaveXml(Object o, FileInfo outputFile){
		if(o == null){
			Console.WriteLine("object null: {0}", outputFile.FullName);
			return;
		}
		XmlDocument xml = null;
		if(o is XmlDocument){
			xml = o as XmlDocument;
		} else if(o is CsvDataTable){
			xml = (o as CsvDataTable).ToXml();
		}
		xml.Save(outputFile.FullName);
		Console.WriteLine("Saved: {0}", outputFile.FullName);
	}


	// DescriptionのXML/HTMLをすべてSaveします。
	public void SaveAllChildren(AsDescriptionTable adt){
		foreach(DataRow row in adt.Rows){
			XmlDocument xml = new XmlDocument(){XmlResolver = null};
			XmlElement root = xml.CreateElement("description");
			xml.AppendChild(root);
			root.AppendChild(adt.RowToXml(row, xml));

			string id = row[AsDescriptionTable.IdColumnName].ToString();

			XmlElement testResult = xml.CreateElement("testResult");
			XmlNode testResultNode = AsAllTestResultTable.GetXmlById(id, xml);
			testResult.AppendChild(testResultNode);
			root.AppendChild(testResult);

			XmlElement testDetail = xml.CreateElement("testDetail");
			XmlNode testDetailNode = GetTestDetail(id, xml);
			testDetail.AppendChild(testDetailNode);
			root.AppendChild(testDetail);

			FileInfo outputXml = GetFileInfo(OutputXmlDir, id + ".xml");
			SaveXml(xml, outputXml);

			FileInfo outputHtml = GetFileInfo(OutputHtmlDir, id + ".html");
			CreateHtml("doc", xml, outputHtml);
		}
	}


	// idを指定して、AsTestResultTableからテスト詳細を取得します。
	private XmlNode GetTestDetail(string id, XmlDocument xml){
		var result = xml.CreateDocumentFragment();
		foreach(string userAgent in AsAllTestResultTable.ColumnSettings){
			if(userAgent == null) continue;
			if(userAgent == AsAllTestResultTable.IdColumnName) continue;

			var resultElement = xml.CreateElement("result");
			resultElement.SetAttribute("useragent", userAgent);
			resultElement.AppendChild(GetTestDetail(id, xml, userAgent));
			result.AppendChild(resultElement);
		}
		return result;
	}

	// ブラウザ名とIDを指定して、AsTestResultTableからテスト詳細を取得します。
	private XmlNode GetTestDetail(string id, XmlDocument xml, string userAgent){
		try{
			foreach(var table in AsTestResultTables){
				if(table.UserAgent.Equals(userAgent, StringComparison.InvariantCultureIgnoreCase)){
					XmlNode result = table.GetXmlById(id, xml);
					if(result != null) return result;
				}
			}
		}catch(Exception){}
		Console.WriteLine("ID:{0}, UA:{1}の詳細テストデータがみつかりませんでした。", id, userAgent);
		return xml.CreateDocumentFragment();
	}


	// DirectoryInfoとファイル名からFileInfoを取得します。
	private static FileInfo GetFileInfo(DirectoryInfo dir, string filename){
		FileInfo result = new FileInfo(dir.FullName + "\\" + filename.Trim('\\'));
		return result;
	}



	// XSLTプロセッサを使用して XML を HTML に変換します。
	private void CreateHtml(string processorName, XmlDocument xml, FileInfo outputFile){
		var xslt = xslts[processorName];
		using(XmlWriter result = XmlWriter.Create(outputFile.FullName, xslt.OutputSettings)){
			xslt.Transform(xml, result);
			Console.WriteLine("Generated: {0}", outputFile.FullName);
		}
	}

}


