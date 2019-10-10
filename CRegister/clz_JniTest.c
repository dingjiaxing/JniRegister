//
// Created by 丁家星 on 2019/10/9.
//

#include "clz_JniTest.h"

JNIEXPORT void JNICALL Java_clz_JniTest_callJavaStaticMethod
        (JNIEnv *env, jobject jobject){
    jclass clz = (*env)->FindClass(env,"clz/ClassMethod");
    if(clz == NULL){
        printf("clz is null");
        return;
    }
    jmethodID jmeid = (*env)->GetStaticMethodID(env,clz,"callStaticMethod","(Ljava/lang/String;I)V");
    if(jmeid==NULL){
        printf("jmeid is null");
        return;
    }
    jstring  arg = (*env)->NewStringUTF(env,"我是静态类");
    (*env)->CallStaticVoidMethod(env,clz,jmeid,arg,100);
    (*env)->DeleteLocalRef(env,clz);
    (*env)->DeleteLocalRef(env,arg);
}

JNIEXPORT void JNICALL Java_clz_JniTest_callJavaInstanceMethod
        (JNIEnv * env, jobject jobject0){
    printf("------start Java_clz_JniTest_callJavaInstanceMethod-----\n");
    jclass clz = (*env)->FindClass(env,"clz/ClassMethod");
    if(clz == NULL){
        printf("clz is null");
        return;
    }
    jmethodID jcmid = (*env)->GetMethodID(env,clz,"<init>","()V");
    if(jcmid == NULL){
        printf("jcmid is null");
        return;
    }
    jobject jobject = (*env)->NewObject(env,clz,jcmid);
    if(jobject == NULL){
        printf("jobject is NULL");
        return;
    }
    printf("------GetMethodID before Java_clz_JniTest_callJavaInstanceMethod-----\n");
    jmethodID jmeid = (*env)->GetMethodID(env,clz,"callInstanceMethod","(Ljava/lang/String;I)V");
    printf("------GetMethodID after Java_clz_JniTest_callJavaInstanceMethod-----\n");
    if(jmeid==NULL){
        printf("jmeid is null");
        return;
    }
    jstring  arg = (*env)->NewStringUTF(env,"hello from jni");
    printf("------CallVoidMethod before Java_clz_JniTest_callJavaInstanceMethod-----\n");
    (*env)->CallVoidMethod(env,jobject,jmeid,arg,100);
    printf("------CallVoidMethod after Java_clz_JniTest_callJavaInstanceMethod-----\n");
    (*env)->DeleteLocalRef(env,clz);
    (*env)->DeleteLocalRef(env,jobject);
    (*env)->DeleteLocalRef(env,arg);
    printf("------end Java_clz_JniTest_callJavaInstanceMethod-----\n");
}

JNIEXPORT jstring JNICALL Java_clz_JniTest_refrenceNewString
        (JNIEnv * env , jobject jobj, jint jlen){
    jcharArray  elemArray;
    jchar *chars = NULL;
    jstring  j_str = NULL;
    static jclass cls_string = NULL;
    static jmethodID  cid_string = NULL;

    if(cls_string == NULL){
        printf("cls_string is null \n");
        cls_string = (*env)->FindClass(env,"java/lang/String");
        if(cls_string == NULL){
            return NULL;
        }
    }

    if(cid_string == NULL){
        printf("cid_string is null \n");
        cid_string = (*env)->GetMethodID(env,cls_string,"<init>","([C)V");
        if(cid_string == NULL){
            return NULL;
        }
    }
    printf("this is a line----------\n");

    elemArray = (*env)->NewCharArray(env,jlen);
    j_str = (*env)->NewObject(env,cls_string,cid_string,elemArray);

    (*env)->DeleteLocalRef(env,elemArray);

    (*env)->DeleteLocalRef(env,cls_string);
    cls_string = NULL;
    //此处的delete不能存在，因为cid_string不是jobject，应用只需要对jobject类型的引用而言
//    (*env)->DeleteLocalRef(env,cid_string);

    printf("end of function\n");

    return j_str;

}