# Rails test app for medods

# Информация
# Перед запуском переименуйте `.env.sample` на `.env`
.env конфигурация по умолчанию должна стартовать, но может понадобиться скрипту выдать права
```bash
chmod +x /rails/entrypoint.sh
```

## Запуск тестов + генерация документация

### Для тестов используется другая таблица medods_test_test в той-же бд
### Перед запуском тестов нужно поднять контейнер с бд
```bash
docker-compose up -d db
```

Тесты написаны с исп. rspec и rswag c автогенерацией примеров ответов
```bash
rake test:all
```

## Запуск через докер
```bash
docker-compose up -d
```

## Документация
`http://localhost:3000/api-docs`
