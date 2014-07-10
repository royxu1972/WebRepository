package action;

import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONArray;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.* ;

import model.Paper;

public class SLSearch extends ActionSupport {

	private static final long serialVersionUID = 7044325217725864313L;  

	// 接收参数 
	private String content ;

	public void setContent(String a) {
		this.content = a ;
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
	
	public void FuzzySearch() throws Exception {
		content = content.toLowerCase();
		String sc[] = content.split(" ");

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "root", "123456");
		Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		
		System.out.print( "fuzzy search: " + sc[0] + " ");
		String sql = "select * from paper.list where ( author like '%" + sc[0] + "%' OR " +
		                                              "title like '%" + sc[0] + "%' OR " +
				                                      "publication like '%" + sc[0] + "%' ) " ;
		
		//if( ad_author != null && !ad_author.equals("") )
		//	sql += " AND First_Author = '" + ad_author + "'";
		//if( ad_year != null && !ad_year.equals("") )
		//	sql += " AND Year = '" + ad_year + "'";
		
		for(int k = 1; k < sc.length; k++) {
			if( !sc[k].equals("at") && !sc[k].equals("on") && !sc[k].equals("in") && 
				!sc[k].equals("by") && !sc[k].equals("for") && !sc[k].equals("of") && 
				!sc[k].equals("to") && !sc[k].equals("the") && !sc[k].equals("a") && 
				!sc[k].equals("an")) {
				
				System.out.print( sc[k] + " " );
				
				sql += "union select * from paper.list where ( author like '%" + sc[k] + "%' OR " +
                        "title like '%" + sc[k] + "%' OR " +
                        "publication like '%" + sc[k] + "%' ) " ;
				
				//if( ad_author != null && !ad_author.equals("") )
                //    sql += " AND First_Author = '" + ad_author + "'";
				//if( ad_year != null && !ad_year.equals("") )
                //    sql += " AND Year = '" + ad_year + "'";
			}
		}

	    System.out.print("\r\n");
	    
	    sql += " order by ((CASE WHEN author LIKE '%" + sc[0] + "%' THEN 1.5 ELSE 0 END) + " +
	                      "(CASE WHEN title LIKE '%" + sc[0] + "%' THEN 1 ELSE 0 END) + " +
	    		          "(CASE WHEN publication LIKE '%" + sc[0] + "%' THEN 1.5 ELSE 0 END)" ;
	    
	    for(int k = 1; k < sc.length; k++) {
	    	if( !sc[k].equals("at") && !sc[k].equals("on") && !sc[k].equals("in") && 
					!sc[k].equals("by") && !sc[k].equals("for") && !sc[k].equals("of") && 
					!sc[k].equals("to") && !sc[k].equals("the") && !sc[k].equals("a") && 
					!sc[k].equals("an")) {
	    		 sql += " + (CASE WHEN author LIKE '%" + sc[k] + "%' THEN 1.5 ELSE 0 END) + " +
	                      "(CASE WHEN title LIKE '%" + sc[k] + "%' THEN 1 ELSE 0 END) + " +
	    		          "(CASE WHEN publication LIKE '%" + sc[k] + "%' THEN 1.5 ELSE 0 END)" ;
	    	}
	    }
	    
	    sql += ") DESC, year DESC, author ASC";
	    
	    ResultSet rs = stmt.executeQuery(sql);
	    while(rs.next()) {
            Paper p = new Paper() ;
            // bib info
            p.setBib(rs.getString(2));
            p.setType(rs.getString(3));
            // basic info
            p.setAuthor(rs.getString(5));
            p.setTitle(rs.getString(6));
            p.setPublication(rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(4));
            p.setField(rs.getString(12));
            p.setDoi(rs.getString(13));
            p.setAbstra(rs.getString(14));
            paper.add(p);
	    }
	}

	// 查询并返回结果
	public String execute() throws Exception {
		System.out.println("search: " + content );
		paper = new ArrayList<Paper>() ;

		// connect to database
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "select * from paper.list where " ;
        
        sql += "(author like '%" + content + "%' OR " +
        		"title like '%" + content + "%' OR " +
        		"publication like '%" + content + "%' OR " +
        		"year like '%" + content + "%')" ;

        sql += " order by year DESC, author ASC";
        //System.out.println(sql);
        
        ResultSet rs = stmt.executeQuery(sql); 
        while(rs.next()) {
            Paper p = new Paper() ;
            // bib info
            p.setBib(rs.getString(2));
            p.setType(rs.getString(3));
            // basic info
            p.setAuthor(rs.getString(5));
            p.setTitle(rs.getString(6));
            p.setPublication(rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(4));
            p.setField(rs.getString(12));
            p.setDoi(rs.getString(13));
            p.setAbstra(rs.getString(14));
            paper.add(p);
        }

        if(paper.size() == 0)
            FuzzySearch();
        
		// json
		JSONArray ja = JSONArray.fromObject(paper);   
        //System.out.println( ja.toString() );   
        this.data = ja.toString();  
        
        return SUCCESS;  	
	}

}