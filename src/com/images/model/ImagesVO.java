package com.images.model;

import java.io.Serializable;

public class ImagesVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	public ImagesVO(){}
	
	private Integer imageID;
	private String imageName;
	private byte[] image;

	public Integer getImageID() {
		return imageID;
	}
	public void setImageID(Integer imageID) {
		this.imageID = imageID;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}

}
