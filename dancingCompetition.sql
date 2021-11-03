/*
During the dance contest, each judge evaluates the dancers' performances based on three criteria, using a score from 1 to 10 for each of the criteria. You are given a table of the scores awarded to a specific dancer by each judge. Recently, the dance contest made the decision to drop scores awarded by a certain judge if that judge gave an extreme (either minimum or maximum) score for at least two criteria.

For example, if the judge awarded one of the minimum scores for musicality (i.e., there may be similar scores for musicality, but there may not be smaller scores for that criterion) and one of the maximum scores for floorcraft, all three of the scores given by that judge should not be taken into account.

Return a table that consists of only the scores that should be considered after this filtering, sorted by arbiter_id.

The scores table contain the following columns:

arbiter_id - the unique ID of the judge;
first_criterion - the score given for the first criterion;
second_criterion - the score given for the second criterion;
third_criterion - the score given for the third criterion.
Example

For given table scores

arbiter_id	first_criterion	second_criterion	third_criterion
1	3	10	10
2	2	3	4
3	5	6	7
4	2	5	9
5	2	2	2
the output should be

arbiter_id	first_criterion	second_criterion	third_criterion
2	2	3	4
3	5	6	7
4	2	5	9
The first judge gave the maximal scores for the second and third criteria, so his scores aren't included in the answer. The fifth judge's given scores are all minimal, so her scores aren't included to the answer either.
*/

CREATE PROCEDURE dancingCompetition()
BEGIN
      select scores.*
      from scores,
      (select 
                min(first_criterion) as min1,
                max(first_criterion) as max1,
                min(second_criterion) as min2,
                max(second_criterion) as max2,
                min(third_criterion) as min3,
                max(third_criterion) as max3
        from scores) as extremes
        where
            if(first_criterion=min1 || first_criterion =max1,1,0)+
            if(second_criterion=min2 || second_criterion =max2,1,0)+
            if(third_criterion=min3 || third_criterion =max3,1,0)<2;

END