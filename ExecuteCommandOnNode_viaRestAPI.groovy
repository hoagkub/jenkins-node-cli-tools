import hudson.util.RemotingDiagnostics;
def request = org.kohsuke.stapler.Stapler.getCurrentRequest()

nodeName = request.getParameter("nodeName");
executeCommand = request.getParameter("executeCommand");
cwd = request.getParameter("cwd");

print_outputOfCommand = "print \"cmd /c \\\"cd /d \\\"${cwd}\\\" && ${executeCommand} 2>&1\\\"\".execute().text";
println "---------------------\n${print_outputOfCommand}\n---------------------"
try {
    slave = hudson.model.Hudson.instance.getSlave(nodeName)
    def returnCommand = RemotingDiagnostics.executeGroovy(print_outputOfCommand, slave.getChannel())
    if ("returnCommand"!="java.lang.NullPointerException") {
        println "${returnCommand}";
    } else {
        println "ERROR: Execute command \"${executeCommand}\" with exception\njava.lang.NullPointerException.\nTry again or type \"exit\" to exit the current session.\n"
    }
} catch (Exception e) {
    println "ERROR: Node \"${nodeName}\" is offline or not available on jenkins.\nType \"exit\" to exit the current session.\n"
}
