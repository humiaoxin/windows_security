@echo off
chcp 65001 > nul
:MENU
cls
echo 请选择要执行的操作：
echo 1.列出系统版本
echo 2.列出系统可登录账户
echo 3.列出所有用户定时任务
echo 4.列出外链的IP和进程
echo 5.列出RDP登录成功的用户详情
echo 6.列出自启动的文件
echo 7.列出n天内被修改的文件
echo 8.列出进程列表
echo Q.退出

set /p choice=选择操作:

if "%choice%"=="1" (
    echo 系统版本:
    ver
    echo.
    pause
    goto MENU
)

if "%choice%"=="2" (
    echo 系统可登录账户:
    net user
    echo.
    pause
    goto MENU
)

if "%choice%"=="3" (
    echo 所有用户的定时任务:
    schtasks /query /fo list /v
    echo.
    pause
    goto MENU
)

if "%choice%"=="4" (
    echo 外链的IP和进程:
    netstat -ano | findstr /v "127.0.0.1" | findstr /v "0.0.0.0" | findstr  /v ":80 :443" | findstr /v "\[::\]" | findstr /v "\[::1\]"
    echo.
    pause
    goto MENU
)



if "%choice%"=="5" (
    echo RDP登录成功的用户:
    powershell.exe -Command "Get-WinEvent -FilterHashtable @{LogName='Security';Id=4624} -MaxEvents 5 | foreach {$_.Properties[5].Value}"
    echo.
    pause
    goto MENU
)

if "%choice%"=="6" (
    echo 自启动的文件:
    reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /s
    echo.
    pause
    goto MENU
)

if "%choice%"=="7" (
    set /p n=请输入要列出被修改的文件的天数:
    echo 最近 %n% 天内被修改的系统文件:
    for /f "delims=" %%A in ('dir "C:\Windows" /b /s /a:-d /tw ^| findstr /i /c:"/%n%/"') do (
        echo %%~fA
    )
    echo.
    pause
    goto MENU
)
if /i "%choice%"=="8" (
    echo 当前运行的进程列表:
    powershell.exe -Command "Get-Process | Select-Object Name, CPU, @{Name='Memory (MB)';Expression={$_.WorkingSet / 1MB -as [int]}} | Sort-Object -Property CPU -Descending"
    echo.
    pause
    goto MENU
)
if /i "%choice%"=="Q" (
    exit
)

goto MENU