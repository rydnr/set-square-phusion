defineEnvVar JENKINS_VERSION MANDATORY "The Jenkins version" "2.477"
defineEnvVar TAG MANDATORY "The image tag" '${JENKINS_VERSION}'
defineEnvVar DEFAULT_JENKINS_MEMORY_MIN MANDATORY "The default Xms setting" "-Xms512m"
defineEnvVar DEFAULT_JENKINS_MEMORY_MAX MANDATORY "The default Xmx setting" "-Xmx512m"
# vim: syntax=sh ts=2 sw=2 sts=4 sr noet
