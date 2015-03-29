{% from "mysql/default.yml" import rawmap with context %}
{% set mysql = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

mysql_config:
    file:
        - managed
        - name: {{mysql.config.file}}
        - source: salt://mysql/files/my.cnf
        - template: jinja
        - user: root
        - group: wheel
        - mode: 0644
