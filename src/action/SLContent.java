package action;

import java.io.ByteArrayOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.sf.json.JSONArray;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.PreparedStatement ;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import model.Paper;

public class SLContent extends ActionSupport {

	private static final long serialVersionUID = 7044325217725864319L;  

	// receive parameter
	private String content ;
	private String group ;  // group = all | author | field | pub

	public void setContent(String a) {
		this.content = a ;
	}
	public void setGroup(String a) {
		this.group = a ;
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

	// do query
	public String execute() throws Exception {

		// connect to database
		Class.forName("com.mysql.jdbc.Driver").newInstance();  
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/paper", "wayne", "123456");

        String sql = "" ;
        PreparedStatement preState = null ;
        if( group.equals("all") ) {
            sql = "select * from paper.list";
        }
        if( group.equals("author") ) {
            sql = "select * from paper.list where author LIKE ?";
        }
        if( group.equals("field") ) {
            sql = "select * from paper.list where field = ?";
        }
        if( group.equals("pub") ) {
            if( content.equals("phd") ) {
                sql = "select * from paper.list where type = 'phdthesis'" ;
            }
            else if( content.equals("tech") ) {
                sql = "select * from paper.list where type = 'techreport'" ;
            }
            else {
                sql = "select * from paper.list where abbr = ?" ;
            }
        }
        sql += " order by year DESC" ;

        preState = conn.prepareStatement(sql);
        if( sql.indexOf('?') != -1 ) {
            if( group.equals("author") )
                preState.setString(1, "%" + content + "%");
            else
                preState.setString(1, content);
        }
        ResultSet rs = preState.executeQuery();
        rs.last();
        int rowCount = rs.getRow();

        rs.beforeFirst();
        paper = new ArrayList<Paper>(rowCount) ;
        // data columns:
        // id, bib, type, year, author, title, publication, [abbr], [vol], [no], [pages], field, [doi]
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