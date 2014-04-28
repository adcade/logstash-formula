{% from "logstash/map.jinja" import logstash with context %}
{% set elasticsearch_host = salt['pillar.get']('logstash:output:elasticsearch_host', 'localhost') %}
{% set elasticsearch_port = salt['pillar.get']('logstash:output:elasticsearch_port', 9200) %}
{% set redis_host = salt['pillar.get']('logstash:input:redis_host', 'localhost') %}
{% set redis_port = salt['pillar.get']('logstash:input:redis_port', 9200) %}
{% set redis_key = salt['pillar.get']('logstash:input:redis_key', 'logstash:beaver') %}
{% set redis_data_type = salt['pillar.get']('logstash:input:redis_data_type', 'list') %}

include:
  - redis
  - .kibana
  - .elasticsearch

logstash_requirements:
  pkg.installed:
    - pkgs:
      - {{ logstash.java }}

logstash:
  pkg.installed:
    - sources:
      - logstash: {{ logstash.logstash }}
  service.running:
    - watch:
      - file: /etc/logstash/conf.d/input.conf
      - file: /etc/logstash/conf.d/output.conf
    - require:
      - pkg: logstash_requirements

/etc/logstash/conf.d/input.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://logstash/files/logstash_input.conf
    - context:
        redis_host: {{ redis_host }}
        redis_port: {{ redis_port }}
        redis_key: {{ redis_key }}
        redis_data_type: {{ redis_data_type }}

/etc/logstash/conf.d/output.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://logstash/files/logstash_output.conf
    - context:
      elasticsearch_host: {{ elasticsearch_host }}
      elasticsearch_port: {{ elasticsearch_port }}
