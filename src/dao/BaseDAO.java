package dao;

import model.SqlResultReport;
import java.sql.*;
import java.util.ArrayList;

import static constants.DBConstants.*;
import util.Log4jLogger;

public class BaseDAO {

	//DBセッション
	private Connection conn = null;
	//SQL実行結果
	private ResultSet resultData = null;
	//ロガー
	private  static Log4jLogger logger =  Log4jLogger.getInstance();

	private SqlResultReport executeSelect(StringBuilder sql, ArrayList<String> param){
		return null;
	}


}
