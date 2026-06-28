@echo off
cd /d D:\soft\myblog
git add .
set /p msg=输入提交说明: 
git commit -m "%msg%"
git push
pause