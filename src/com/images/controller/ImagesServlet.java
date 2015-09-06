package com.images.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.images.model.ImagesService;
import com.images.model.ImagesVO;


public class ImagesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ImagesService imagesSvc=new ImagesService();
		
		byte[] buff=null;
		ImagesVO imagesVO;
		OutputStream os=null;
		int count=imagesSvc.count();
		int imageID=((int)(Math.random()*count))+1;
		request.setAttribute("imageID", imageID);
		imagesVO=imagesSvc.getOneImage(imageID);
		//System.out.println(imagesVO.getImageName());
		try {			
			buff=new byte[imagesVO.getImage().length];
			buff=imagesVO.getImage();
			os=response.getOutputStream();
			os.write(buff);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(os!=null)
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}

	} 
		


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
