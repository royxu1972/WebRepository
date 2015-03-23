package action;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;
import model.Author;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SLAuthor extends ActionSupport {
    private static final long serialVersionUID = 7044325217725864320L;

    // receive parameter
    private String content ;

    public void setContent(String a) {
        this.content = a ;
    }

    // return data
    private Author author = new Author();
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

        String sql = "select * from paper.listauthor where author = ?" ;
        PreparedStatement preState = null ;
        preState = conn.prepareStatement(sql);
        preState.setString(1, content);

        ResultSet rs = preState.executeQuery();
        rs.next();

        // data columns:
        // id, author, affiliation, country, email, homepage
        String aff = rs.getString(3);
        String country = rs.getString(4);
        author.setFull_affiliation( aff + ", " + country );

        String email = rs.getString(5);
        author.setEmail( rs.wasNull() ? "" : email );

        String homepage = rs.getString(6);
        author.setHomepage(rs.wasNull() ? "" : homepage);

        // close
        preState.close();
        rs.close();
        conn.close();

        /* jackson */
        OutputStream out = new ByteArrayOutputStream();
        ObjectMapper mapper = new ObjectMapper();
        try {
            mapper.writeValue(out, author);
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
