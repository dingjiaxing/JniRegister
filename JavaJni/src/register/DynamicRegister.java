package register;

/**
 * jni动态注册
 * @author djx
 *
 */
public class DynamicRegister {
	
	native void dynamicFunc1();
	native String dynamicFunc2();
	
	static {
		System.load("/Users/djx/eclipse-workspace/JavaJni/libs/libfirstdylib.dylib");
		
//		System.load("/Users/djx/eclipse-workspace/JavaJni/libs/libRegister.dylib");
	}
	
	public static void main(String[] args) {
		DynamicRegister dr = new DynamicRegister();
		dr.dynamicFunc1();
		String result=dr.dynamicFunc2();
		System.out.println("dynamicFunc2:"+result+"\n");
	}
	
}
