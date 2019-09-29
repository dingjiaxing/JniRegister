# JniRegister
JNI注册，是指将java层方法(native关键字修饰的)和C层方法对应起来，以实现java层代码调用c层代码的目的。JNI注册分为静态注册和动态注册两种，静态注册是通过固定格式方法名进行关联，动态注册是通过动态添加映射关系来进行关联，方法名可以随便起，比较灵活，我们推荐使用动态注册。在进行注册前，需要先下载两个工具Clion和eclipse(能写java application就可以)，然后我们就可以开始注册了。
## 目录说明
- doc中有jni基础知识的详细文档
- JavaJni目录为Java层代码
- CRegister为C层代码
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
