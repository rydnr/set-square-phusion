#!/bin/bash dry-wit
# Copyright 2015-today Automated Computing Machinery S.L.
# Distributed under the terms of the GNU General Public License v3

## Checks if given locale identifier is supported.
## -> *: The locale identifier.
## <- 0/${TRUE} if the locale is supported; 1/${FALSE} otherwise.
## Example:
##  if is_locale_supported "en_US" "UTF-8"; then
##    echo "en_US with UTF-8 is supported"
##  fi
function is_locale_supported() {
  local _locale="${1}";
  local _encoding="${2}";
  local -i _rescode;

  checkNotEmpty "locale" "${_locale}" 1;
  checkNotEmpty "encoding" "${_encoding}" 2;

  if [ -f ${SUPPORTED_LOCALES_FOLDER}/${_locale%%_*} ]; then
      if is_locale_file_available "${_locale}"; then
          if is_locale_available_in_language_file "${_locale}" "${_encoding}"; then
              _rescode=${TRUE};
          else
            _rescode=${FALSE};
          fi
      else
        _rescode=${FALSE};
      fi
  else
    _rescode=${FALSE};
  fi

  return ${_rescode};
}

## Checks if the locale file is available.
## -> 1: The locale.
## <- 0/${TRUE} if the locale file exists; 1/${FALSE} otherwise.
## Example:
##  if is_locale_file_available "en_US"; then
##    echo "English-US is available"
##  fi
function is_locale_file_available() {
  local _locale="${1}";
  local -i _rescode;

  checkNotEmpty "locale" "${_locale}" 1;

  if [ -f ${AVAILABLE_LOCALES_FOLDER}/${_locale} ]; then
      _rescode=${TRUE};
  else
    _rescode=${FALSE};
  fi

  return ${_rescode};
}

## Checks if locale requires appending the encoding or not.
## -> 1: the locale.
## -> 2: the encoding.
## <- 0/${TRUE} if the locale requires the encoding suffix; 1/${FALSE} otherwise.
## Example:
##    if locale_requires_encoding_suffix "${locale}" "${encoding}"; then
##      locale Definition="${locale}.${encoding}";
##    fi
function locale_requires_encoding_suffix() {
  local _locale="${1}";
  local _encoding="${2}";
  local -i _rescode;

  checkNotEmpty "locale" "${_locale}" 1;
  checkNotEmpty "encoding" "${_encoding}" 2;

  grep "${_locale}.${_encoding} ${_encoding}" "${SUPPORTED_LOCALES_FILE}" > /dev/null 2>&1;
  _rescode=$?;

  return ${_rescode};
}

## Checks if given locale + encoding is supported.
## -> 1: The locale.
## -> 2: The encoding.
## <- 0/${TRUE} if the language is supported; 1/${FALSE} otherwise.
## <- RESULT: The supported locales.
## Example:
##  is_locale_available_in_language_file "en_US" "UTF-8";
##  echo "Supported English locales: ${RESULT}";
function is_locale_available_in_language_file() {
  local _locale="$1";
  local _encoding="$2";
  local -i _rescode;
  local _language;

  checkNotEmpty "locale" "${_locale}" 1;
  checkNotEmpty "encoding" "${_encoding}" 2;

  if is_locale_file_available "${_locale}"; then
      if locale_requires_encoding_suffix "${_locale}" "${_encoding}"; then
          _rescode=${TRUE}; # Implicit since it greps the same file.
      else
        grep "${_locale} ${_encoding}" ${SUPPORTED_LOCALES_FILE} > /dev/null 2>&1;
        _rescode=$?;
      fi
  else
    _rescode=${FALSE};
  fi

  return ${_rescode};
}

## Changes the default locale.
## -> 1: The locale.
## Example:
##   change_default_locale "en_US.UTF-8"
function change_default_locale() {
  local _locale="${1}";
  local _encoding="${2}";

  checkNotEmpty "locale" "${_locale}" 1;
  checkNotEmpty "encoding" "${_encoding}" 2;

  logInfo -n "Checking if the locale/encoding pair is valid";
  if is_locale_supported "${_locale}" "${_encoding}"; then
      logInfoResult SUCCESS "valid";
      logInfo -n "Modifying ${DEFAULTLOCALE_FILE}";
      echo "LANG=\"${_locale}.${_encoding}\"" > ${DEFAULTLOCALE_FILE};
      echo "LANGUAGE=\"${_locale}.${_encoding}\"" >> ${DEFAULTLOCALE_FILE};
      echo "LC_ALL=\"${_locale}.${_encoding}\"" >> ${DEFAULTLOCALE_FILE};
      logInfoResult SUCCESS "done";

      logInfo -n "Modifying ${BASHLOCALE_FILE}";
      echo "# Generated by ${SCRIPT_NAME} for locale ${_locale}.${_encoding}" > ${BASHLOCALE_FILE};
      echo "export LANG=\"${_locale}.${_encoding}\"" >> ${BASHLOCALE_FILE};
      echo "export LANGUAGE=\"${_locale}.${_encoding}\"" >> ${BASHLOCALE_FILE};
      echo "export LC_ALL=\"${_locale}.${_encoding}\"" >> ${BASHLOCALE_FILE};
      #  echo "export LC_CTYPE=\"${_locale}.${_encoding}\"" >> ${BASHLOCALE_FILE};
      logInfoResult SUCCESS "done";
  else
    logInfoResult FAILURE "invalid";
    exitWithErrorCode LOCALE_ENCODING_PAIR_IS_NOT_SUPPORTED "${_locale}" "${_encoding}";
  fi
}

## Main logic
## dry-wit hook
function main() {
  change_default_locale "${LOCALE}" "${ENCODING}";
}

## Script metadata and CLI settings.

setScriptDescription "Changes the locale and encoding (available after re-login).";
addCommandLineFlag "locale" "l" "The locale to use (en_US, es_ES, ...)" OPTIONAL EXPECTS_ARGUMENT "${DEFAULT_LOCALE}";
addCommandLineFlag "encoding" "e" "The encoding (UTF-8, ISO-8859-1, ...)" OPTIONAL EXPECTS_ARGUMENT "${DEFAULT_ENCODING}";

function dw_parse_locale_cli_flag() {
  LOCALE="${1}";
}

function dw_parse_encoding_cli_flag() {
  ENCODING="${1}";
}

addError "LOCALE_IS_MANDATORY" "The locale parameter is mandatory";
addError "ENCODING_IS_MANDATORY" "The encoding parameter is mandatory";
addError "LOCALE_ENCODING_PAIR_IS_NOT_SUPPORTED" "The provided locale-encoding pair is not supported";
#
