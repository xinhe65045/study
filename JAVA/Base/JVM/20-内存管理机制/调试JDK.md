# 踩坑记录
- 关闭Werror
```
    ./configure --disable-warnings-as-errors 
```

- [已安装freetype但提示 error could not find freetype](https://github.com/matplotlib/matplotlib/issues/3029/) 
```
    ln -s /usr/include/freetype2/ft2build.h /usr/include/
```

# 相关资料
- [支持编译的平台](https://wiki.openjdk.java.net/display/Build/Supported+Build+Platforms)


./configure --with-target-bits=64 --enable-ccache --with-jvm-variants=server,client --with-boot-jdk-jvmargs="-Xlint:deprecation -Xlint:unchecked" --with-native-debug-symbols=zipped --disable-warnings-as-errors --with-debug-level=slowdebug 2>&1 | tee configure_mac_x64.log

作者：Virson
链接：https://www.jianshu.com/p/26bd050610a4
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


./configure --with-target-bits=64 --with-freetype=/usr/local/Cellar/freetype/2.6.3 --enable-ccache --with-jvm-variants=server,client --with-boot-jdk-jvmargs="-Xlint:deprecation -Xlint:unchecked" --with-native-debug-symbols=zipped --disable-warnings-as-errors --with-debug-level=slowdebug 2>&1 | tee configure_mac_x64.log

作者：qiyekun
链接：https://www.jianshu.com/p/0b6d5b83ee17
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。