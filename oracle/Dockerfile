FROM container-registry.oracle.com/database/free:23.26.1.0-lite

USER root
RUN echo 'sqlplus sys/$ORACLE_PASSWORD@oracle:1521/FREE as sysdba @/opt/oracle/scripts/hr_install.sql "$ORACLE_PASSWORD" "USERS" "YES"' > /opt/oracle/init.sh && \
    chmod +x /opt/oracle/init.sh
USER oracle

CMD ["/bin/bash", "-c", "/opt/oracle/init.sh"]