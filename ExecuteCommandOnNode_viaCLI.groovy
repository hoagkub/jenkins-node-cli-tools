import hudson.util.RemotingDiagnostics;
nodeName="${args[0]}";
executeCommand="${args[1]}";
cwd="${args[2]}";

print_outputOfCommand = "print \"cmd /c \\\"cd /d \\\"${cwd}\\\" && ${executeCommand}\\\"\".execute().text";
for (slave in hudson.model.Hudson.instance.slaves) {
    if (slave.name.contains("${nodeName}")) { // || "${nodeName}"=="all") {
        try {
            def returnCommand = RemotingDiagnostics.executeGroovy(print_outputOfCommand, slave.getChannel())
            if ("returnCommand"!="java.lang.NullPointerException") {
                // println "Result of command \"${executeCommand}\" on node \"${slave.name}\" is below:"
                println "${returnCommand}";
            } else {
                println "Can't execute command \"${executeCommand}\" on node \"${nodeName}\""
            }
        } catch (Exception e) {
            //do nothing
            println "Can't execute command \"${executeCommand}\" on node \"${nodeName}\""
        }
    }
}