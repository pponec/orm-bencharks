# ORM Benchmark

This project compares the performance of several Java/Kotlin ORM and database mapping frameworks.

## Environment
* **Java Version:** Java 25
* **Database:** H2 Database in-memory (version 2.4.240)
* **Hardware/Memory:** ~15 GiB total RAM available (tested on a machine with 15 GiB RAM and 4 GiB swap)

## Tested Frameworks
* **Hibernate Core:** `7.0.0.Final`
* **JDBI3 Core:** `3.51.0`
* **Exposed:** `0.58.0`
* **Ujorm3:** `3.0.0`

## Test Scenarios
All tests exclude the initial warm-up phase to ensure accurate JIT compilation and memory allocation measurements.
* **Batch Insert:** Inserts generated employee records into the database using JDBC batching (batch size of 50).
* **Specific Update:** Updates specific columns (`salary` and `updated_at`) for all existing employee records in a single transaction.
* **Random Update:** Iterates through all employees and randomly modifies either their `is_active` status or `department` name to simulate unpredictable workload, saved in batches.
* **Read With Relations:** Retrieves all employee records along with their associated `City` and superior `Employee` entities using SQL JOINs (preventing the N+1 select problem).

## Current Results (Temporary)

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


---

