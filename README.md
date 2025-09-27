# Rails test app for medods

# Информация
.env конфигурация по умолчанию должна стартовать, но может понадобиться скрипту выдать права
```bash
chmod +x /rails/entrypoint.sh
```

## Запуск тестов + генерация документация
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
