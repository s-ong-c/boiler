package org.zerock.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	
	private static Map<String, MediaType> mediaMap;
	
	static{
		mediaMap= new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	public static MediaType getMediaType(String type){
		return mediaMap.get(type.toUpperCase());
	}

}


/* 게시물 첨부 파일 기능 
 * 첨부 파일 업로드 처리
 *Ajax 를 이용해서 파일 업로드
 파일 조회 및 다운로드 
 
 사용자가  업로드하는 시간에 따른 자동적인 폴더 생성 하고
 업로드 되는 파일의 고유한 이름 생성
 이미지 파일의 업로드 시 썸네일 이미지생성
 이미지 파일의 경우 서버에서 저장된 파일을읽어서 적당한 MIME 타입으로 서비스 
 일반 파일의 경우 다운로드 타입으로 파일 데이터 서비스 
 
 */