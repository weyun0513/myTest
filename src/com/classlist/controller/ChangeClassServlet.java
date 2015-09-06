package com.classlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.classlist.model.ClassListService;
import com.classlist.model.ClassListVO;
import com.util.CompositeQuery2;

@WebServlet("/ChangeClassServlet")
public class ChangeClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangeClassServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
//			String action = request.getParameter("action");
//			String url="changeClass.jsp";


			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out=response.getWriter();
			
			int rowNum;

			ClassListService classListSvc = new ClassListService();
			String whereCondition = CompositeQuery2.get_WhereCondition(request
					.getParameterMap());
			whereCondition = " where startDate >= DATEADD(DAY,7,GETDATE()) and classStatus = '開放報名' "+whereCondition;
//			System.out.println(whereCondition);
			int count;
			try {
				count = classListSvc.getCount(whereCondition);
			} catch (Exception e1) {
				count=0;
			}
			//System.out.println("count="+count);
			try {
				rowNum = Integer.parseInt(request.getParameter("rowNum"));
			} catch (NumberFormatException e) {
				rowNum = 10;
				if (rowNum < 10)
					rowNum = 10;
				if (rowNum > 30)
					rowNum = 30;
			}
			
//			System.out.println("rowNum="+rowNum);
			int totalPage = count / rowNum + ((count % rowNum == 0) ? 0 : 1);
			//System.out.println("totalPage="+totalPage);
							
		
			
			int pageNum1=1;

			int pageNum=1;

			try {
				pageNum1 = Integer.parseInt(request.getParameter("pageNum1"));
//				pageNum2 = Integer.parseInt(request.getParameter("pageNum2"));
//				pageNum3 = Integer.parseInt(request.getParameter("pageNum3"));

//				if (searchType == 3) {
//					pageNum = pageNum3;
//				} else {
//					pageNum = (searchType == 2) ? pageNum2 : pageNum1;
//				}
				pageNum = pageNum1;
				if (pageNum < 1)
					pageNum = 1;
				if (pageNum > totalPage)
					pageNum = totalPage;

			} catch (NumberFormatException e) {
				 e.printStackTrace();
				pageNum = 1;
			}


				pageNum1 = pageNum;
//				System.out.println("pageNum1="+pageNum1);
//				System.out.println("pageNum="+pageNum);

			String rowCondition = " WHERE row BETWEEN "
					+ ((pageNum - 1) * rowNum + 1) + " AND "
					+ (pageNum * rowNum);
//			System.out.println(whereCondition+rowCondition);

			List<ClassListVO> list = classListSvc.searchClass(whereCondition
					+ rowCondition);

			JsonArrayBuilder builder = Json.createArrayBuilder();
			try {
				JsonObject obj1 = Json.createObjectBuilder()
						.add("hasMoreData", true).build();
				builder.add(obj1);
				JsonObject obj2=Json.createObjectBuilder()
						.add("sysTime", System.currentTimeMillis())
						.add("pageNum1", pageNum1)
						.add("count", count)
						.add("rowNum", rowNum)
						.add("totalPage",totalPage)
						.build();
				builder.add(obj2);
//				System.out.println("obj2  builder.build().toString()"+builder.build().toString());
				for(ClassListVO classListVO:list){
				JsonObject obj = Json.createObjectBuilder()
						.add("craftID", classListVO.getClassTypeVO().getAircraftVO().getCraftID())
						.add("craftType", classListVO.getClassTypeVO().getAircraftVO().getCraftType())
						.add("classID", classListVO.getClassTypeVO().getClassID())
						.add("classNum", classListVO.getClassNum())
						.add("classStatus", classListVO.getClassStatus())
						.add("startDate", classListVO.getStartDate().toString())
						.add("endDate",  classListVO.getEndDate().toString())
						.add("maxNum", classListVO.getMaxNum())
						.add("regNum", classListVO.getRegNum())
						.add("classSchedule", classListVO.getClassSchedule())			
						.build();
				builder.add(obj);
//				System.out.println("builder.build().toString()" + builder.build().toString());
//				System.out.println("obj.toString()"+obj.toString());
				}
//				System.out.println("builder.toString()"+builder.toString());
//				System.out.println("builder.build().toString()"+builder.build().toString());
				out.write(builder.build().toString());
				out.close();
				return;
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
			
	}
}


		
			
//		int rowNum;
//		int pageNum;
//		ClassListService classListSvc = new ClassListService();
//		String whereCondition = CompositeQuery.get_WhereCondition(request
//				.getParameterMap());
//		whereCondition = " where startDate >= DATEADD(DAY,7,GETDATE()) "+whereCondition;
//		System.out.println(whereCondition);
//		
//		int count;
//		try {
//			count = classListSvc.getCount(whereCondition);
//		} catch (Exception e1) {
//			count=0;
//		}
//
//		try {
//			rowNum = Integer.parseInt(request.getParameter("rowNum"));
//		} catch (NumberFormatException e) {
//			 //e.printStackTrace();
//			rowNum = 10;
//			if (rowNum < 10)
//				rowNum = 10;
//			if (rowNum > 30)
//				rowNum = 30;
//		}
//		
//		//System.out.println("rowNum="+rowNum);
//		int totalPage = count / rowNum + ((count % rowNum == 0) ? 0 : 1);
//		//System.out.println("totalPage="+totalPage);
//		
//		
////		String searchType=request.getParameter("searchType");
//		
////		String countStr="count"+searchType;
////		String pageNumStr="pageNum"+searchType;
////		String totalPageStr="totalPage"+searchType;
//		try {
//			pageNum = Integer.parseInt(request.getParameter("pageNum"));
//			if (pageNum < 1)
//				pageNum = 1;
//			if (pageNum > totalPage)
//				pageNum = totalPage;
//		} catch (NumberFormatException e) {
//			pageNum = 1;
//		}
//
//		request.setAttribute("count", count);
//
//		// System.out.println("pageNum="+pageNum);
//
//		String rowCondition = " WHERE row BETWEEN "
//				+ ((pageNum - 1) * rowNum + 1) + " AND "
//				+ (pageNum * rowNum);
////		System.out.println("Condition="+rowCondition);
//		request.setAttribute("totalPage", totalPage);
//		List<ClassListVO> list = classListSvc.searchClass(whereCondition
//				+ rowCondition);
//		//System.out.println(list);
//		request.setAttribute("list", list);
//		String url = "changeClass.jsp";
//		RequestDispatcher disp = request.getRequestDispatcher(url);
//		disp.forward(request, response);

