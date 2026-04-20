const fs = require('fs');
let text = fs.readFileSync('build.gradle', 'utf8');

// The original line:
let search = `windowsScriptFile.text = windowsScriptFile.text.replace('"-Xmx6g"', '"-Xmx6g"\\n\\nif exist "%USERPROFILE%\\\\SDRTrunk\\\\SDRTrunk.memory" (\\n    set /p MEM_LIMIT=<"%USERPROFILE%\\\\SDRTrunk\\\\SDRTrunk.memory"\\n)\\nif defined MEM_LIMIT (\\n    set SDR_TRUNK_OPTS=%SDR_TRUNK_OPTS% "-Xmx%MEM_LIMIT%g"\\n)')`;

// What we want:
// Replace using groovy closure so $0 evaluates correctly in Groovy `replaceAll`.
let replacement = `        // Append memory parsing block to the windows batch script after the JVM OPTS are set
        windowsScriptFile.text = windowsScriptFile.text.replaceAll(/(?m)^set DEFAULT_JVM_OPTS=.*$$/) { match ->
            match + '\\n\\nif exist "%USERPROFILE%\\\\\\\\SDRTrunk\\\\\\\\SDRTrunk.memory" (\\n    set /p MEM_LIMIT=<"%USERPROFILE%\\\\\\\\SDRTrunk\\\\\\\\SDRTrunk.memory"\\n)\\nif defined MEM_LIMIT (\\n    set SDR_TRUNK_OPTS=%SDR_TRUNK_OPTS% "-Xmx%MEM_LIMIT%g"\\n)'
        }`;

text = text.replace(search, replacement);

fs.writeFileSync('build.gradle', text);
