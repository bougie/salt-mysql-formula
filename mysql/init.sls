# Meta-state to fully install mysql
{% from "mysql/default.yml" import rawmap with context %}
{% set rawmap = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

include:
   - mysql.install
   - mysql.config
   - mysql.service
{% if rawmap.admin %}
   - mysql.users
{% endif %}

extend:
    mysql_service:
        service:
            - watch:
                - file: mysql_config
                - pkg: mysql_server_package
            - require:
                - file: mysql_config
    mysql_config:
        file:
            - require:
                - pkg: mysql_server_package
{% if rawmap.admin and 'master_user' in rawmap %}
    mysql_master_password:
        cmd:
            - require:
                - service: mysql_service
{% endif %}
