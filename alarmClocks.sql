/*
You are developing an alarm clock app that works as follows: the user can set a date and a time, and the app will ring every week at the given time, starting at the given date until the end of the current year.

The starting date is the only record in the userInput table, which has the following structure:

input_date: the date and time of the first alarm (of a DATETIME type).
Given the table, your task is to write a select statement which returns a single column alarm_date. This column should contain all dates (including the time) when the alarm clock will ring. The entries should be arranged in ascending chronological order.

Example

For the following table userInput

input_date
2016-10-23 22:00:00
the output should be

alarm_date
2016-10-23 22:00:00
2016-10-30 22:00:00
2016-11-06 22:00:00
2016-11-13 22:00:00
2016-11-20 22:00:00
2016-11-27 22:00:00
2016-12-04 22:00:00
2016-12-11 22:00:00
2016-12-18 22:00:00
2016-12-25 22:00:00
*/

CREATE PROCEDURE alarmClocks()
BEGIN
   DECLARE nextDate DATETIME;
   DECLARE year INTEGER;

   DROP TEMPORARY TABLE IF EXISTS alarmDates;
   CREATE TEMPORARY TABLE IF NOT EXISTS alarmDates (alarm_date DATETIME);

   SELECT input_date, YEAR(input_date) INTO nextDate, year FROM userInput;

   WHILE YEAR(nextDate) = year DO

      INSERT INTO alarmDates SET alarm_date = nextDate;

      SET nextDate = nextDate + INTERVAL 1 WEEK;

   END WHILE;

   SELECT * FROM alarmDates;
   
END