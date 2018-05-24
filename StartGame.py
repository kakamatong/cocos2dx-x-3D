#coding:utf-8
import os

exePath = "simulator/win32/cocos2dx_3D.exe"
workDir = os.getcwd()
mainFile = "src/main.lua"

fullPath = os.path.join(workDir, exePath)
print(fullPath)

command = "%s -workdir %s -file %s" % (fullPath, workDir, mainFile)

os.system(command)