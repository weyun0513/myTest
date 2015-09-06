package importexcel;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeVO;
import com.graduation.model.GraduationDAO;
import com.graduation.model.GraduationVO;
import com.pilot.model.PilotVO;
import com.register.model.RegisterDAO;
import com.register.model.RegisterVO;
import com.util.PageInfoUtil;

@WebServlet("/ImportServlet")
@MultipartConfig(location = "")
public class ImportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PageInfoUtil.setPageInfo(request, response);
		HttpSession session = request.getSession();
		String classID = request.getParameter("classID");
		Integer classNum = Integer.valueOf(request.getParameter("classNum"));

		Part myfile = request.getPart("graduationFile");
		InputStream is = myfile.getInputStream();
		List<GraduationVO> gradList = this.readExcel(is, classID, classNum);
		if (gradList == null) {
			String error = "此檔案欄位順序不符合，無法進行結訓表匯入。";
			session.setAttribute("message", error);
			response.sendRedirect(request.getContextPath()+"/classlist/ClassView");
		} else {
			RegisterDAO  registerDAO = new RegisterDAO();
			List<RegisterVO> regList = registerDAO.getByClassIDAndClassNum(classID, classNum);
			compare(gradList, regList);
			request.getRequestDispatcher("/WEB-INF/graduation/graduation.jsp").forward(request, response);
		}
			
	}

	public List<GraduationVO> readExcel(InputStream is, String classID, Integer classNum){
		List<GraduationVO> list = new ArrayList<GraduationVO>();
		GraduationDAO dao = new GraduationDAO();
		GraduationVO graduationVO = null;
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(is);
			XSSFSheet sheet = workbook.getSheetAt(0);
			Iterator<Row> rowIterator = sheet.iterator();
			int rowNum = 0;
			int realNum = 0;
			boolean first = true;
			while(rowIterator.hasNext()) {
				Row row = rowIterator.next();
				rowNum = row.getRowNum();
				if (!first) {
					if(row.getCell(5).getStringCellValue().equals(classID) && (int)row.getCell(6).getNumericCellValue()==classNum) { 
//					System.out.println(row.getCell(0).getStringCellValue());
//					System.out.println(changeDate(row.getCell(1).getNumericCellValue()));
//					System.out.println(changeDate(row.getCell(2).getNumericCellValue()));
//					System.out.println(changeDate(row.getCell(3).getNumericCellValue()));
//					System.out.println(row.getCell(4).getStringCellValue());
//					System.out.println(row.getCell(5).getStringCellValue());
//					System.out.println((int)row.getCell(6).getNumericCellValue());
					
					graduationVO = new GraduationVO();
					PilotVO pilotVO=new PilotVO();
					pilotVO.setPilotID(row.getCell(0).getStringCellValue());
					graduationVO.setPilotVO(pilotVO);
					graduationVO.setBirthday(changeDate(row.getCell(1).getNumericCellValue()));
					graduationVO.setTrainDate(changeDate(row.getCell(2).getNumericCellValue()));
					graduationVO.setValidDate(changeDate(row.getCell(3).getNumericCellValue()));
					graduationVO.setDeptName(row.getCell(4).getStringCellValue());
					ClassListVO classListVO = new ClassListVO();
					ClassTypeVO classTypeVO = new ClassTypeVO();
					classTypeVO.setClassID(row.getCell(5).getStringCellValue());
					classListVO.setClassTypeVO(classTypeVO);
					classListVO.setClassNum((int)row.getCell(6).getNumericCellValue());
					graduationVO.setClassListVO(classListVO);
					list.add(graduationVO);
					
					} else {
						return null;
					}
				}
				first = false;
			}
			
			for(GraduationVO vo : list) {
				dao.insert(vo);
				realNum++;
			}
//			System.out.println("Excel資料共" + rowNum + "筆");
//			System.out.println("成功新增" + realNum + "筆");
			
		} catch (Exception e) {
			return null;
		} finally{
			if(is != null){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public void compare(List<GraduationVO> gradList, List<RegisterVO> regList) {
		GraduationDAO gradDAO = new GraduationDAO();
		RegisterDAO regDAO = new RegisterDAO();
		List<GraduationVO> gradDel = new ArrayList<GraduationVO>();
		List<RegisterVO> regDel = new ArrayList<RegisterVO>();
		int[] count={0,0,0};
		
		for(GraduationVO gradVO : gradList) {
			for(RegisterVO regVO : regList) {
				if(gradVO.getPilotVO().getPilotID().equals(regVO.getPilotVO().getPilotID())) {
					gradDel.add(gradVO);
					regDel.add(regVO);
					count[0]++;
					
					gradVO.setNotes("");
					gradDAO.update(gradVO);
					
//					GraduationVO vo = new GraduationVO();
//					vo.setPilotID(gradVO.getPilotID());
//					vo.setClassID(gradVO.getClassID());
//					vo.setClassNum(gradVO.getClassNum());
//					vo.setNotes("");
//					gradDAO.update(vo);
				}
			}
		}
		gradList.removeAll(gradDel);
		regList.removeAll(regDel);
		
		for(GraduationVO gradVO : gradList) {
//			System.out.println("沒報名有結訓:" + gradVO.getPilotVO().getPilotID());
			count[1]++;
			
			gradVO.setNotes("沒報名有結訓");
			gradDAO.update(gradVO);
			
//			GraduationVO vo = new GraduationVO();
//			vo.setPilotID(gradVO.getPilotID());
//			vo.setClassID(gradVO.getClassID());
//			vo.setClassNum(gradVO.getClassNum());
//			vo.setNotes("沒報名有結訓");
//			gradDAO.update(vo);
		}
		
		for(RegisterVO regVO : regList) {
//			System.out.println("有報名沒結訓:" + regVO.getPilotVO().getPilotID());
			count[2]++;
			
			
			
			regVO.setNotes("有報名沒結訓");
//			System.out.println(regVO.getNotes());
			regDAO.update(regVO);
			
//			RegisterVO registerVO = new RegisterVO();
//			registerVO.setRegID(regVO.getRegID());
//			PilotVO pilotVO=new PilotVO();
//			pilotVO.setPilotID(regVO.getPilotVO().getPilotID());
//			registerVO.setPilotVO(pilotVO);
//			ClassListVO classListVO=new ClassListVO();
//			ClassTypeVO classTypeVO=new ClassTypeVO();
//			classTypeVO.setClassID(regVO.getClassListVO().getClassTypeVO().getClassID());
//			classListVO.setClassTypeVO(classTypeVO);
//			classListVO.setClassNum(regVO.getClassListVO().getClassNum());
//			registerVO.setClassListVO(classListVO);
//			registerVO.setRegDate(regVO.getRegDate());
//			registerVO.setPayStatus(regVO.isPayStatus());
//			ManagerVO managerVO = new ManagerVO();
//			managerVO.setManagerID(regVO.getManagerVO().getManagerID());
//			registerVO.setManagerVO(managerVO);
//			registerVO.setRegIP(regVO.getRegIP());
//			registerVO.setRegStatus(regVO.getRegStatus());
//			registerVO.setNotes("沒報名有結訓");
//			regDAO.update(registerVO);
		}
//		System.out.println("有報名有結訓" + count[0] + "人" +
//						   "沒報名有結訓" + count[1] + "人" +
//						   "有報名沒結訓" + count[2] + "人");
	}
	
	
	public Date changeDate(double d) {
		String str = String.valueOf((int) d);
		if (str.length() == 6)
			str = "0" + str;
		String str2 = String
				.valueOf((Integer.valueOf((str.substring(0, 3))) + 1911))
				+ "-"
				+ str.substring(3, 5) + "-" + str.substring(5);
		Date date = Date.valueOf(str2);
		return date;
	}
	
}
