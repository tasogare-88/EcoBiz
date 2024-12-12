import 'package:ecobiz/features/steps/data/health_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthFactory extends Mock implements HealthFactory {}

void main() {
  late ProviderContainer container;
  late MockHealthFactory mockHealthFactory;

  setUp(() {
    mockHealthFactory = MockHealthFactory();
    container = ProviderContainer(
      overrides: [
        healthServiceProvider
            .overrideWith(() => HealthService()..health = mockHealthFactory),
      ],
    );
  });

  group('HealthService', () {
    test('認証要求が成功した場合', () async {
      when(() => mockHealthFactory.requestAuthorization(any()))
          .thenAnswer((_) async => true);

      final healthService = container.read(healthServiceProvider.notifier);
      final result = await healthService.requestAuthorization();

      expect(result, true);
      verify(() => mockHealthFactory.requestAuthorization(any())).called(1);
    });

    test('歩数取得が成功した場合', () async {
      when(() => mockHealthFactory.getTotalStepsInInterval(any(), any()))
          .thenAnswer((_) async => 1000);

      final healthService = container.read(healthServiceProvider.notifier);
      final steps = await healthService.getTodaySteps();

      expect(steps, 1000);
      verify(() => mockHealthFactory.getTotalStepsInInterval(any(), any()))
          .called(1);
    });

    test('歩数が取得できない場合は0を返す', () async {
      when(() => mockHealthFactory.getTotalStepsInInterval(any(), any()))
          .thenAnswer((_) async => null);

      final healthService = container.read(healthServiceProvider.notifier);
      final steps = await healthService.getTodaySteps();

      expect(steps, 0);
    });
  });
}
