package action;

import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONArray;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.* ;
import model.Paper;

public class SLContent extends ActionSupport {

	private static final long serialVersionUID = 7044325217725864319L;  

	// 接收参数 
	private String content ;
	private String type ;         // all , author , field , pub

	public void setContent(String a) {
		this.content = a ;
	}
	public void setType(String a) {
		this.type = a ;
	}

	// 返回数据
	private List<Paper> paper ;
	private String data;

	public String getData() {
		return data ;
	}
	public void setData(String d) {
		this.data = d ;
	}

	// 查询并返回结果
	public String execute() throws Exception {
		System.out.println("search " + type + ": " + content );  
		paper = new ArrayList<Paper>() ;

		// connect to database
		Class.forName("com.mysql.jdbc.Driver").newInstance();  
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");  
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);  
        
        String sql = "" ;
        if( type.equals("all") )
        	sql = "select * from paper.list" ;
        if( type.equals("author") )
        	sql = "select * from paper.list where Author LIKE '%" + content + "%'" ;
        if( type.equals("field") )
        	sql = "select * from paper.list where Field = '" + content + "'" ;
        if( type.equals("pub") )
        	sql = "select * from paper.list where Pub = '" + content + "'" ;
        
        sql += " order by year" ;
        
        ResultSet rs = stmt.executeQuery(sql); 
        while(rs.next()) {
        	Paper p = new Paper() ;
        	p.setAuthor(rs.getString(4));
    		p.setTitle(rs.getString(5));
    		p.setPublication(rs.getString(6));
    		p.setYear(rs.getString(2));
    		paper.add(p);
        }

		// json
		JSONArray ja = JSONArray.fromObject(paper);   
        //System.out.println( ja.toString() );   
        this.data = ja.toString();  
        return SUCCESS;  	
	}

}