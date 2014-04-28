{% from "logstash/map.jinja" import logstash with context %}
{% set config = salt['pillar.get']('beaver:config', None) %}
{% set logfiles = salt['pillar.get']('beaver:logfiles', None) %}

beaver_requirements:
  pkg.installed:
    - pkgs:
      - {{ logstash.pip }}

beaver:
  pip.installed:
    - name: beaver
    - require: 
      - pkg: beaver_requirements
  service.running:
    - watch:
      - file: /etc/beaver/beaver.conf
    - require:
      - file: /etc/init/beaver.conf

/etc/beaver:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/var/log/beaver:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/init/beaver.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://logstash/files/beaver_upstart.conf

/etc/beaver/beaver.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://logstash/files/beaver.conf
    - context:
        config: {{ config }}
        logfiles: {{ logfiles }}
