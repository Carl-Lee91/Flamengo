# Project Rules

## Flutter

- UI 구성을 위한 private 메소드(`_buildXXX`)를 사용하지 말고, 별도의 StatelessWidget 또는 StatefulWidget으로 분리할 것
- 각 위젯은 별도의 파일로 생성하고, 적절한 export 파일에 추가할 것
- Flutter 명령어 실행 시 반드시 `fvm` 을 붙여서 실행할 것 (예: `fvm flutter pub get`, `fvm flutter run`, `fvm dart run build_runner build`)
