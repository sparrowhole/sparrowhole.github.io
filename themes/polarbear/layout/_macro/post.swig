{% macro render(post) %}
  {% if is_home() %}
    <div class="home-post">
        <header class="home-post-header">
        <h1>
            <a class="post-link" href="{{ url_for(post.path) }}">{{ post.title }}</a>
        </h1>
        <time class="home-post-time">
            {{ full_date(post.date, 'dddd, YYYY年 MM月 DD日') }}
        </time>
        </header>
        <div class="home-post-excerpt">
            {% set excerpt = "" %}
            {% if post.description %}
                {% set excerpt = post.description %}
            {% elif post.excerpt %}
                {% set excerpt = post.excerpt %}
            {% endif %}

            {% if excerpt %}
                {{ excerpt }}
            {% else %}
                {{ truncate(strip_html(post.content), {length: 100}) }}
            {% endif %}
        </div>
    </div>
  {% endif %}

  {% if not is_home() %}
    <article class="post">
        <header class="post-header">
            <h1 class="post-title">
                {{ post.title }}
            </h1>

            <time class="post-time">
                {{ full_date(post.date, 'dddd, YYYY年 MM月 DD日') }}
            </time>
        </header>

        <div class="post-content">
            {{ post.content }}
        </div>
        <footer class="post-footer">
            {% if post.tags and post.tags.length %}
            <div class="post-tags">
            {% for tag in post.tags %}
                <a href="{{ url_for(tag.path) }}">{{ tag.name }}</a>
            {% endfor %}
            </div>
            {% endif %}

            {# Post Pagination #}
            {% include "../_partial/pagination.swig" %}
            {% include "../_partial/comments.swig" %}
        </footer>
    </article>

  {% endif %}

{% endmacro %}
