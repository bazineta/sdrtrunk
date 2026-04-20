const fs = require('fs');

let input = `
@rem Add default JVM options here. You can also use JAVA_OPTS and SDR_TRUNK_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED" "--add-modules=jdk.incubator.vector" "--enable-preview" "--enable-native-access=javafx.graphics" "--enable-native-access=ALL-UNNAMED" "-Xmx6g" "-Dsun.java2d.d3d=true" "-Dsun.java2d.opengl=True" "-Djava.library.path=c:/Program Files/SDRplay/API/x64"

if defined JAVA_HOME goto findJavaFromJavaHome
`;

let replaced3 = input.replace(/(set DEFAULT_JVM_OPTS=.*(\r\n|\r|\n))/, '$1\nif exist "%USERPROFILE%\\SDRTrunk\\SDRTrunk.memory" (\n    set /p MEM_LIMIT=<"%USERPROFILE%\\SDRTrunk\\SDRTrunk.memory"\n)\nif defined MEM_LIMIT (\n    set SDR_TRUNK_OPTS=%SDR_TRUNK_OPTS% "-Xmx%MEM_LIMIT%g"\n)\n');
console.log(replaced3);
