# Manages the php-fpm main ini file
{% from 'php/ng/map.jinja' import php with context %}
{% from "php/ng/macro.jinja" import sls_block, serialize %}

{% set ini_settings = php.ini.defaults %}
{% do ini_settings.update(php.fpm.config.ini.settings) %}

{% set conf_settings = php.lookup.fpm.defaults %}
{% do conf_settings.update(php.fpm.config.conf.settings) %}

php_fpm_ini_config:
  file.managed:
    {{ sls_block(php.fpm.config.ini.opts) }}
    - name: {{ php.lookup.fpm.ini }}
    - source: salt://php/ng/files/php.ini
    - template: jinja
    - context:
        config: {{ serialize(ini_settings) }}

php_fpm_conf_config:
  file.managed:
    {{ sls_block(php.fpm.config.conf.opts) }}
    - name: {{ php.lookup.fpm.conf }}
    - source: salt://php/ng/files/php.ini
    - template: jinja
    - context:
        config: {{ serialize(conf_settings) }}
