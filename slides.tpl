{% extends 'markdown.tpl' %}

{% block any_cell %}
    {% if cell['metadata'].slideshow %}
    {% if cell['metadata']['slideshow']['slide_type'] == 'skip' %}
    {% else %}
    {{ super() }}
    {% endif %}
    {% endif %}
{% endblock any_cell %}

{% block input %}
    {% if cell['metadata']['hideCode'] == True %}
    {% else %}
    {{ super() }}
    {% endif %}
{% endblock input %}

{% block output %}
    {% if cell['metadata']['hideOutput'] == True %}
    {% else %}
    {{ super() }}
    {% endif %}
{% endblock output %}

{% block data_pdf %}
![pdf]({{ output.metadata.filenames['image/pdf'] | path2url }})
{% endblock data_pdf %}
