package org.zerock.persistence;

import org.zerock.domain.MessageVO;

public interface MessageDAO {
	public void create(MessageVO vo)throws Exception;   //  메세지 생
	public MessageVO readMessage(Integer mid) throws Exception;    // 읽기 
	public void updateState(Integer mid) throws Exception;
	

}
