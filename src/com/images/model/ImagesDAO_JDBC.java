package com.images.model;

import java.util.ArrayList;
//import java.io.*;
import java.util.List;
import java.sql.*;

public class ImagesDAO_JDBC implements ImagesDAO_interface {

	private String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private String user = "sa";
	private String password = "P@ssw0rd";
	private String url = "jdbc:sqlserver://localhost:1433;DataBaseName=ProjectAir";

	private static final String INSERT = "INSERT INTO Images VALUES(?,?)";
	private static final String UPDATE = "UPDATE Images SET imageName=? AND image=? WHERE imageID=?";
	private static final String DELETE = "DELETE Images WHERE imageID=?";
	private static final String GET_ONE = "SELECT * FROM Images WHERE imageID=?";
	private static final String GET_ALL = "SELECT * FROM Images";
	private static final String COUNT = "SELECT COUNT(*) AS count FROM Images";

	@Override
	public void insert(ImagesVO imagesVO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setNString(1, imagesVO.getImageName());
			pstmt.setBytes(2, imagesVO.getImage());
			pstmt.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

	@Override
	public void update(ImagesVO imagesVO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(UPDATE);
			pstmt.setNString(1, imagesVO.getImageName());
			pstmt.setBytes(2, imagesVO.getImage());
			pstmt.setInt(3, imagesVO.getImageID());
			pstmt.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

	@Override
	public void delete(Integer imageID) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setInt(1, imageID);
			pstmt.executeUpdate();

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

	@Override
	public ImagesVO findByPrimaryKey(Integer imageID) {
		ImagesVO imagesVO = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(GET_ONE);
			pstmt.setInt(1, imageID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				imagesVO = new ImagesVO();
				imagesVO.setImageID(rs.getInt("imageID"));
				imagesVO.setImageName(rs.getNString("imageName"));
				imagesVO.setImage(rs.getBytes("image"));
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return imagesVO;
	}

	@Override
	public List<ImagesVO> getAll() {
		List<ImagesVO> list = new ArrayList<ImagesVO>();
		ImagesVO imagesVO = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				imagesVO = new ImagesVO();
				imagesVO.setImageID(rs.getInt("imageID"));
				imagesVO.setImageName(rs.getNString("imageName"));
				imagesVO.setImage(rs.getBytes("image"));
				list.add(imagesVO);
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return list;
	}

	@Override
	public int count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(COUNT);
			rs = pstmt.executeQuery();
			while(rs.next())
				count = rs.getInt("count");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}

		}
		return count;
	}

//	public static void main(String args[]) {
//		ImagesDAO_JDBC dao = new ImagesDAO_JDBC();
//		byte[] buff = null;
//		ImagesVO imagesVO = null;
//		File in = null;
//		FileInputStream fis = null;
//		System.out.println(dao.count());
//		 dao.delete(1);
//		for (int i = 0; i < args.length; i++) {
//			try {
//				imagesVO = new ImagesVO();
//				in = new File("C:\\Users\\Administrator\\Desktop\\new", args[i]);
//				fis = new FileInputStream(in);
//				buff = new byte[(int) in.length()];
//				fis.read(buff);
//			} catch (FileNotFoundException e) {
//				e.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			} finally {
//				if (fis != null)
//					try {
//						fis.close();
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//			}
//
//			imagesVO.setImageName(args[i]);
//			imagesVO.setImage(buff);
//			dao.insert(imagesVO);
//
//			FileOutputStream fos = null;
//			fis = null;
//			imagesVO = dao.findByPrimaryKey(i + 2);
//			try {
//
//				int length = imagesVO.getImage().length;
//				buff = imagesVO.getImage();
//				fos = new FileOutputStream(new File("D:\\JAVA\\images",
//						imagesVO.getImageName()));
//				fos.write(buff, 0, length);
//			} catch (FileNotFoundException e) {
//				e.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			} finally {
//				if (fos != null)
//					try {
//						fos.close();
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//			}
//
//		}
//	}

}
