/*
Your web application tracks the activities of its users using a tracking system. While a user hasn't logged in or signed up, all the user's actions are tracked using anonymous_id and the user_id is null, and afterwards they are tracked using the same anonymous_id and user_id. It is known that after a user logs in or signs up, the user_id is no longer null.

You are given the table tracks, which contains the following columns:

received_at - the unique timestamp of action;
event_name - the name of the action that was performed at this time;
anonymous_id - the anonymous ID of user;
user_id - the user ID, which can be null.
Your task is to find two events for each anonymous_id, which will be the column anonym_id in the returned table. Find the last event where the user was tracked only by anonymous_id (column last_null) and the first event that was tracked by user_id (column first_notnull). The resulting table should be sorted by anonym_id.

Note: It is not guaranteed that a user ever logs in or signs up. In this case, the column first_notnull should have a value of null. However, it is guaranteed that for each anonymous_id, there is at least one event where user_id equals null.

Example

For given table tracks

received_at	event_name	anonymous_id	user_id
2016-01-01 12:13:12	buttonClicked	1	NULL
2016-01-02 12:14:15	pageReloaded	3	NULL
2016-02-02 13:15:13	pageRendered	2	NULL
2016-02-03 13:15:23	commentWritten	3	NULL
2016-03-03 14:15:15	avatarUpdated	2	2
2016-03-04 14:15:24	statusUpdated	1	1
the output should be

anonym_id	last_null	first_notnull
1	buttonClicked	statusUpdated
2	pageRendered	avatarUpdated
3	commentWritten	NULL
*/

CREATE PROCEDURE trackingSystem()
BEGIN
    SELECT t1.anonymous_id anonym_id, t3.event_name last_null, t4.event_name first_notnull
	FROM (
        SELECT anonymous_id, MAX(received_at) d
        FROM tracks
        WHERE user_id IS NULL
        GROUP BY anonymous_id) t1
    LEFT JOIN (
        SELECT anonymous_id, MIN(received_at) d
        FROM tracks
        WHERE user_id IS NOT NULL
        GROUP BY anonymous_id) t2
    ON t1.anonymous_id = t2.anonymous_id
    LEFT JOIN tracks t3
    ON t1.anonymous_id = t3.anonymous_id AND t1.d = t3.received_at
    LEFT JOIN tracks t4
    ON t2.anonymous_id = t4.anonymous_id AND t2.d = t4.received_at
    ORDER BY anonym_id;
END