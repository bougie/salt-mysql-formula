{% from "mysql/default.yml" import rawmap with context %}
{% set mysql = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

mysql_server_package:
    pkg.installed:
        - name: {{mysql.server_package}}
        - reload_modules: True

mysql_client_package:
    pkg.installed:
        - name: {{mysql.client_package}}
        - reload_modules: True

{% if mysql.admin %}
python_mysql:
    pkg.installed:
        - name: {{mysql.pymysql}}
        - reload_modules: True
{% endif %}
