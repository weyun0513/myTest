package com.util;

import java.util.*;

public class CompositeQuery2 {

	private static String get_aCondition(String columnName, String value) {

		String aCondition = null;

		if ("craftID".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("classID".equals(columnName) || "craftType".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("startDate1".equals(columnName) || "endDate1".equals(columnName)){
			aCondition = columnName.substring(0,columnName.length()-1)+">='" + value + "'";
		}
		else if ("startDate2".equals(columnName) || "endDate2".equals(columnName)){
			aCondition = columnName.substring(0,columnName.length()-1)+"<='" + value + "'";
		}
		else if("searchType".equals(columnName)){
			if("3".equals(value)){
				aCondition ="classStatus = '已結訓'";
			} else{			
			aCondition = "2".equals(value)?"classStatus = '已開訓'":"classStatus = '開放報名'";
			}
		}
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		
		Set<String> keys = map.keySet();
		
//		for(String str:keys)
//			System.out.println("key="+str+", value="+map.get(str)[0]);
		
		StringBuffer whereCondition = new StringBuffer();
//		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];

			if (value != null && value.trim().length() != 0	&& !"action".equals(key)
							&& !"pageNum1".equals(key) && !"pageNum2".equals(key) && !"pageNum3".equals(key) && !"rowNum".equals(key) ) {
//				count++;
				String aCondition = get_aCondition(key, value.trim());

//				if (count == 1)
//					whereCondition.append(" WHERE " + aCondition);
//				else
					whereCondition.append(" AND " + aCondition);
			}
		}
		whereCondition.append(" ) AS temp ");
//		System.out.println("whereCondition="+whereCondition);
		return whereCondition.toString();
	}
}
