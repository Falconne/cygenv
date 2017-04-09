@echo off
REM Creates a wrapper _vimrc in home directory that calls the _vimrc
REM in this repo.

setlocal
if "%HOME%"=="" set HOME=%HOMEDRIVE%%HOMEPATH%
echo Home directory is %HOME%

set VUNDLE="%HOME%\vimfiles\bundle\Vundle.vim"
if exist %VUNDLE% (
    echo Vundle clone already found at %VUNDLE%
    goto ERROR
)

set SCRIPT_DIR=%~dp0
set VIMRC="%HOME%\_vimrc"
set VIMRC_BAK="%HOME%\_vimrc.bak"
if exist %VIMRC% (
    if exist %VIMRC_BAK% (
        echo %VIMRC% and %VIMRC_BAK% exist. Will not overwrite local files.
        goto ERROR
    )

    echo Backing up existing %VIMRC% as %VIMRC_BAK%
    move %VIMRC% %VIMRC_BAK%
    if exist %VIMRC% (
        echo Unable to move %VIMRC%. Exiting.
        goto ERROR
    )
)

echo source %SCRIPT_DIR%_vimrc > %VIMRC%

git clone https://github.com/VundleVim/Vundle.vim %VUNDLE% || (
    echo Clone failed
    goto ERROR
)

echo All Done. Run gvim and type ":PluginInstall"
goto Done

:ERROR
echo ERROR encountered, exiting

:Done
pause
endlocal
