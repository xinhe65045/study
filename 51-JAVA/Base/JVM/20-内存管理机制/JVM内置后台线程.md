# Hotspot JVM 主要的后台线程包括：

- VM thread:
    ```
    这个线程专门用于处理那些需要等待JVM满足safe-point条件的操作。safe-point代表现在没有修改heap的操作发生。这种类型的操作包括：”stop-the-world”类型的GC，thread stack dump，线程挂起，或撤销对象偏向锁(biased locking revocation)
    ```
- Periodic task thread: 
    ```
    用于处理周期性事件（如：中断）的线程
    ```
- GC threads:
    ```
    JVM中，用于支持不同阶段的GC操作的线程
    ```
- Compiler threads:
    ```
    用于在运行时，将字节码编译为本地代码的线程
    ```
    - CompilerThread0
    - CompilerThread1
- Signal dispatcher thread:
    ```
    接受发送给JVM处理的信号，并调用对应的JVM方法
    ```

# 待整理    
- JNI global references count
- Java Heap utilization view
- Low Memory Detector
- Finalizer
- Reference Handler

