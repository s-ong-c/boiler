package org.zerock.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	
	private static final Logger logger
	= LoggerFactory.getLogger(UploadFileUtils.class);
	
	// 파일의 저장경로
	// 원본파일의 이름
	// 파일데이터  처리
	
	public static String uploadFile(String uploadPath,String originalName,
							byte[] fileData)throws Exception{
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+"_"+originalName;
		String savedPath = calcPath(uploadPath);
		
		File target = new File(uploadPath+savedPath,savedName);
		
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		
		if(MediaUtils.getMediaType(formatName) !=null){
			uploadedFileName = makeThumnail(uploadPath,savedPath, savedName);
		}else{
			uploadedFileName = makeIcon(uploadPath,savedPath,savedName);
		}
		
		return uploadedFileName;
	
	}
	private static String makeIcon(String uploadPath,String path,String fileName)
	throws Exception{
		String iconName = uploadPath + File.separator+fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	// UUID  로 고유값생성
	/// 결합해서업로드파일이름 생성                                                                                                                               
	// 파일 저장될 년 월일 날짜
	// 업로드 기본경로 와 날짜 합치기
	/// 기본경로 폴더 경로 파일이름으로 저장
	
	private static String calcPath(String uploadPath){
		
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		
		String monthPath = yearPath+File.separator+new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath =monthPath+File.separator
						+new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath,yearPath,monthPath,datePath);
		
		logger.info("datePath");
		
		return datePath;
	}
	
	private static void makeDir(String uploadPath,String ...paths){
		if(new File(uploadPath + paths[paths.length-1]).exists()){
			return;
			}
	for(String path :paths){
		File dirPath = new File(uploadPath +path);
		if(! dirPath.exists()){
			dirPath.mkdir();
			}
		}
	}
	//썸네일 생성. 저장된파일이 이미지라면 썸네일 생성 아니면 이름만 반환 
	private static String makeThumnail(
			String uploadPath,
			String  path,
			String fileName)throws Exception{
		BufferedImage sourceImg = 
				ImageIO.read(new File(uploadPath +path,fileName));
		
		BufferedImage destImg =
				Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);
		String thumnailName=
				uploadPath +path+File.separator+"s_"+fileName;
		
		File newFile = new File(thumnailName);
		String formatName = 
				fileName.substring(fileName.lastIndexOf(".")+1);
		ImageIO.write(destImg, formatName.toUpperCase(),newFile);
		
		return thumnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

}
