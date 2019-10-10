# JniRegister
JNI注册，是指将java层方法(native关键字修饰的)和C层方法对应起来，以实现java层代码调用c层代码的目的。JNI注册分为静态注册和动态注册两种，静态注册是通过固定格式方法名进行关联，动态注册是通过动态添加映射关系来进行关联，方法名可以随便起，比较灵活，我们推荐使用动态注册。在进行注册前，需要先下载两个工具Clion和eclipse(能写java application就可以)，然后我们就可以开始注册了。
## 目录说明
- doc中有jni基础知识的详细文档
- JavaJni目录为Java层代码，开发环境为eclipse
- CRegister为C层代码，开发环境为Clion
## 静态注册
1. 首先，在eclipse新建一个Java Application，名称可以随意，比如叫JavaJni,然后在src目录下新建一个package名为clz，再clz包下新建java类Register.java，类中写一个native方法如下：
```
package clz;
public class Register {
	native String helloworld();
}
```
2. 进入命令行，来到Register.java所在目录下，使用命令 javac Register.java生成Register.class文件
3. 命令行，回到src目录下，通过命令 javah clz.Register 生成clz_Register.h
4. 在Clion中，新建一个C++ Library，Library type选择shared，并将jdk/include下的jni.h文件和jni_md.h文件拷贝过来
5. 将第三步中生成的clz_Register.h文件拷贝到Clion中刚刚新建的项目中
6. 修改jni.h的引用如下
```
#include "jni.h"
```
7. 新建clz_Register.c文件，引入clz_Register.h，实现.h中对应的函数
```
//clz_Register.c
#include "clz_Register.h"
JNIEXPORT jstring JNICALL Java_clz_Register_helloworld
        (JNIEnv * env, jobject jobject){
    return (*env)->NewStringUTF(env,"helloworld");
}
```
8. 在Clion项目中的CMakeLists.txt中添加编译配置
```
add_library(firstlib SHARED clz_Register.h clz_Register.c)
```
- 第一个参数firstlib，表示编译后生成的动态库名称
- 第二个参数可以选择STATIC或者SHARED，分别表示是静态库还是动态库，一般我们使用动态库
- 第三个及后面的参数，表示需要编译入库的文件
9. 在Clion中选择Build-BuildProject，可以在cmake-build-debug下生成libfirstlib.dylib(mac为dylib，windows为dll)
10. 将第8步生成的libfirstlib.dylib拷贝到eclipse项目的libs目录下(没有可新建)
11. 在Register.java中加载库，并且调用库中函数
```
package clz;
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
```
## 动态注册
1. 首先，在eclipse新建一个Java Application，名称可以随意，比如叫JavaJni,然后在src目录下新建一个package名为register，在register包下新建java类DynamicRegister.java，类中写native方法如下：
```
package register;
public class DynamicRegister {
	native void dynamicFunc1();
	native String dynamicFunc2();
}
```
2. 在Clion中，新建一个C++ Library，Library type选择shared，并将jdk/include下的jni.h文件和jni_md.h文件拷贝过来
3. 新建DynamicRegister.c文件，引入jni.h和实现两个方法，如下
```
#include "jni.h"
void func1(JNIEnv *env,jobject jobject){
    printf("dynamicNative1 动态注册\n");
}
jstring func2(JNIEnv *env,jobject jobject){
    return (*env)->NewStringUTF(env,"hello everybody 2");
}
```
4. 添加动态注册
```
static const char * mClassName = "register/DynamicRegister";
// 三个参数，java层函数名，java层方法签名，c层方法指针
// 获取签名方法：javap -s -p DynamicRegister.class
static const JNINativeMethod mMethods[]={
        {"dynamicFunc1","()V",(void*)func1},
        {"dynamicFunc2","()Ljava/lang/String;",(void*)func2},
};
//java层load时，便会自动调用该方法
JNIEXPORT jint JNICALL
JNI_OnLoad(JavaVM *vm, void *reserved){
    printf("hello dynamic0\n");
    JNIEnv* env = NULL;
//获得 JniEnv
    int r = (*vm)->GetEnv(vm,(void**) &env, JNI_VERSION_1_8);
    if( r != JNI_OK){
        return -1;
    }
    //FindClass,反射，通过类的名字反射出一个
    jclass mainActivityCls = (*env)->FindClass( env,mClassName); // 注册 如果小于0则注册失败
    r = (*env)->RegisterNatives(env,mainActivityCls,mMethods,2);
    if(r != JNI_OK )
    {
        return -1;
    }
    printf("hello dynamic\n");
    return JNI_VERSION_1_8;
}
```
5. 在Clion项目中的CMakeLists.txt中添加编译配置
```
add_library(firstdylib SHARED DynamicRegister.c)
```
- 第一个参数firstlib，表示编译后生成的动态库名称
- 第二个参数可以选择STATIC或者SHARED，分别表示是静态库还是动态库，一般我们使用动态库
- 第三个及后面的参数，表示需要编译入库的文件
6. 在Clion中选择Build-BuildProject，可以在cmake-build-debug下生成libfirstdylib.dylib(mac为dylib，windows为dll)
7. 将第8步生成的libfirstdylib.dylib拷贝到eclipse项目的libs目录下(没有可新建)
8. 在DynamicRegister.java中加载库，并且调用库中函数
```
package register;
public class DynamicRegister {
	native void dynamicFunc1();
	native String dynamicFunc2();
	static {
		System.load("/Users/djx/eclipse-workspace/JavaJni/libs/libfirstdylib.dylib");
	}
	public static void main(String[] args) {
		DynamicRegister dr = new DynamicRegister();
		dr.dynamicFunc1();
		String result=dr.dynamicFunc2();
		System.out.println("dynamicFunc2:"+result+"\n");
	}
}
```

# jni调用java层静态和非静态函数
jni调用java中的函数大致分为以下三个步骤
- 通过(*env)->FindClass找到类的对象
- 通过(*env)->GetMethodID来获取方法Id
- 通过调用(*env)-<CallVoidMethod来调用对应的函数/方法
--------------------------------
## 详细实现步骤
1. 首先编写java层静态和非静态方法
```
package clz;
public class ClassMethod {
	public ClassMethod(){ //构造方法
		System.out.println("ClassMethod() constructor");
	}
	private static void callStaticMethod(String str, int i) { //静态方法
		System.out.format("ClassMethod::callSatticMethod called!-->str=%s,"+
				" i=%d\n", str,i);
	}
	private void callInstanceMethod(String str, int i) { //非静态方法
		System.out.format("ClassMethod::callInstanceMethod called!-->str=%s,"+
				"i=%d\n",str,i);
	}
}
```
2. 编写java层native方法声明，并利用方法注册生成c语言的.h文件，[如何注册请参考](https://blog.csdn.net/qq_23081779/article/details/101674084)
```
public class JniTest {
	native void callJavaStaticMethod();
	native void callJavaInstanceMethod();
}
```
3. 新建.h对应的.c文件，并引入.h文件
- 调用静态方法
```
#include "clz_JniTest.h"
JNIEXPORT void JNICALL Java_clz_JniTest_callJavaStaticMethod
        (JNIEnv *env, jobject jobject){
    //1.找到对应类的class对象
    jclass clz = (*env)->FindClass(env,"clz/ClassMethod");
    if(clz == NULL){
        printf("clz is null");
        return;
    }
    //2.获取方法id
    jmethodID jmeid = (*env)->GetStaticMethodID(env,clz,"callStaticMethod","(Ljava/lang/String;I)V");
    if(jmeid==NULL){
        printf("jmeid is null");
        return;
    }
    jstring  arg = (*env)->NewStringUTF(env,"我是静态类");
    //3.调用java层方法
    (*env)->CallStaticVoidMethod(env,clz,jmeid,arg,100);
    (*env)->DeleteLocalRef(env,clz);
    (*env)->DeleteLocalRef(env,arg);
}
```
- 调用非静态方法
```
JNIEXPORT void JNICALL Java_clz_JniTest_callJavaInstanceMethod
        (JNIEnv * env, jobject jobject0){
	//1.获取类的class对象
    jclass clz = (*env)->FindClass(env,"clz/ClassMethod");
    if(clz == NULL){
        printf("clz is null");
        return;
    }
    //2.获取类的构造方法
    jmethodID jcmid = (*env)->GetMethodID(env,clz,"<init>","()V");
    if(jcmid == NULL){
        printf("jcmid is null");
        return;
    }
    //3.创建对象
    jobject jobject = (*env)->NewObject(env,clz,jcmid);
    if(jobject == NULL){
        printf("jobject is NULL");
        return;
    }
    //4.获取方法id
    jmethodID jmeid = (*env)->GetMethodID(env,clz,"callInstanceMethod","(Ljava/lang/String;I)V");
    if(jmeid==NULL){
        printf("jmeid is null");
        return;
    }
    jstring  arg = (*env)->NewStringUTF(env,"hello from jni");
    //5.调用非静态方法
    (*env)->CallVoidMethod(env,jobject,jmeid,arg,100);
    (*env)->DeleteLocalRef(env,clz);
    (*env)->DeleteLocalRef(env,jobject);
    (*env)->DeleteLocalRef(env,arg);
}
```
