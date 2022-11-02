# Data_Analyst_Challenge
Braintree Analytics Code Challenge that applies SQL techniques into day-to-day problems



## Solution Setup

It has been chosen a ver simplistic architecture to solve the challenge. As it was requested a relational database itself, it was proposed the use of sqlite3 and the SQLiteStudio, but any SQL client or Database Managment System would do the trick, such as Dbeaver. In order to setup the requested tables, the following steps were executed.
 1. A new database was created and named challenge_database directly through SQLiteStudio.
 2. Each table has been created via DDL.
   * ```CREATE TABLE continent_map (country_code text, continent_code text)```
   * ```CREATE TABLE CREATE TABLE continents (continent_code text, continent_name text)```
   * ```CREATE TABLE countries (country_code text, year integer, gdp_per_capita numeric)```
   * ```CREATE TABLE per_capita (country_code text, year integer, gdp_per_capita numeric)```
 3. CSV were inserted into tables.
  Imported through SQLiteStudio inteface or directly via sqlite3 commands:
  * .mode csv
  * .import <csv_path/csv_file> <table>
 4. First row , of headers, deleted.
