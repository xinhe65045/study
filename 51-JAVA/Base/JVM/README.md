# JVM解析
- 0X01：ToolBox
    - HSDB
- 0X02：内存管理机制
    - 运行时数据区
    - 对象存储
    - 垃圾收集器
    - 虚拟机性能监控与故障处理工具
- 0X03：执行子系统
    - 类文件结构
    - 类加载机制
    - 字节码执行引擎
- 0X04：编译与代码优化
    - 编译期优化
        - javac编译器
        - 语法糖
        - 插入式注解处理器
    - 运行期优化
        - 即时编译器
        - 编译优化技术
- 0X05：并发
    - JMM与线程
    - 线程安全
    - 锁优化
    
# 性能调优专题
- 性能属性
    - 吞吐量
    - 延迟
    - 内存占用
- 调优原则
    - Minor GC回收原则
    - GC内存最大化原则
    - GC调优3选2原则
- 调优基础
    - 命令行选项及GC日志
    - 确定内存占用
    - HotSpot VM 堆布局
    - 垃圾收集器比较
- 调优延迟/响应性
    - 新生代优化
    - 老年代优化
    - Survivor空间调优
    - CMS延迟调优
- 调优吞吐量
    - CMS吞吐量调优
    - Throughput收集器调优
    - 并行垃圾收集调优
