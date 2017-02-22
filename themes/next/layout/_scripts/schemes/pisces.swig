{%
  set scripts = [
    'src/affix.js',
    'src/schemes/pisces.js'
  ]
%}

<!-- {% for script in scripts %} -->
<!--   <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ script }}?v={{ theme.version }}"></script> -->
<!-- {% endfor %} -->
{% for script in scripts %}
  <script type="text/javascript" src="{{ theme.qiniu_domain }}/js/{{ script }}?v={{ theme.version }}"></script>
{% endfor %}
