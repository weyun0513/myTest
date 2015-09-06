package com.images.model;

import java.util.List;


public interface ImagesDAO_interface {

	public void insert(ImagesVO imagesVO);
	public void update(ImagesVO imagesVO);
	public void delete(Integer imageID);
	public ImagesVO findByPrimaryKey(Integer imageID);
	public List<ImagesVO> getAll();
	public int count();
	
}
