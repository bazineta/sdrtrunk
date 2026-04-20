def text = '''@rem Add default JVM options here. You can also use JAVA_OPTS and SDR_TRUNK_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED" "-Xmx6g" "-Dsun.java2d.d3d=true"

if defined JAVA_HOME goto findJavaFromJavaHome
'''

text = text.replaceAll('(?m)^(set DEFAULT_JVM_OPTS=.*)$', '''$1

if exist "%USERPROFILE%\\\\SDRTrunk\\\\SDRTrunk.memory" (
    set /p MEM_LIMIT=<"%USERPROFILE%\\\\SDRTrunk\\\\SDRTrunk.memory"
)
if defined MEM_LIMIT (
    set SDR_TRUNK_OPTS=%SDR_TRUNK_OPTS% "-Xmx%MEM_LIMIT%g"
)''')

println text
