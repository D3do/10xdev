# API Endpoint Implementation Plan: Generate Trip Plan

## 1. Przegląd punktu końcowego

This endpoint is responsible for generating a trip plan using AI based on user input. It validates the provided data, interacts with an AI generation service, records generation metrics, and stores generated data in the database (in tables such as generated_trip_plans and trip_plans). The endpoint also logs errors in the generation_error_logs table if the process fails.

## 2. Szczegóły żądania

- **Metoda HTTP:** POST
- **Struktura URL:** /api/trips/generate
- **Parametry:**
  - **Wymagane:**
    - `country`: string (min: 2, max: 50 characters)
    - `plans`: string (min: 1000, max: 10000 characters)
  - **Opcjonalne:**
    - `activities`: string (optional; max: 5000 characters as per general guidelines, or 2000 based on specific endpoint requirements)
- **Request Body Example:**

```json
{
  "country": "Poland",
  "plans": "Detailed trip plan text ...",
  "activities": "Optional activities description"
}
```

## 3. Wykorzystywane typy

- `GenerateTripPlanRequestDto` – DTO for the incoming request payload.
- `GenerateTripPlanResponseDto` – DTO for the response payload containing the generated trip plan details.
- Additionally, internal command models and types (e.g., metrics, trip plan object) are used to structure the data flowing through the service.

## 4. Szczegóły odpowiedzi

- **Status 201 OK:** Pomyślna generacja planu.
- **Struktura odpowiedzi:**

```json
{
  "generation_id": 123,
  "plans": [
    {
      "country": "Poland",
      "plans": "Generated trip plan text ...",
      "activities": "Optional activities description",
      "source": "ai-full"
    }
  ],
  "metrics": {
    "generation_duration": 1500,
    "source_text_length": 1024
  }
}
```

- **Kody błędów:**
  - 400 – Nieprawidłowe dane wejściowe
  - 401 – Brak lub nieprawidłowy token autoryzacyjny
  - 429 – Przekroczono limit wywołań
  - 500 – Błąd wewnętrzny serwera

## 5. Przepływ danych

1. **Autoryzacja:**
   - Weryfikacja tokenu JWT pobranego z `context.locals` (Supabase).
2. **Walidacja danych wejściowych:**
   - Użycie `zod` do walidacji pól `country`, `plans`, (i opcjonalnie `activities`) zgodnie z określonymi regułami.
3. **Przetwarzanie żądania:**
   - Przekazanie zwalidowanych danych do serwisu AI Generation (umieszczonego w `src/lib/services`).
4. **Interakcja z bazą danych:**
   - Wstawienie rekordu w tabeli `generated_trip_plans` z metrykami generacji.
5. **Logowanie błędów:**
   - W przypadku niepowodzenia procesu generacji, zapisywanie szczegółów błędu do tabeli `generation_error_logs`.
6. **Odpowiedź:**
   - Zwrócenie struktury JSON zawierającej `generation_id`, wygenerowane plany oraz metryki.

## 6. Względy bezpieczeństwa

- **Autoryzacja:** Endpoint wymaga poprawnego JWT, a dostęp do danych jest zabezpieczony przez mechanizm RLS w Supabase.
- **Walidacja i sanitizacja danych:** Użycie `zod` zapewnia poprawność i bezpieczeństwo danych wejściowych.
- **Komunikacja HTTPS:** Zapewnienie bezpiecznej transmisji danych.
- **Konfiguracja CORS:** Ograniczenie dostępu do endpointu poprzez właściwą konfigurację CORS.

## 7. Obsługa błędów

- **400 Bad Request:** Zwracany, gdy dane wejściowe nie spełniają kryteriów walidacji.
- **401 Unauthorized:** Gdy token JWT jest nieobecny lub niepoprawny.
- **429 Rate Limit Exceeded:** Gdy liczba wywołań przekracza dozwolony limit.
- **500 Internal Server Error:** W przypadku błędów w logice generacji lub awarii usługi AI.
- Dodatkowo, wszelkie błędy związane z generacją są logowane do tabeli `generation_error_logs` z pełnymi szczegółami błędu.

## 8. Rozważania dotyczące wydajności

- **Optymalizacja bazy danych:** Użycie indeksów na kolumnach `user_id` i `generation_id` dla szybkich zapytań.
- **Monitorowanie metryk:** Śledzenie czasu generacji (`generation_duration`) i długości tekstu źródłowego (`source_text_length`).
- **Rate Limiting:** Ograniczenie liczby żądań, aby zabezpieczyć endpoint przed przeciążeniem.

## 9. Etapy wdrożenia

1. **Walidacja wejścia:**
   - Zdefiniowanie i wdrożenie schematu `zod` dla `GenerateTripPlanRequestDto`.
2. **Implementacja serwisu:**
   - Dodanie logiki generacji planu w nowym lub istniejącym serwisie (np. `src/lib/services/aiTripGeneration.ts`).
   - Integruje się z zewnętrznym serwisem AI. Na etapie developmentu skorzystamy z mocków zamiast wywoływania serwisu AI.
3. **Tworzenie endpointu:**
   - Utworzenie pliku `src/pages/api` obsługującego metodę POST.
   - Pobranie instancji Supabase z `context.locals` do operacji autoryzacyjnych i bazodanowych.
4. **Logowanie błędów:**
   - Zaimplementowanie mechanizmu zapisu szczegółów błędów do tabeli `generation_error_logs` w przypadku nieudanej generacji.
5. **Code Review i Audyt:**
   - Przegląd kodu przez zespół celem zapewnienia zgodności z wymaganiami bezpieczeństwa i wydajności.
