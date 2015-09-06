package com.images.model;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ImagesDAO implements ImagesDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/ProjectDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(INSERT);
			pstmt.setNString(1, imagesVO.getImageName());
			pstmt.setBytes(2, imagesVO.getImage());
			pstmt.executeUpdate();
		} catch (SQLException e) {
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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(UPDATE);
			pstmt.setNString(1, imagesVO.getImageName());
			pstmt.setBytes(2, imagesVO.getImage());
			pstmt.setInt(3, imagesVO.getImageID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(DELETE);
			pstmt.setInt(1, imageID);
			pstmt.executeUpdate();

		} catch (SQLException e) {
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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(GET_ONE);
			pstmt.setInt(1, imageID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				imagesVO = new ImagesVO();
				imagesVO.setImageID(rs.getInt("imageID"));
				imagesVO.setImageName(rs.getNString("imageName"));
				imagesVO.setImage(rs.getBytes("image"));
			}
		} catch (SQLException e) {
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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				imagesVO = new ImagesVO();
				imagesVO.setImageID(rs.getInt("imageID"));
				imagesVO.setImageName(rs.getNString("imageName"));
				imagesVO.setImage(rs.getBytes("image"));
				list.add(imagesVO);
			}
		} catch (SQLException e) {
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
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(COUNT);
			rs = pstmt.executeQuery();
			while (rs.next())
				count = rs.getInt("count");
		} catch (SQLException e) {
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

}
