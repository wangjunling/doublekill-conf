{%
  set js_commons = [
    'js/src/utils.js',
    'js/src/motion.js'
  ]
%}

<!-- {% for common in js_commons %} -->
 <!-- <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ common }}?v={{ theme.version }}"></script> -->
 <!-- {% endfor %} -->
{% for common in js_commons %}
  <script type="text/javascript" src="{{theme.qiniu_domain}}/{{ common }}?v={{ theme.version }}"></script>
{% endfor %}