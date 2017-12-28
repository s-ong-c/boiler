import java.awt.Frame;
import java.awt.Menu;
import java.awt.MenuBar;
import java.awt.MenuItem;

import mylistenerex.MyMenu;
import mylistenerex.MyWin;



public class MenuTest {

	public static void main(String[] args) {
		//프레임에 메뉴를 붙이자
		Frame f=new Frame("메뉴");
		f.setSize(300,200);
		
		MenuBar mb= new MenuBar();
		
		Menu mFile = new Menu("파일");
		MenuItem miNew = new MenuItem("New");
		MenuItem miOpen = new MenuItem("Open");
		MenuItem miSave = new MenuItem("Save");
		
		Menu print = new Menu("Print");
		MenuItem printSetup = new MenuItem("프린트 셋업");
		MenuItem printPre = new MenuItem("미리보기");
		print.add(printSetup);
		print.add(printPre);
		
		MenuItem miClose = new MenuItem("Close");
		
		mFile.add(miNew);
		mFile.add(miOpen);
		mFile.add(miSave);
		mFile.add(print);
		mFile.add(miClose);
		
		
		mb.add(mFile);
		
		
		//메뉴를 설정할 때는 add 시키지 않는다.
		//만들어 놓은 메뉴를 교체한다!!!
		f.setMenuBar(mb);
		
		
		
		f.setVisible(true);
		
		
		f.addWindowListener(new MyWin());
		mFile.addActionListener(new MyMenu());
		printSetup.addActionListener(new MyMenu());
		miClose.addActionListener(new MyMenu());
	}

}
