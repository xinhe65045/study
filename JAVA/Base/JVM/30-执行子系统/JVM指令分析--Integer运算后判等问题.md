Constant pool:
   #1 = Methodref          #7.#29         // java/lang/Object."<init>":()V
   #2 = Methodref          #30.#31        // java/lang/Integer.valueOf:(I)Ljava/lang/Integer;
   #3 = Fieldref           #32.#33        // java/lang/System.out:Ljava/io/PrintStream;
   #4 = Methodref          #30.#34        // java/lang/Integer.intValue:()I
   #5 = Methodref          #35.#36        // java/io/PrintStream.println:(Z)V
   #6 = Class              #37            // com/geely/ds/ehr/facade/sdk/dto/Test
   #7 = Class              #38            // java/lang/Object
   #8 = Utf8               <init>
   #9 = Utf8               ()V
  #10 = Utf8               Code
  #11 = Utf8               LineNumberTable
  #12 = Utf8               LocalVariableTable
  #13 = Utf8               this
  #14 = Utf8               Lcom/geely/ds/ehr/facade/sdk/dto/Test;
  #15 = Utf8               main
  #16 = Utf8               ([Ljava/lang/String;)V
  #17 = Utf8               args
  #18 = Utf8               [Ljava/lang/String;
  #19 = Utf8               a
  #20 = Utf8               Ljava/lang/Integer;
  #21 = Utf8               b
  #22 = Utf8               c
  #23 = Utf8               StackMapTable
  #24 = Class              #18            // "[Ljava/lang/String;"
  #25 = Class              #39            // java/lang/Integer
  #26 = Class              #40            // java/io/PrintStream
  #27 = Utf8               SourceFile
  #28 = Utf8               Test.java
  #29 = NameAndType        #8:#9          // "<init>":()V
  #30 = Class              #39            // java/lang/Integer
  #31 = NameAndType        #41:#42        // valueOf:(I)Ljava/lang/Integer;
  #32 = Class              #43            // java/lang/System
  #33 = NameAndType        #44:#45        // out:Ljava/io/PrintStream;
  #34 = NameAndType        #46:#47        // intValue:()I
  #35 = Class              #40            // java/io/PrintStream
  #36 = NameAndType        #48:#49        // println:(Z)V
  #37 = Utf8               com/geely/ds/ehr/facade/sdk/dto/Test
  #38 = Utf8               java/lang/Object
  #39 = Utf8               java/lang/Integer
  #40 = Utf8               java/io/PrintStream
  #41 = Utf8               valueOf
  #42 = Utf8               (I)Ljava/lang/Integer;
  #43 = Utf8               java/lang/System
  #44 = Utf8               out
  #45 = Utf8               Ljava/io/PrintStream;
  #46 = Utf8               intValue
  #47 = Utf8               ()I
  #48 = Utf8               println
  #49 = Utf8               (Z)V


LocalVariableTable: 本地变量表
        Start  Length  Slot  Name   Signature
            0      75     0  args   [Ljava/lang/String;
            7      68     1     a   Ljava/lang/Integer;
           13      62     2     b   Ljava/lang/Integer;
           20      55     3     c   Ljava/lang/Integer;


public static void main(java.lang.String[]);
    descriptor: ([Ljava/lang/String;)V
    flags: ACC_PUBLIC, ACC_STATIC
    Code:
      stack=4, locals=4, args_size=1
         0: sipush        170                 // 将一个短整型常量值(-32768~32767) 170 推送至栈顶
         3: invokestatic  #2                  // #2 = Methodref #30.#31 java/lang/Integer.valueOf:(I)Ljava/lang/Integer; 创建一个Integer对象
         6: astore_1                          // 将栈顶引用型数值存入第二个本地变量 a
         7: bipush        90                  // 将单字节的常量值(-128~127) 90 推送至栈顶
         9: invokestatic  #2                  // #2 = Methodref #30.#31 java/lang/Integer.valueOf:(I)Ljava/lang/Integer; 创建一个Integer对象
        12: astore_2                          // 将栈顶引用型数值存入第三个本地变量 b
        13: sipush        260                 // 将一个短整型常量值(-32768~32767) 260 推送至栈顶
        16: invokestatic  #2                  // Method java/lang/Integer.valueOf:(I)Ljava/lang/Integer; 创建一个Integer对象
        19: astore_3                          // 将栈顶引用型数值存入第四个本地变量 c
        20: getstatic     #3                  // #3 = Fieldref #32.#33 java/lang/System.out:Ljava/io/PrintStream;获取指定类的静态域，并将其值压入栈顶
        23: aload_3                           // 将第四个引用类型本地变量推送至栈顶 c
        24: invokevirtual #4                  // #4 = Methodref #30.#34 java/lang/Integer.intValue:()I 执行栈顶（c） 的 c.intValue() 
        27: aload_2                           // 将第三个引用类型本地变量推送至栈顶 b
        28: invokevirtual #4                  // #4 = Methodref #30.#34 java/lang/Integer.intValue:()I 执行栈顶（b） 的 b.intValue() 
        31: aload_1                           // 将第二个引用类型本地变量推送至栈顶 a
        32: invokevirtual #4                  // #4 = Methodref #30.#34 java/lang/Integer.intValue:()I 执行栈顶（a） 的 a.intValue() 
        35: iadd                              // 将栈顶两int型数值相加并将结果压入栈顶 a+b 
        36: if_icmpne     43                  // 比较栈顶两int型数值大小，当结果不等于0时跳转 c == a+b
        39: iconst_1                          // 将int型(1)推送至栈顶
        40: goto          44                  // 无条件跳转
        43: iconst_0                          // 将int型(0)推送至栈顶
        44: invokevirtual #5                  // #5 = Methodref  #35.#36 // java/io/PrintStream.println:(Z)V
        45: return
