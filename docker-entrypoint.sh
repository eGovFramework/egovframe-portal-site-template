#!/bin/bash
# globals.properties DB 접속정보 치환 후 Tomcat 기동
set -e

PROPS_FILE="/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/egovframework/egovProps/globals.properties"

# WAR 자동 전개 대기 (최대 60초)
WAIT_SEC=0
while [ ! -f "$PROPS_FILE" ] && [ "$WAIT_SEC" -lt 60 ]; do
  sleep 2
  WAIT_SEC=$((WAIT_SEC + 2))
done

if [ -f "$PROPS_FILE" ]; then
  # DB_HOST 기본값: 127.0.0.1
  if [ -n "$DB_HOST" ]; then
    sed -i "s|jdbc:log4jdbc:mysql://[^:]*:[0-9]*/[^ ]*|jdbc:log4jdbc:mysql://${DB_HOST}:${DB_PORT:-3306}/${DB_NAME:-pst}|g" "$PROPS_FILE"
  fi
  if [ -n "$DB_USERNAME" ]; then
    sed -i "s|^Globals.UserName\s*=.*|Globals.UserName = ${DB_USERNAME}|" "$PROPS_FILE"
  fi
  if [ -n "$DB_PASSWORD" ]; then
    sed -i "s|^Globals.Password\s*=.*|Globals.Password = ${DB_PASSWORD}|" "$PROPS_FILE"
  fi
  echo "[entrypoint] globals.properties DB 접속정보 치환 완료"
else
  echo "[entrypoint] WARNING: $PROPS_FILE 파일을 찾을 수 없습니다. 기본값으로 기동합니다."
fi

exec catalina.sh run
