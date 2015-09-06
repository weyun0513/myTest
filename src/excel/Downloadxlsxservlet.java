package excel;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.register.model.RegisterDAO;
import com.register.model.RegisterVO;

public class Downloadxlsxservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	this.doPost(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		String classID=request.getParameter("classID");
		int classNum=Integer.parseInt(request.getParameter("classNum"));
		processexcel pro=new processexcel();
		 response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Content-Disposition", "attachment; filename="+classID+classNum+"registList.xlsx");
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		XSSFWorkbook workBook = pro.Writeexcel(classID, classNum);

		 OutputStream outStream = response.getOutputStream();
		try {
			workBook.write(outStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			outStream.close();
			outStream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
