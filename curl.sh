curl -k --user ${4}:${5} ${6}/scriptText \
--data-urlencode "script=$(< ./ExecuteCommandOnNode_viaRestAPI.groovy)" \
--data-urlencode "nodeName=$1" \
--data-urlencode "executeCommand=$2" \
--data-urlencode "cwd=${3//\\/\\\\}"

# references: https://issues.jenkins.io/browse/JENKINS-32626
