package action;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import com.opensymphony.xwork2.ActionSupport;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.sql.PreparedStatement ;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import model.Paper;
//import net.sf.json.JSONArray;

public class SLSearch extends ActionSupport {

	private static final long serialVersionUID = 7044325217725864313L;  

	// receive parameter
	private String content ;

	public void setContent(String a) {
		this.content = a ;
	}

	// return data
	private List<Paper> paper ;
	private String data;

	public String getData() {
		return data ;
	}
	public void setData(String d) {
		this.data = d ;
	}

	// do first query
	public String execute() throws Exception {

		Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");
        String sql = "select * from paper.list where " ;
		PreparedStatement preState = null ;

        sql += "(author like ? OR " +
        		"title like ? OR " +
        		"publication like ? OR " +
        		"year like ?)" +
				" order by year DESC, author ASC";

		preState = conn.prepareStatement(sql);
		preState.setString(1, "%" + content + "%");
		preState.setString(2, "%" + content + "%");
		preState.setString(3, "%" + content + "%");
		preState.setString(4, "%" + content + "%");

        ResultSet rs = preState.executeQuery();
        rs.last();
        int rowCount = rs.getRow();

        rs.beforeFirst();
        paper = new ArrayList<Paper>(rowCount) ;
        while(rs.next()) {
            Paper p = new Paper() ;

            p.setBib(rs.getString(2));
            p.setType(rs.getString(3));
            p.setYear(rs.getString(4));
            p.setAuthor(rs.getString(5));
            p.setTitle(rs.getString(6));
            p.setPublication(rs.getString(7));
            p.setField(rs.getString(12));

            String abbr = rs.getString(8);
            p.setAbbr( rs.wasNull() ? "" : abbr );

            String vol = rs.getString(9);
            p.setVol( rs.wasNull() ? "" : vol );

            String no = rs.getString(10);
            p.setNo( rs.wasNull() ? "" : no );

            String page = rs.getString(11);
            p.setPages( rs.wasNull() ? "" : page );

            String doi = rs.getString(13) ;
            p.setDoi( rs.wasNull() ? "" : doi );

            paper.add(p);
        }

        // close
        preState.close();
        rs.close();
        conn.close();

        /* json
		JSONArray ja = JSONArray.fromObject(paper);
        this.data = ja.toString();
        */

		/* jackson */
        OutputStream out = new ByteArrayOutputStream();
        ObjectMapper mapper = new ObjectMapper();
        try {
            mapper.writeValue(out, paper);
        } catch (JsonGenerationException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        this.data = out.toString();

        return SUCCESS;  	
	}

}