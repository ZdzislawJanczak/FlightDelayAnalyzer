/*
Tutaj zdefiniuj schemę `reporting`
*/
CREATE SCHEMA IF NOT EXISTS "reporting"
;
/*
Tutaj napisz definicję widoku reporting.flight, która:
- będzie usuwać dane o lotach anulowanych `cancelled = 0`
- będzie zawierać kolumnę `is_delayed`, zgodnie z wcześniejszą definicją tj. `is_delayed = 1 if dep_delay_new > 0 else 0` (zaimplementowana w SQL)

Wskazówka:
- SQL - analiza danych > Dzień 4 Proceduralny SQL > Wyrażenia warunkowe
- SQL - analiza danych > Przygotowanie do zjazdu 2 > Widoki
*/
CREATE OR REPLACE VIEW reporting.flight as
SELECT 
    flight_id,
    flight_date,
    airline_id,
    origin_airport_id,
    destination_airport_id,
    scheduled_departure,
    actual_departure,
    dep_delay_new,
    cancelled,
    CASE
        WHEN dep_delay_new > 0 THEN 1
        ELSE 0
    END AS is_delayed
FROM
    flights
WHERE
    cancelled = 0
;
/*
Tutaj napisz definicję widoku reporting.top_reliability_roads, która będzie zawierała następujące kolumny:
- `origin_airport_id`,
- `origin_airport_name`,
- `dest_airport_id`,
- `dest_airport_name`,
- `year`,
- `cnt` - jako liczba wykonananych lotów na danej trasie,
- `reliability` - jako odsetek opóźnień na danej trasie,
- `nb` - numerowane od 1, 2, 3 według kolumny `reliability`. W przypadku takich samych wartości powino zwrócić 1, 2, 2, 3... 
Pamiętaj o tym, że w wyniku powinny pojawić się takie trasy, na których odbyło się ponad 10000 lotów.

Wskazówka:
- SQL - analiza danych > Dzień 2 Relacje oraz JOIN > JOIN
- SQL - analiza danych > Dzień 3 - Analiza danych > Grupowanie
- SQL - analiza danych > Dzień 1 Podstawy SQL > Aliasowanie
- SQL - analiza danych > Dzień 1 Podstawy SQL > Podzapytania
*/

CREATE OR REPLACE VIEW reporting.top_reliability_roads AS
WITH flight_stats AS (
    SELECT
        origin_airport_id,
        dest_airport_id,
        EXTRACT(YEAR FROM flight_date) AS year,
        COUNT(*) AS cnt,
        AVG(CASE WHEN dep_delay_new > 0 THEN 1 ELSE 0 END) AS reliability
    FROM
        flights
    WHERE
        cancelled = 0
    GROUP BY
        origin_airport_id,
        dest_airport_id,
        EXTRACT(YEAR FROM flight_date)
    HAVING
        COUNT(*) > 10000
),
airport_names AS (
    SELECT
        airport_id,
        airport_name
    FROM
        airports
),
ranked_stats AS (
    SELECT
        fs.origin_airport_id,
        oa.airport_name AS origin_airport_name,
        fs.dest_airport_id,
        da.airport_name AS dest_airport_name,
        fs.year,
        fs.cnt,
        fs.reliability,
        RANK() OVER (PARTITION BY fs.year ORDER BY fs.reliability) AS nb
    FROM
        flight_stats fs
    JOIN
        airport_names oa ON fs.origin_airport_id = oa.airport_id
    JOIN
        airport_names da ON fs.dest_airport_id = da.airport_id
)
SELECT
    origin_airport_id,
    origin_airport_name,
    dest_airport_id,
    dest_airport_name,
    year,
    cnt,
    reliability,
    nb
FROM
    ranked_stats
ORDER BY
    year,
    nb
;
/*
Tutaj napisz definicję widoku reporting.year_to_year_comparision, która będzie zawierał następujące kolumny:
- `year`
- `month`,
- `flights_amount`
- `reliability`
*/
CREATE OR REPLACE VIEW reporting.year_to_year_comparision AS
SELECT 1
;
/*
Tutaj napisz definicję widoku reporting.day_to_day_comparision, który będzie zawierał następujące kolumny:
- `year`
- `day_of_week`
- `flights_amount`
*/
CREATE OR REPLACE VIEW reporting.day_to_day_comparision AS
SELECT 1
;
/*
Tutaj napisz definicję widoku reporting.day_by_day_reliability, ktory będzie zawierał następujące kolumny:
- `date` jako złożenie kolumn `year`, `month`, `day`, powinna być typu `date`
- `reliability` jako odsetek opóźnień danego dnia

Wskazówki:
- formaty dat w postgresql: [klik](https://www.postgresql.org/docs/13/functions-formatting.html),
- jeśli chcesz dodać zera na początek liczby np. `1` > `01`, posłuż się metodą `LPAD`: [przykład](https://stackoverflow.com/questions/26379446/padding-zeros-to-the-left-in-postgresql),
- do konwertowania ciągu znaków na datę najwygodniej w Postgres użyć `to_date`: [przykład](https://www.postgresqltutorial.com/postgresql-date-functions/postgresql-to_date/)
- do złączenia kilku kolumn / wartości typu string, używa się operatora `||`, przykładowo: SELECT 'a' || 'b' as example

Uwaga: Nie dodawaj tutaj na końcu `;` - przy używaniu split, pojawi się pusta kwerenda, co będzie skutkowało późniejszym błędem przy próbie wykonaniu skryptu z poziomu notatnika.
*/
CREATE OR REPLACE VIEW reporting.day_by_day_reliability AS
SELECT 1
