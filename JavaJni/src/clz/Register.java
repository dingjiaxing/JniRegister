package clz;

/**
 * jni静态注册
 * @author djx
 *
 */
public class Register {
	
	static {
		System.load("/Users/djx/eclipse-workspace/JavaJni/libs/libfirstlib.dylib");
	}
	
	native String helloworld();
	
	public static void main(String[] args) {
		
		Register re = new Register();
		
		System.out.println(re.helloworld());
	}
}
