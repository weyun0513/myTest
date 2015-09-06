package excel;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.pilot.model.PilotVO;
import com.register.model.RegisterDAO;
import com.register.model.RegisterVO;

public class processexcel {
	//1.編號 ,  2.姓名 3.身分證字號  4.生日(yy-mm-ddd) 5.可駕駛機種  6.聯絡電話 7.證號
	//1.regID    2. pilotName     3. pilotID  4.birthday 5.craftID 6.PHONE
	
	XSSFWorkbook wb=null;
	XSSFSheet sheet=null;
	XSSFCell cell;
	XSSFRow row;

		
	//++++寫出資料庫++++
	public  XSSFWorkbook Writeexcel(String classID,Integer classNum) throws FileNotFoundException{
		XSSFWorkbook workBook = new XSSFWorkbook();
		XSSFSheet sheet = workBook.createSheet();
		XSSFCellStyle cs = workBook.createCellStyle();
		cs.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cs.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
		cs.setAlignment(CellStyle.ALIGN_CENTER);
		cs.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		cs.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		cs.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		cs.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		//===============================================
		XSSFCellStyle csdata = workBook.createCellStyle();
		csdata.setAlignment(CellStyle.ALIGN_CENTER);
		csdata.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		csdata.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		csdata.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		csdata.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		
		int  currentRow =1;
		XSSFRow row=sheet.createRow(0);
        row.createCell(0).setCellValue("編號");
		row.createCell(1).setCellValue("姓名");
		row.createCell(2).setCellValue("身分證字號");
		row.createCell(3).setCellValue("生日");
		row.createCell(4).setCellValue("出生年");
		row.createCell(5).setCellValue("可駕駛機種");
		row.createCell(6).setCellValue("連絡電話");
		row.createCell(7).setCellValue("證號");
		row.createCell(8).setCellValue("報名時間");
		for (int i = 0; i <= 8; i++) {
			row.getCell(i).setCellStyle(cs);
			sheet.setColumnWidth(i,4000);
		}
		Set<RegisterVO> set=new RegisterDAO().getRegisterByClass(classID, classNum);
		for(RegisterVO a:set){
			row=sheet.createRow(currentRow);
			String[] str=new String[9];
			str[0]=String.valueOf(currentRow);
			str[1]=a.getPilotVO().getPilotName();
			str[2]=a.getPilotVO().getPilotID();
			str[3]=String.valueOf(a.getPilotVO().getBirthday());
			str[4]=String.valueOf(a.getPilotVO().getBirthday()).substring(0,4);
			str[5]=a.getPilotVO().getAircraftVO().getCraftType();
			str[6]=a.getPilotVO().getPhone();
			str[7]=a.getPilotVO().getCertificateID();
			str[8]=String.valueOf(a.getRegDate()).substring(0,19);
			for (int i = 0; i <=8; i++) {
				row.createCell(i);
				row.getCell(i).setCellStyle(csdata);
				row.getCell(i).setCellValue(str[i]);
			}	
			currentRow++;
		}

		return workBook;
	}
	public static void main(String[] args){
		try {
			new processexcel().Writeexcel( "CECJ", 1 );
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}
