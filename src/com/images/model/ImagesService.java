package com.images.model;

import java.util.List;

public class ImagesService {
	private ImagesDAO_interface dao;
	public ImagesService(){
		dao=new ImagesDAO();
	}
	
	public ImagesVO insertImage(String imageName,byte[] image){
		ImagesVO imagesVO=new ImagesVO();
		imagesVO.setImageName(imageName);
		imagesVO.setImage(image);
		dao.insert(imagesVO);
		return imagesVO;
		
	}
	public ImagesVO updateImage(Integer imageID,String imageName,byte[] image){
		ImagesVO imagesVO=new ImagesVO();
		imagesVO.setImageID(imageID);
		imagesVO.setImageName(imageName);
		imagesVO.setImage(image);
		dao.insert(imagesVO);
		return imagesVO;	
		
	}
	public void deleteImage(Integer imageID){
		dao.delete(imageID);
	}
	public ImagesVO getOneImage(Integer imageID){
		return dao.findByPrimaryKey(imageID);
	}
	public List<ImagesVO> getAllImages(){
		return dao.getAll();
	}
	
	public int count(){
		return dao.count();
	}

}
