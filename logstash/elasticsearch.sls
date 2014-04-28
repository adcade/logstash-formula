{% from "logstash/map.jinja" import logstash with context %}
{% set config = salt['pillar.get']('elasticsearch:config', None) %}
{% set default_config = salt['pillar.get']('elasticsearch:default_config') %}

elasticsearch_requirements:
  pkg.installed:
    - pkgs:
      - {{ logstash.java }}

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: {{ logstash.elasticsearch }}
  service.running:
    - require:
      - pkg: elasticsearch_requirements
