# ORM Benchmark (Česky)

Tento projekt porovnává výkon několika ORM a databázových frameworků pro Javu a Kotlin.

## Prostředí
* **Verze Javy:** Java 25
* **Databáze:** H2 Database in-memory (verze 2.4.240)
* **Hardware/Paměť:** ~15 GiB celkové dostupné paměti RAM (testováno na stroji s 15 GiB RAM a 4 GiB swap)

## Testované frameworky
* **Hibernate Core:** `7.0.0.Final`
* **JDBI3 Core:** `3.51.0`
* **Exposed:** `0.58.0`
* **Ujorm3:** `3.0.0`

## Testovací scénáře
Všechny testy ignorují počáteční zahřívací fázi (warm-up), aby bylo zajištěno přesné měření po JIT kompilaci a bez zkreslení alokací paměti.
* **Batch Insert:** Vkládá vygenerované záznamy zaměstnanců do databáze pomocí dávkového zpracování (velikost dávky 50).
* **Specific Update:** Aktualizuje konkrétní sloupce (`salary` a `updated_at`) pro všechny existující záznamy zaměstnanců v rámci jediné transakce.
* **Random Update:** Prochází všechny zaměstnance a náhodně jim mění buď stav `is_active`, nebo název oddělení `department`. Simuluje tak nepředvídatelnou zátěž; ukládá se v dávkách.
* **Read With Relations:** Načte všechny záznamy zaměstnanců společně s navázanými entitami města (`City`) a nadřízeného (`Employee`) pomocí SQL JOINů (zamezení problému N+1 selectů).

## Aktuální výsledky (Dočasné)


| Library | Test Name | Iterations | Duration (s) | JAR Size |
| :--- | :--- | :--- | :--- |:---------|
| Hibernate | Batch Insert | 500_000 | 3.213_134_799 | 25.68 MB |
| Hibernate | Specific Update | 500_000 | 6.928_705_260 |  |
| Hibernate | Random Update | 500_000 | 6.943_549_378 |  |
| Hibernate | Read With Relations | 500_000 | 0.266_071_497 |  |
| Jdbi | Batch Insert | 500_000 | 2.120_783_941 | 3.89 MB |
| Jdbi | Specific Update | 500_000 | 7.238_879_617 |  |
| Jdbi | Random Update | 500_000 | 3.595_968_380 |  |
| Jdbi | Read With Relations | 500_000 | 0.314_234_752 |  |
| Exposed | Batch Insert | 500_000 | 4.027_784_283 | 9.80 MB |
| Exposed | Specific Update | 500_000 | 8.538_321_269 |  |
| Exposed | Random Update | 500_000 | 7.923_898_659 |  |
| Exposed | Read With Relations | 500_000 | 1.838_429_367 |  |
| Ujorm | Batch Insert | 500_000 | 1.629_807_284 | 2.74 MB |
| Ujorm | Specific Update | 500_000 | 7.617_236_893 |  |
| Ujorm | Random Update | 500_000 | 7.612_588_579 |  |
| Ujorm | Read With Relations | 500_000 | 0.760_386_230 |  |

