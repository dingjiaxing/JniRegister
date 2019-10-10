package clz;

public class ClassMethod {
	public ClassMethod(){
		System.out.println("ClassMethod() constructor");
	}
	private static void callStaticMethod(String str, int i) {
		System.out.format("ClassMethod::callSatticMethod called!-->str=%s,"+
				" i=%d\n", str,i);
	}
	
	private void callInstanceMethod(String str, int i) {
		System.out.format("ClassMethod::callInstanceMethod called!-->str=%s,"+
				"i=%d\n",str,i);
	}
}
