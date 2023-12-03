# Сервис сокращения ссылок

#### Зависимости
* Ruby 2.7.3
* Rails 6.1.7
* PostgreSQL 12+

#### Создание короткой ссылки:

```
# запрос:
POST 0.0.0.0:3000/urls
# параметры
{
  "url": {
    "original_url": "https://example_url.com"
  }
}

# ответ:
{
  "original_url": "https://example_url.com",
  "short_url": "ytmfk5"
}
```
