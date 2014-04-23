package action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.*;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import model.Paper;

public class CiteLoad extends ActionSupport{
	
	private static final long serialVersionUID = 0x89c8e03304cc9e2L;

    public String execute() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        String jstr = request.getParameter("jsda");
        JSONArray array = JSONArray.fromObject(jstr);
        
        Paper paper[] = new Paper[array.size()];
        for(int i = 0; i < array.size(); i++)
        {
            JSONObject jsonObject = array.getJSONObject(i);
            paper[i] = (Paper)JSONObject.toBean( jsonObject , Paper.class );
        }

        System.out.println("prepare " + array.size() + " papers");
        // localhost
        //File file = new File("/home/wayne/workspace/CombPublication/WebContent/CiteList.txt");
        // server
        File file = new File("/home/tomcat6/webapps/CombPublication/CiteList.txt");
        
        FileWriter filewriter = new FileWriter(file, false);
        //for(int i = 0; i < array.size(); i++)
        //    filewriter.write((new StringBuilder("[")).append(i + 1).append("] ").append(paper[i].getAuthor()).append(", \"").append(paper[i].getTitle()).append("\", ").append(paper[i].getPublication()).append("\r\n").toString());

        filewriter.flush();
        filewriter.close();
        return "success";
    }

    
}