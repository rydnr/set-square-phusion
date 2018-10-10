defineEnvVar PARENT_IMAGE_TAG "The version of the parent image" "0.11";
defineEnvVar LOGSTASH_VERSION "The logstash version" "1:6.4.0-1";
overrideEnvVar TAG '6.4.0';
overrideEnvVar ENABLE_LOGSTASH "false";
overrideEnvVar ENABLE_LOCAL_SMTP "false";
overrideEnvVar ENABLE_CRON "false";
overrideEnvVar ENABLE_RSNAPSHOT "false";
overrideEnvVar ENABLE_SYSLOG "true";
defineEnvVar LOGSTASH_CODEC_PLUGINS_ALL "The space-separated list of Logstash codec plugins to install" "logstash-codec-collectd logstash-codec-dots logstash-codec-edn logstash-codec-edn_lines logstash-codec-es_bulk logstash-codec-fluent logstash-codec-graphite logstash-codec-json logstash-codec-json_lines logstash-codec-line logstash-codec-msgpack logstash-codec-multiline logstash-codec-netflow logstash-codec-plain logstash-codec-rubydebug";
defineEnvVar LOGSTASH_CODEC_PLUGINS "The space-separated list of Logstash codec plugins to install" "logstash-codec-json logstash-codec-multiline";
defineEnvVar LOGSTASH_FILTER_PLUGINS_ALL "The space-separated list of all available Logstash filter plugins" "logstash-filter-clone logstash-filter-csv logstash-filter-date logstash-filter-dns logstash-filter-drop logstash-filter-fingerprint logstash-filter-geoip logstash-filter-grok logstash-filter-json logstash-filter-kv logstash-filter-metrics logstash-filter-mutate logstash-filter-ruby logstash-filter-sleep logstash-filter-split logstash-filter-syslog_pri logstash-filter-throttle logstash-filter-urldecode logstash-filter-useragent logstash-filter-uuid logstash-filter-xml";
defineEnvVar LOGSTASH_FILTER_PLUGINS "The space-separated list of Logstash filter plugins to install" "logstash-filter-clone logstash-filter-csv logstash-filter-date logstash-filter-dns logstash-filter-drop logstash-filter-fingerprint logstash-filter-geoip logstash-filter-grok logstash-filter-json logstash-filter-metrics logstash-filter-split logstash-filter-throttle logstash-filter-urldecode logstash-filter-useragent logstash-filter-uuid";
defineEnvVar LOGSTASH_INPUT_PLUGINS_ALL "The space-separated list of all available Logstash input plugins" "logstash-input-beats logstash-input-couchdb_changes logstash-input-elasticsearch logstash-input-exec logstash-input-file logstash-input-ganglia logstash-input-gelf logstash-input-generator logstash-input-graphite logstash-input-heartbeat logstash-input-http logstash-input-http_poller logstash-input-imap logstash-input-irc logstash-input-jdbc logstash-input-kafka logstash-input-log4j logstash-input-lumberjack logstash-input-pipe logstash-input-rabbitmq logstash-input-redis logstash-input-s3 logstash-input-snmptrap logstash-input-sqs logstash-input-stdin logstash-input-syslog logstash-input-tcp logstash-input-twitter logstash-input-udp logstash-input-unix logstash-input-xmpp";
defineEnvVar LOGSTASH_INPUT_PLUGINS "The space-separated list of Logstash input plugins to install" "logstash-input-beats logstash-input-elasticsearch logstash-input-file logstash-input-http logstash-input-log4j logstash-input-rabbitmq logstash-input-redis logstash-input-s3 logstash-input-sqs logstash-input-stdin logstash-input-syslog logstash-input-tcp logstash-input-udp logstash-input-unix";
defineEnvVar LOGSTASH_OUTPUT_PLUGINS_ALL "The space-separated list of all available Logstash output plugins" "logstash-output-cloudwatch logstash-output-csv logstash-output-elasticsearch logstash-output-file logstash-output-graphite logstash-output-http logstash-output-irc logstash-output-kafka logstash-output-nagios logstash-output-null logstash-output-pagerduty logstash-output-pipe logstash-output-rabbitmq logstash-output-redis logstash-output-s3 logstash-output-sns logstash-output-sqs logstash-output-statsd logstash-output-stdout logstash-output-tcp logstash-output-udp logstash-output-webhdfs logstash-output-xmpp";
defineEnvVar LOGSTASH_OUTPUT_PLUGINS "The space-separated list of Logstash output plugins to install" "logstash-output-cloudwatch logstash-output-csv logstash-output-elasticsearch logstash-output-file logstash-output-graphite logstash-output-http logstash-output-nagios logstash-output-pagerduty logstash-output-pipe logstash-output-rabbitmq logstash-output-redis logstash-output-s3 logstash-output-sns logstash-output-sqs logstash-output-statsd logstash-output-stdout logstash-output-tcp logstash-output-udp logstash-output-xmpp";
defineEnvVar LOGSTASH_PATTERNS_PLUGINS_ALL "The space-separated list of all available Logstash pattern plugins" "logstash-patterns-core";
defineEnvVar LOGSTASH_PATTERNS_PLUGINS "The space-separated list of the Logstash pattern plugins to install" "logstash-patterns-core";
defineEnvVar SERVICE_USER "The logstash user" "logstash";
defineEnvVar SERVICE_GROUP "The logstash group" "logstash";
defineEnvVar SERVICE_USER_HOME "The home of the logstash user" "/usr/share/logstash";
defineEnvVar SERVICE_USER_SHELL "The shell of the logstash user" "/bin/bash";
