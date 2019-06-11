create table table2(Id integer primary key auto_increment, Rating Integer , Name varchar(225));
/*

 de naam kan Text zijn
 */
INSERT into table2(Rating, Name)
values (23,'book1'),(2225,'book2'),(56,'book3');
/*SELECT  * FROM table2;
  */
 SELECT name From table2 where id=1;

