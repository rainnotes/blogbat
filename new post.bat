@echo off

REM Get and set the root post directory
set root= SET POST DIRECTORY HERE
cd %root%

REM get the current OS date and time
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

REM get the title of the post and strip out spaces
set /p UserInputTitle=Post title: 
set UserInputTitleNoSpaces=%UserInputTitle: =_%

REM set the date as a formatted string
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%-"

REM combine the date and post name and ad markdown extension
set filestamp=%fullstamp%%UserInputTitleNoSpaces%
set SAVESTAMP=%filestamp%.md

echo --->> %SAVESTAMP%
echo layout: post>> %SAVESTAMP%
echo title: "%UserInputTitle%">> %SAVESTAMP%
echo comments: true>> %SAVESTAMP%
echo description: "">> %SAVESTAMP%
echo keywords: "">> %SAVESTAMP%
echo --->> %SAVESTAMP%

REM start typora with the stamp
start typora.exe %SAVESTAMP%



echo hit enter to commit new post
pause

REM commit the post to git
cd PATH TO GIT DIRECTORY
git pull
git add .
git commit -m "new post"
git push 
