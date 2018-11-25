As usual  there could be a number of different ways to get the same result. Here is how I did it:

myusers = LOAD '/user/cloudera/prac06/input/users.dat' 
  USING PigStorage(':') 
  AS (user:int, n1, gender:chararray, n2, age:int, n3, occupation:int, n4, zip:chararray);

ratings = LOAD '/user/cloudera/prac06/input/ratings.dat' 
  USING PigStorage(':') 
  AS (user:int, n1, movie:int, n2, rating:int, n3, timestamp:int);

data = JOIN ratings BY user, myusers BY user;
data_by_gender = GROUP data BY gender;

counts_by_gender = FOREACH data_by_gender GENERATE group, COUNT(data); 

STORE counts_by_gender INTO '/user/cloudera/prac06/pig_output' USING PigStorage('\t');
Don't forget to delete pig_output folder if it exists. You still work with MapReduce and rules stay the same: the process would fail if specified output folder exists.

Then run the script:

[cloudera@quickstart prac06]$ pig script.pig
