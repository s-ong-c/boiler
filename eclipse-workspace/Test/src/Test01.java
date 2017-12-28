			
	
		class Test01 {
				public static void main(String[] args) {
					ThreadTest1 t1 = new ThreadTest1();
			 
					Runnable r = new ThreadTest2();
					Thread t2 = new Thread(r);	
			 
					t1.start();
					t2.start();
				}
			}
			 
			class ThreadTest1 extends Thread {
				@Override
				public void run() {
			 
					for(int i =0;i<5;i++) {
						System.out.println(getName());
					}
				}
			 
			}
			class ThreadTest2 implements Runnable {
				@Override
				public void run() {
					for(int i = 0;i<5;i++) {
						System.out.println(Thread.currentThread().getName());
					}
				}
			}