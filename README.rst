=====
logstash
=====

Install Logstash with Elasticsearch, Redis, Kibana, and Beaver.
Only tested on Ubuntu 12.04.. should work with CentOS.

.. note::


    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``logstash``
---------

Install the Logstash agent, Elasticsearch, Redis, and Kibana.

``logstash.beaver``
----------------

Install the Logstash Beaver client.

``Dependencies``
----------------

This formula requires the `Redis <https://github.com/Adcade/redis-formula>_` and `Nginx <https://github.com/Adcade/nginx-formula>_`
