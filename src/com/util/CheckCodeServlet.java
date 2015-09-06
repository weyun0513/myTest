package com.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/CheckCode")
public class CheckCodeServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static int WIDTH = 60;
	private static int HEIGHT = 20;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("image/jpeg");
		ServletOutputStream sos = response.getOutputStream();
		
		//設置瀏覽器不要緩存此圖片
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		
		//創建內存圖像並獲得其圖形上下文
		BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		
		//產生隨機的驗證碼
		char[] rands = generateCheckCode();
		
		//產生圖像
		drawBackground(g);
		drawRands(g, rands);
		
		//結束圖像的繪制過程，完成圖像
		g.dispose();
		
		//將圖像輸出到客戶端
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		ImageIO.write(image, "JPEG", bos);
		byte[] buf = bos.toByteArray();
		response.setContentLength(buf.length);
		sos.write(buf);
		bos.close();
		sos.close();
		
		//將當前驗證碼存入到session中
		session.setAttribute("check_code", new String(rands));
//		 session.setMaxInactiveInterval(20);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	private char[] generateCheckCode() {
		//定義驗證碼的字符集
		String chars = "23456789abcdefghjkmnpqrstuvwxyz";
		char[] rands = new char[4];
		for(int i = 0; i < 4; i++) {
			int rand = (int)(Math.random() * chars.length());
			rands[i] = chars.charAt(rand);
		}
		return rands;
	}
	
	private void drawRands(Graphics g, char[] rands) {
		g.setColor(Color.BLACK);
		g.setFont(new Font(null,Font.ITALIC|Font.BOLD,18));
		//在不同的高度上輸出驗證碼的每個字符
		g.drawString("" + rands[0], 1, 17);
		g.drawString("" + rands[1], 16, 15);
		g.drawString("" + rands[2], 31, 18);
		g.drawString("" + rands[3], 46, 16);
	}
	
	private void drawBackground(Graphics g) {
		//畫背景
		g.setColor(new Color(0xDCDCDC));
		g.fillRect(0, 0, WIDTH, HEIGHT);
		//隨機產生120個幹擾點 
		for(int i = 0; i < 120; i++) {
			int x = (int)(Math.random() * WIDTH);
			int y = (int)(Math.random() * HEIGHT);
			int red = (int)(Math.random() * 255);
			int green = (int)(Math.random() * 255);
			int blue = (int)(Math.random() * 255);
			g.setColor(new Color(red, green, blue));
			g.drawOval(x, y, 1, 0);
		}
	}

}
