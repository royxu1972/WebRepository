package action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.*;
import javax.servlet.ServletContext;
import org.apache.struts2.util.ServletContextAware;

public class DownLoad extends ActionSupport implements ServletContextAware {
	
	private static final long serialVersionUID = 0x89c8e03304cc9d9L;
    private ServletContext context;

    public void setServletContext(ServletContext context) {
        this.context = context;
    }

    public InputStream getDownloadStream() throws IOException {    	
        return context.getResourceAsStream("CiteList.txt");
    }

    public String execute() {
        System.out.println("download CiteList.txt");
        return "success";
    }
}