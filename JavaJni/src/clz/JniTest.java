package clz;

public class JniTest {
	
	static {
		System.load("/Users/djx/eclipse-workspace/JavaJni/libs/libjnitestlib.dylib");
	}
	
	native void callJavaStaticMethod();
	native void callJavaInstanceMethod();
	
	native String refrenceNewString(int len);
	
	public static void main(String[] args) {
		
		JniTest test = new JniTest();
		
//		test.callJavaStaticMethod();
		test.callJavaInstanceMethod();
		
//		test.refrenceNewString(10);
//		test.refrenceNewString(10);
	}
}
