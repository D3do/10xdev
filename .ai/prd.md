# Dokument wymagań produktu (PRD) – VibeTravels

## 1. Przegląd produktu

VibeTravels to aplikacja, która pomaga użytkownikom w szybkim i intuicyjnym planowaniu angażujących, spersonalizowanych wycieczek i planów podróży. Dzięki wykorzystaniu kreatywności i wiedzy AI użytkownik może przekształcić luźne notatki, pomysły lub cele podróży w gotowy, szczegółowy plan wycieczki.

## 2. Problem użytkownika

Planowanie wyjazdów wymaga czasu, wiedzy o miejscu i kreatywnego podejścia. Wielu użytkowników ma zapisane pomysły w notatkach, listach "must-see" lub luźne inspiracje, ale brakuje im narzędzia, które:

- szybko przekształci je w konkretny plan podróży,
- zadba o flow wycieczki, logikę trasy i ciekawe aktywności,
- zaproponuje coś niestandardowego i dopasowanego do preferencji.

VibeTravels rozwiązuje ten problem automatyzując i upraszczając cały proces planowania podróży.

## 3. Wymagania funkcjonalne

1. Generowanie planu wycieczki przy użyciu AI:

- Użytkownik podaje luźne informacje o swojej podróży (np. lista miejsc, aktywności, zainteresowania, daty).
- Aplikacja analizuje dane i generuje gotowy plan wycieczki (np. plan na dni, aktywności, kolejność zwiedzania, propozycje restauracji lub hidden gems).
- Użytkownik może edytować lub usuwać poszczególne elementy planu.

2. Personalizacja podróży

- Możliwość określenia preferencji (styl podróżowania, budżet, tempo, rodzaje atrakcji).
- AI uwzględnia preferencje podczas generowania planu.

3. Edytor planu wycieczki

- Możliwość dodania własnych punktów (notatek, miejsc, linków).
- Możliwość modyfikacji czasu, kolejności lub usuwania elementów planu.

4. System kont użytkowników

- Rejestracja i logowanie.
- Przechowywanie i zarządzanie stworzonymi planami.
- Możliwość usunięcia konta i danych.

5. Widok planu podróży

- Przejrzysty podgląd planu dziennego.

6. Statystyki i insighty

- Informacje ile planów zostało wygenerowanych.
- Najczęściej wybierane atrakcje / lokalizacje.

7. Wymagania prawne i bezpieczeństwo

- Przechowywanie danych zgodnie z RODO.
- Możliwość wglądu i usunięcia danych przez użytkownika.

## 4. Granice produktu (MVP)

1. Poza zakresem MVP:

- Rekomendacje hoteli / lotów / transportu.
- Integracja z zewnętrznymi API bookingowymi.
- Moduł kosztów i budżetów.
- Aplikacja mobilna (na start web).
- Powiadomienia push / mailowe.
- Tryb offline.

## 5. Historyjki użytkowników (User Stories)

ID: US-001
Tytuł: Rejestracja konta
Opis: Jako nowy użytkownik chcę móc zarejestrować konto w aplikacji, aby zapisywać, edytować i zarządzać swoimi planami podróży.
Kryteria akceptacji:

- Użytkownik może utworzyć konto przy użyciu e-maila i hasła.
- Formularz rejestracji waliduje poprawność danych (np. poprawny e-mail, silne hasło).
- Po rejestracji użytkownik jest automatycznie zalogowany i przekierowany do dashboardu.
- Informacja o sukcesie lub błędach jest wyświetlana.

ID: US-002
Tytuł: Logowanie do aplikacji
Opis: Jako użytkownik chcę móc się zalogować do swojego konta, aby mieć dostęp do zapisanych planów podróży.
Kryteria akceptacji:

- Formularz logowania z polami: e-mail i hasło.
- Obsługa błędnych danych logowania (np. nieprawidłowy e-mail lub hasło).
- Po poprawnym zalogowaniu użytkownik trafia na dashboard.
- Dane dotyczące logowania przechowywane są w bezpieczny sposób.

ID: US-003
Tytuł: Generowanie planu podróży z AI
Opis: Jako użytkownik chcę wprowadzić luźne notatki lub pomysły na wyjazd, aby AI wygenerowało dla mnie spójny i ciekawy plan podróży.
Kryteria akceptacji:

- Formularz do podania informacji (np. miejsca, cele, zainteresowania, daty, liczba dni, preferencje stylu podróży).
- AI analizuje dane i generuje plan wycieczki (np. podział na dni, propozycje aktywności, rekomendacje).
- Informacja o czasie generowania planu (np. loader).
- Możliwość wygenerowania ponownie innego planu (regeneruj).

ID: US-004
Tytuł: Edycja planu podróży
Opis: Jako użytkownik chcę móc edytować wygenerowany plan podróży, aby dostosować go do swoich potrzeb.
Kryteria akceptacji:

- Możliwość edycji nazw, opisów, godzin.
- Możliwość dodania własnych miejsc / notatek.
- Możliwość usunięcia atrakcji.
- Zmiany zapisywane automatycznie lub manualnie.

ID: US-005
Tytuł: Personalizacja stylu podróży
Opis: Jako użytkownik chcę określić swój styl podróżowania i preferencje, aby plan był jak najlepiej dopasowany.
Kryteria akceptacji:

- Użytkownik może wybrać preferencje (np. aktywnie / chill / lokalnie / hidden gems / najbardziej znane miejsca / budżetowo / luksusowo).
- AI uwzględnia preferencje przy generowaniu planu.
- Możliwość zmiany preferencji przed kolejnym generowaniem.

ID: US-006
Tytuł: Podgląd i eksport planu podróży
Opis: Jako użytkownik chcę mieć możliwość zobaczenia planu podróży w czytelnej formie i pobrania go lub udostępnienia.
Kryteria akceptacji:

- Widok planu w podziale na dni.
- Możliwość eksportu do PDF.
- Możliwość udostępnienia linku do planu (shareable link).

US-007
Tytuł: Usuwanie planu lub konta
Opis: Jako użytkownik chcę mieć możliwość usunięcia planu podróży lub całego konta, aby zarządzać swoimi danymi.

Kryteria akceptacji:

- Możliwość usunięcia pojedynczego planu.
- Potwierdzenie przed usunięciem (modal).
- Możliwość usunięcia całego konta z wszystkimi danymi.
- Informacja o sukcesie operacji.

ID: US-008
Tytuł: Bezpieczny dostęp i autoryzacja
Opis: Jako zalogowany użytkownik chcę mieć pewność, że moje podróe nie są dostępne dla innych użytkowników, aby zachować prywatność i bezpieczeństwo danych.
Kryteria akceptacji:

- Tylko zalogowany użytkownik może wyświetlać, edytować i usuwać swoje podróe.
- Nie ma dostępu do podróy innych użytkowników ani możliwości współdzielenia.

## 6. Metryki sukcesu

1. Efektywność generowania planów podróży:

- 60% wygenerowanych przez AI planów podróży jest akceptowanych przez użytkownika bez większych zmian.
- Użytkownicy generują co najmniej 75% planów podróży z wykorzystaniem AI (w stosunku do wszystkich nowo dodanych planów).

2. Zaangażowanie:

- Średnio co najmniej 2 edycje planu podróży na użytkownika (świadome zaangażowanie w personalizację planów).
