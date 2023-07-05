# ✅ ToDo Yandex
Домашнее задание 3 в Школе мобильной разработки | Flutter

## ⭕️ For Reviewers
- Огромная просьба помочь с выявлением и решением багов, улучшением кода и объяснения, как и почему лучше сделать по-другому
- Буду очень благодарен всем комментариям, замечаниям и придиркам, даже если это стоит мне баллов
- Также при запуске на эмуляторе релизной версии нужно использовать эмулятор x86_64 ОС
- Мой апк сбилжен с моим токеном, для запуска в дебаге или билда релизной версии используйте --dart-define=url=/url/ --dart-define=token=/token/
- не работает кнопка удаления на экране изменения таски
- не доразобрался с тестами(не успел написать unit, с интеграционным что-то непонятное) 

## 📱 Скриншоты

![Main screen](git/first.png) ![Add task](git/second.png)

## ♻️ Features
- Режим добавления/редактирования задачи
- Свайп по таску выполнено/удалить
- Показ/скрытие выполненных дел
- Сохранение в локальную базу данных Isar
- Синхронизация с сервером
- Адекватная работа мерджа и ревизий
- реализован Navigator 2.0 но не интегрирован
- Deeplinks, вроде, работают на Android, прошу обратну связь по ним. Пример команды для запуска: (.\adb shell am start -W -a android.intent.action.VIEW -d myapp://example.com/adding)


## 📥 .apk файл для скачивания на Android

Вы можете скачать приложение по ссылке: [install To Do](https://github.com/o4irov/to_do/releases/download/3.0/app-release.apk)

## 📝 Библиотеки

- [intl: ^0.17.0](https://pub.dev/packages/intl)
- [logger: ^1.4.0](https://pub.dev/packages/logger)
- [http: ^0.13.6](https://pub.dev/packages/http)
- [isar: ^3.1.0+1](https://pub.dev/packages/isar)
- [isar_flutter_libs: ^3.1.0+1](https://pub.dev/packages/isar_flutter_libs)
- [path_provider: ^2.0.15](https://pub.dev/packages/path_provider)
- [isar_generator: ^3.1.0+1](https://pub.dev/packages/isar_generator)
- [build_runner: ^2.3.3](https://pub.dev/packages/build_runner)
- [flutter_lints: ^2.0.0](https://pub.dev/packages/flutter_lints)
- [connectivity_plus: ^4.0.1](https://pub.dev/packages/connectivity_plus)
- [device_info: ^2.0.3]()
- [integration_test: sdk: flutter]
- [shared_preferences: ^2.2.0](https://pub.dev/packages/shared_preferences)
- [uuid: ^3.0.7](https://pub.dev/packages/uuid)

## 👨‍💻 Авторы

- Очиров Андрей | [ваши вопросы по сотрудничеству](https://t.me/o41rov)