{% from "mysql/default.yml" import rawmap with context %}
{% set rawmap = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql')) %}

{% if 'databases' in rawmap %}
    {% if rawmap.databases is string %}
        {% set dbs = [rawmap.databases] %}
    {% else %}
        {% set dbs = rawmap.databases %}
    {% endif %}
    {% for db in dbs %}
        {% if db is mapping %}
            {% set dbname = db.items()[0][0] %}
        {% elif db is string %}
            {% set dbname = db %}
        {% endif %}
{{'mysql_database_' ~ dbname}}:
    mysql_database:
        - present
        - name: {{dbname}}
    {% endfor %}
{% endif %}
