# FlightDelayAnalyzer
Celem projektu jest ćwiczenie analizy danych przy użyciu API do zdalnego serwera, wczytywania, czyszczenia i przetwarzania danych oraz zapisywania ich do plików CSV. W ramach projektu tworzona będzie struktura tabel w PostgreSQL, a następnie wypełnianie ich danymi, tworzenie widoków z użyciem grupowania i filtrowania danych po stronie serwera. Kolejnym etapem będzie tworzenie interaktywnych wizualizacji za pomocą DASH, które będą pokazywać zależności pomiędzy opóźnieniami a długością lotów, porą roku, opadami, grubością pokrywy śnieżnej oraz wyświetlanie:

- TOP 10 tras samolotów pod względem najniższego odsetka opóźnień w formie tabeli,
- porównania roku 2019 oraz 2020 w formie wykresu słupkowego:
    - miesiąc do miesiąca,
    - dzień tygodnia do dnia tygodnia,
 - danych dzień po dniu w formie szeregu czasowego.


The goal of the project is to practice data analysis using an API to a remote server, loading, cleaning, and processing data, and saving it to CSV files. The project involves creating table structures in PostgreSQL, populating them with data, and creating views using data grouping and filtering on the server side. Another key aspect is creating interactive visualizations using DASH that will show relationships between delays and flight durations, seasons, precipitation, snow cover thickness, as well as displaying:

- The TOP 10 flight routes with the lowest delay percentages in a table format,
- A comparison of the years 2019 and 2020 in the form of a bar chart:
    - month by month,
    - day of the week by day of the week,
- daily data in the form of a time series.