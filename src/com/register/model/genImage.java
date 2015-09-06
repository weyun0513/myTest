package com.register.model;

import java.awt.Color;
import java.awt.Font;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class genImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
     //產生幾個字  
	int codelength=5;
   
	private static final String MAP = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final Random r = new Random();

	Color radcolor=new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException
	{
		this.doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException
	{
		
		resp.setContentType("image/jpeg");
		
		StringBuffer b = new StringBuffer();
		String s="";
		//隨機產生字元最後才組成字串
		for(int i=0;i<codelength;i++){
			s= Character.toString(MAP.charAt(r.nextInt(MAP.length())));	
					b.append(s);
				}
		// 存入session
		req.getSession(true).setAttribute("checkcode", b.toString().toLowerCase());

		int width = 200;
		int height = 40;

		// 形成圖片型態
		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		// 创建该图片的绘图对象
		Graphics2D g = image.createGraphics();
		
		g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
		// 背景色
		g.drawRect(0,0, width, height);
		g.fillRect(0,0, width, height);
		Font font = new Font("calibri", Font.PLAIN, 50);
		g.setFont(font);

		// 随机干扰
		for (int i = 0; i < codelength; i++)
		{
			g.setColor(radcolor);
			g.drawLine(r.nextInt(width), r.nextInt(height), r.nextInt(width),
					r.nextInt(height));
		}

		// 驗證碼放到圖片
		for (int i = 0; i < 5; i++)
		{
		
			g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
			String showec = Character.toString(b.toString().charAt(i));
			g.drawString(showec, 40 * i +10, height - 6);
		}

		// 輸出頁面
		ServletOutputStream out = resp.getOutputStream();
		// 輸出圖片
		ImageIO.write(image, "jpeg", out);
		
	}
}