let file = fs.readFileSync('build.gradle', 'utf8');

// The issue is the `startScripts { doLast {` block is using string replace on `"-Xmx6g"`.
// Because jvmArgsWindows has more arguments AFTER `"-Xmx6g"`, the new lines are inserted right in the middle
// of `set DEFAULT_JVM_OPTS=...`.
// This creates a syntax error in the batch file:
// set DEFAULT_JVM_OPTS="..." "-Xmx6g"
//
// if exist...
// ) "-Dsun.java2d.d3d=true"
//
// The trailing options like "-Dsun.java2d.d3d=true" end up floating after the `)` of the `if defined` statement!

console.log("I get it now.");
