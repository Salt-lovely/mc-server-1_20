: 此启动脚本由Salt_lovely提供，以CC BY-SA 4.0分发，转载请注明作者及出处

@ECHO off
CHCP 65001

: 服务器名称

SET Name=PaperMC

: 内存分配，建议最大和最小内存保持一致以获得更好的性能

SET MemoryMin=5G
SET MemoryMax=5G

: 启动服务器用的jar文件

SET Jar=paper.jar

: 获取Jvm版本

for /f tokens^=2-5^ delims^=^" %%j in ('java -fullversion 2^>^&1') do set "JavaVer=%%j%%k%%l%%m"

: 设置页面标题

TITLE %Name% 服务器运行中

: 重启时会跳到这里

:start

ECHO =================================================
ECHO +
ECHO +  服务端: %Name%
ECHO +  虚拟机配置:
ECHO +      Java版本: %JavaVer%
ECHO +      目标文件: %Jar%
ECHO +      内存分配: %MemoryMin% - %MemoryMax%
ECHO +  当前时间: %DATE% %TIME%
ECHO +
ECHO =================================================

ECHO.
ECHO.
ECHO 正在启动...
ECHO.
ECHO.

: 启动参数

: -XX:+UseG1GC             启用G1GC收集器

: -XX:MaxGCPauseMillis=100 每次GC所需时间 防止单次GC太久造成可感知卡顿

: -XX:+DisableExplicitGC   阻止代码触发GC

: -XX:+AlwaysPreTouch      要求内存连续 提高访问效率

java -Xms%MemoryMin% -Xmx%MemoryMax% -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -jar %Jar% nogui

: 这里可以配置为重启

: ECHO 检测到服务器退出 将尝试重启

TITLE %Name% 服务器结束运行

: GOTO start

PAUSE