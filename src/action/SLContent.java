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
	private String group ;  // group = all | author | field | pub

	public void setContent(String a) {
		this.content = a ;
	}
	public void setGroup(String a) {
		this.group = a ;
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
		System.out.println("search " + group + ": " + content );
		paper = new ArrayList<Paper>() ;

		// connect to database
		Class.forName("com.mysql.jdbc.Driver").newInstance();  
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");  
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);  
        
        String sql = "" ;
        if( group.equals("all") )
        	sql = "select * from paper.list" ;
        if( group.equals("author") )
        	sql = "select * from paper.list where author LIKE '%" + content + "%'" ;
        if( group.equals("field") )
        	sql = "select * from paper.list where field = '" + content + "'" ;
        if( group.equals("pub") ) {
            if( content.equals("phd") ) {
                sql = "select * from paper.list where type = 'phdthesis'" ;
            }
            else if( content.equals("tech") ) {
                sql = "select * from paper.list where type = 'techreport'" ;
            }
            else {
                sql = "select * from paper.list where publication = '" + content + "'" ;
            }
        }
        
        sql += " order by year" ;
        
        ResultSet rs = stmt.executeQuery(sql);
        // data columns: id, bib, type, year, author, title, publication, vol, no, pages, field, doi, abstract
        while(rs.next()) {
        	Paper p = new Paper() ;
            // bib info
            p.setBib(rs.getString(2));
            p.setType(rs.getString(3));
            // basic info
        	p.setAuthor(rs.getString(5));
    		p.setTitle(rs.getString(6));
    		p.setPublication(rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(4));
            p.setField(rs.getString(11));
            p.setDoi(rs.getString(12));
            p.setAbstra(rs.getString(13));
    		paper.add(p);
        }

		// json
		JSONArray ja = JSONArray.fromObject(paper);   
        //System.out.println( ja.toString() );   
        this.data = ja.toString();  
        return SUCCESS;  	
	}

}