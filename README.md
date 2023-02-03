# stateful_books

A fork of the Books example of [go_router](https://pub.dev/packages/go_router), that uses stateful nested navigation, 
i.e. `StatefulShellRoute` for the main navigation shell, and [Serverpod](https://serverpod.dev) as a backend.

Currently this sample requires the 
[PR #2650](https://github.com/flutter/packages/pull/2650) of go_router 
(or [https://github.com/tolo/flutter_packages/tree/nested-persistent-navigation](https://github.com/tolo/flutter_packages/tree/nested-persistent-navigation)).


## Setup and run

Follow the steps below to setup the server and run the app.

### 1. Clone repository and checkout serverpod branch
```
git clone git@github.com:tolo/stateful_books.git
cd stateful_books
git checkout serverpod
```

### 2. Install Serverpod (and Docker desktop)
See [https://docs.serverpod.dev](https://docs.serverpod.dev/#installing-serverpod).

### 3. Setup server
Setup services (database etc) in docker container:
```
cd stateful_books_server
docker-compose up --build --detach
```

Get dependencies for server:
```
dart pub get
```

### 4. Setup database
- Open your favorite **database tool/IDE** (like DataGrip or Postico or similar).
- Connect to the database, using the information found in the configuraiton files `stateful_books_server/config/development.yaml` and `stateful_books_server/config/passwords.yaml`.
- Using your databse IDE, run the database scripts below (found in the `stateful_books_server/generated` directory) to add the requires tables to the database. 
    - `tables-serverpod.pgsql` - tables required by Serverpod itself.
    - `tables.pgsql` - tables for the domain objects part of the stateful_books app.
    - `tables-auth.pgsql` - tables for email authentication (copied from [serverpod_auth_server](https://github.com/serverpod/serverpod/blob/main/modules/serverpod_auth/serverpod_auth_server/generated/tables.pgsql) module).
    

### 5. Run the server
```
cd stateful_books_server
dart bin/main.dart
```

### 6. Run the Flutter app
```
cd stateful_books_flutter
flutter run
```
