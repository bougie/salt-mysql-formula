{% from "mysql/default.yml" import rawmap with context %}
{% set mysql = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

mysql_service:
    service:
        - running
        - name: {{mysql.service}}
