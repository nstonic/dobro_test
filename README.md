# TODO лист

## Как развернуть local-окружение

Задайте переменные окружения (можно в файле .env в корне проекта):
```shell
ALLOWED_HOSTS='127.0.0.1, localhost'
DEBUG=True
SECRET_KEY=123456
```

Для запуска ПО вам понадобятся Docker и Docker Compose. Инструкции по их установке ищите на официальных
сайтах:

- [Install Docker Desktop](https://www.docker.com/get-started/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

Сначала соберите докер-образ с помощью Docker Сompose:

```shell
$ docker compose build
```

Накатите миграции:

```shell
$ docker compose run --rm django manage.py migrate
```

Запустите докер-контейнеры:

```shell
$ docker compose up
```

В новой консоли, не выключая работающий контейнер, загрузите в БД тестовые данные:

```shell
$ docker compose exec postgres psql -U dobro -f /test_data/postgres.sql
```

Сайт доступен по адресу [127.0.0.1:8000](http://127.0.0.1:8000). Вход в админку находится по
адресу [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/). В разработческой БД уже есть суперпользователь:

- `admin`, пароль `admin`
