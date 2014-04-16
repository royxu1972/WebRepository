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
	private String ad_author ;
	private String ad_pub ;
	private String ad_year ;

	public void setContent(String a) {
		this.content = a ;
	}
	public void setAd_author(String a) {
		this.ad_author = a ;
	}
	public void setAd_pub(String a) {
		this.ad_pub = a ;
	}
	public void setAd_year(String a) {
		this.ad_year = a ;
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
		String sql = "select * from paper.list where ( Author like '%" + sc[0] + "%' OR " + 
		                                              "Title like '%" + sc[0] + "%' OR " + 
				                                      "Publication like '%" + sc[0] + "%' OR " +
		                                              "Field like '%" + sc[0] + "%' )";
		
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
				
				sql += "union select * from paper.list where ( Author like '%" + sc[k] + "%' OR " + 
                        "Title like '%" + sc[k] + "%' OR " + 
                        "Publication like '%" + sc[k] + "%' OR " +
                        "Field like '%" + sc[k] + "%' )";
				
				if( ad_author != null && !ad_author.equals("") )
                    sql += " AND First_Author = '" + ad_author + "'";
				if( ad_year != null && !ad_year.equals("") )
                    sql += " AND Year = '" + ad_year + "'";
			}
		}

	    System.out.print("\r\n");
	    
	    sql += " order by ((CASE WHEN Author LIKE '%" + sc[0] + "%' THEN 1.5 ELSE 0 END) + " +
	                      "(CASE WHEN Title LIKE '%" + sc[0] + "%' THEN 1 ELSE 0 END) + " +
	    		          "(CASE WHEN Publication LIKE '%" + sc[0] + "%' THEN 1.5 ELSE 0 END) + " + 
	                      "(CASE WHEN Field LIKE '%" + sc[0] + "%' THEN 2 ELSE 0 END)" ;
	    
	    for(int k = 1; k < sc.length; k++) {
	    	if( !sc[k].equals("at") && !sc[k].equals("on") && !sc[k].equals("in") && 
					!sc[k].equals("by") && !sc[k].equals("for") && !sc[k].equals("of") && 
					!sc[k].equals("to") && !sc[k].equals("the") && !sc[k].equals("a") && 
					!sc[k].equals("an")) {
	    		 sql += " + (CASE WHEN Author LIKE '%" + sc[k] + "%' THEN 1.5 ELSE 0 END) + " +
	                      "(CASE WHEN Title LIKE '%" + sc[k] + "%' THEN 1 ELSE 0 END) + " +
	    		          "(CASE WHEN Publication LIKE '%" + sc[k] + "%' THEN 1.5 ELSE 0 END) + " + 
	                      "(CASE WHEN Field LIKE '%" + sc[k] + "%' THEN 2 ELSE 0 END)" ;
	    	}
	    }
	    
	    sql += ") DESC, year DESC, author ASC";
	    
	    ResultSet rs = stmt.executeQuery(sql);
	    while(rs.next()) {
	    	Paper p = new Paper();
	    	p.setAuthor(rs.getString(4));
	    	p.setTitle(rs.getString(5));
	    	p.setPublication(rs.getString(6));
	    	p.setYear(rs.getString(2));
	    	paper.add(p);
	    }
	}

	// 查询并返回结果
	public String execute() throws Exception {
		System.out.println("search: " + content + " | ad_author: " + ad_author +
				" | ad_pub: " + ad_pub + " | ad_year: " + ad_year );  

		paper = new ArrayList<Paper>() ;

		// connect to database
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper","root","123456");
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "select * from paper.list where " ;
        
        sql += "(Author like '%" + content + "%' OR " +
        		"Title like '%" + content + "%' OR " +
        		"Publication like '%" + content + "%' OR " +
        		"Year like '%" + content + "%')" ;
        
        if( ad_author != null && !ad_author.equals("") )
        	sql += " AND First_Author = '" + ad_author + "'";
        if( ad_year != null && !ad_year.equals("") )
            sql += " AND Year = '" + ad_year + "'";
        
        
        sql += " order by year DESC, author ASC";
        //System.out.println(sql);
        
        ResultSet rs = stmt.executeQuery(sql); 
        while(rs.next()) {
        	Paper p = new Paper() ;
        	p.setAuthor(rs.getString(4));
    		p.setTitle(rs.getString(5));
    		p.setPublication(rs.getString(6));
    		p.setYear(rs.getString(2));
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