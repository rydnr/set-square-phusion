#!/bin/bash dry-wit
# Copyright 2017-today Automated Computing Machinery S.L.
# Distributed under the terms of the GNU General Public License v3

function usage() {
  cat <<EOF
$SCRIPT_NAME [[locale]? [encoding]?]?
$SCRIPT_NAME [-h|--help]
(c) 2017-today OSOCO Software Company.
    Distributed under the terms of the GNU General Public License v3

Runs the ${APP_HOME}/${APP} Java application.

Common flags:
    * -h | --help: Display this message.
    * -v: Increase the verbosity.
    * -vv: Increase the verbosity further.
    * -q | --quiet: Be silent.
EOF
}

# Requirements
function defineRequirements() {
  checkReq java "JAVA_IS_NOT_INSTALLED";
}

## Defines the errors
## dry-wit hook
function defineErrors() {
  addError "INVALID_OPTION" "Unrecognized option";
  addError "JAVA_IS_NOT_INSTALLED" "java is not installed";
  addError APP_FILE_NOT_FOUND "The application's jar file is not found in ${APP_HOME}";
}

## Validates the input.
## dry-wit hook
function checkInput() {

  local _flags=$(extractFlags $@);
  local _flagCount;
  local _currentCount;
  logDebug -n "Checking input";

  # Flags
  for _flag in ${_flags}; do
    _flagCount=$((_flagCount+1));
    case ${_flag} in
      -h | --help | -v | -vv | -q)
        shift;
        ;;
      --)
        shift;
        break;
        ;;
      *) logDebugResult FAILURE "failed";
         exitWithErrorCode INVALID_OPTION;
         ;;
    esac
  done

  if isEmpty "${APP}"; then
    logDebugResult FAILURE "failed";
    exitWithErrorCode APP_FILE_NOT_FOUND;
  fi

  logDebugResult SUCCESS "valid";
}

## Parses the input
## dry-wit hook
function parseInput() {

  local _flags=$(extractFlags $@);
  local _flagCount;
  local _currentCount;

  # Flags
  for _flag in ${_flags}; do
    _flagCount=$((_flagCount+1));
    case ${_flag} in
      -h | --help | -v | -vv | -q)
        shift;
        ;;
      --)
        shift;
        break;
        ;;
    esac
  done

  if isEmpty "${LOCALE}"; then
    export LOCALE="${SQ_DEFAULT_LOCALE}";
  fi

  if isEmpty "${ENCODING}"; then
    export ENCODING="${SQ_DEFAULT_ENCODING}";
  fi
}

## Main logic
## dry-wit hook
function main() {

  if isEmpty "${JAVA_OPTS}"; then
    JAVA_OPTS="${DEFAULT_JAVA_OPTS}";
  fi

  if ! isEmpty "${JAVA_HEAP_MIN}"; then
    JAVA_OPTS="-Xms${JAVA_HEAP_MIN} ${JAVA_OPTS}";
  fi

  if ! isEmpty "${JAVA_HEAP_MAX}"; then
    JAVA_OPTS="-Xmx${JAVA_HEAP_MAX} ${JAVA_OPTS}";
  fi

  if ! isEmpty "${LOCALE}"; then
    JAVA_OPTS="${JAVA_OPTS} -Duser.language=${LOCALE%_*} -Duser.country=${LOCALE#*_}";
  fi

  if ! isEmpty "${ENCODING}"; then
    JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=${ENCODING}";
  fi

  $(which java) ${JAVA_OPTS} -jar ${APP_HOME}/${APP} ${JAVA_ARGS}
}
