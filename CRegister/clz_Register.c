//
// Created by 丁家星 on 2019/9/27.
//
#include "clz_Register.h"

JNIEXPORT jstring JNICALL Java_clz_Register_helloworld
        (JNIEnv * env, jobject jobject){
    return (*env)->NewStringUTF(env,"helloworld");
}


