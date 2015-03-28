# Meta-state to fully install mysql

require:
   - mysql.install
   - mysql.config
   - mysql.service

extend:
    mysql_service:
        service:
            - watch:
                - file: mysql_config
                - pkg: mysql_package
            - require:
                - file: mysql_config
    mysql_config:
        file:
            - require:
                - pkg: mysql_package
