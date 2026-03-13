#!/usr/bin/env bash
set -euo pipefail

APP_HOME="/root/psi/jeecg-boot"
TARGET_DIR="$APP_HOME/jeecg-module-system/jeecg-system-start/target"
ERP_BASE_JAR="$APP_HOME/jeecg-module-erp/jeecg-erp-base/target/jeecg-erp-base-2.1.0.jar"
ERP_SERVI_JAR="$APP_HOME/jeecg-module-erp/jeecg-erp-servi/target/jeecg-erp-servi-2.1.0.jar"
ERP_COMMU_JAR="$APP_HOME/jeecg-module-erp/jeecg-erp-commu/target/jeecg-erp-commu-2.1.0.jar"
ERP_CORE_JAR="$APP_HOME/jeecg-module-erp/lib/jeecg-erp-core-2.1.0.jar"

JAR_FILE="$(find "$TARGET_DIR" -maxdepth 1 -type f -name 'jeecg-system-start-*.jar' ! -name '*sources*' | sort | tail -n 1 || true)"
if [[ -z "$JAR_FILE" ]]; then
  echo "ERROR: jar not found in $TARGET_DIR"
  echo "Please run: cd /root/psi/jeecg-boot && mvn -DskipTests -pl jeecg-module-system/jeecg-system-start -am package"
  exit 1
fi

for f in "$ERP_BASE_JAR" "$ERP_SERVI_JAR" "$ERP_COMMU_JAR" "$ERP_CORE_JAR"; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: missing dependency jar: $f"
    echo "Please run: cd /root/psi/jeecg-boot && mvn -DskipTests -pl jeecg-module-system/jeecg-system-start -am package"
    exit 1
  fi
done

LOADER_PATH="$ERP_BASE_JAR,$ERP_SERVI_JAR,$ERP_COMMU_JAR,$ERP_CORE_JAR"

exec java \
  -Xms1024m \
  -Xmx2048m \
  -Dloader.path="$LOADER_PATH" \
  -Dloader.main=org.jeecg.JeecgSystemApplication \
  -Djava.security.egd=file:/dev/./urandom \
  -cp "$JAR_FILE" \
  org.springframework.boot.loader.PropertiesLauncher \
  --spring.profiles.active=prod \
  --spring.quartz.properties.org.quartz.jobStore.tablePrefix=qrtz_
