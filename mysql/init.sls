{% from "mysql/default.yml" import rawmap with context %}
{% set mysql = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

{{mysql.package}}:
    pkg.installed:
        - name: {{mysql.package}}

{{mysql.service}}:
    service:
        - running
        - watch:
            - file: {{mysql.config.file}}
        - require:
            - pkg: {{mysql.package}}

{{mysql.config.file}}:
    file.managed:
        - source: salt://mysql/files/my.cnf
        - template: jinja
        - user: root
        - group: wheel
        - mode: 0644
        - require:
            - pkg: {{mysql.package}}
