
SELECT Name,Alcohol from beers;
SELECT  Name FROM brewers;
  SELECT  City from brewers;



SELECT  DISTINCT City from brewers;
select name from beers where Alcohol < 5;


SELECT name from brewers where city = 'Malle';
SELECT  name from brewers where City = 'Brussel';/*er is niks*/
SELECT name from beers where Alcohol between 5 AND 7;
SELECT Name from beers where Alcohol in (0,5,8);
select Name FROM brewers where City in ('Leuven', 'Genk',' Antwerpen', 'Dendermonde', 'Wevelgem');
SELECT Name FROM beers WHERE Alcohol IS null;
SELECT Name from beers where Alcohol IS NOT null;
SELECT * FROM beers where name LIKE '%wit%' AND Alcohol > 5;
SELECT * FROM beers WHERE Name not like '%wit%';
SELECT * FROM beers WHERE Alcohol > 5;
SELECT * FROM beers WHERE Alcohol <= 5;

/*SELECT Name, Alcohol FROM beers ORDER BY NAME asc ;*/

select Name, Alcohol, BrewerId FROM beers ORDER BY Name , BrewerId;/*???????*/


select * from beers where Id=51;

select Name,Alcohol from beers order by 1 ASC ;
SELECT * FROM beers limit 100;
select * from beers limit 25 offset 50;/*??????? beginnen met 51ste record*/
select * from beers limit 50,25;/*???????*/
/*
 2.5 Oefeningen SELECT deel 1
Het getal achter de opgave zijn het aantal records dat gezocht wordt.
(a) Geef een lijst van alle biercategorieen. (38)
 */
select * from categories;
/*(b) Toon de lijst van categorieen in dalende alfabetische
volgorde zonder de categorie-id’s. (38)
*/
select Category from categories order by Category desc ;
/*
 (c) Toon een lijst van alle brouwerijen die meer dan 5000 Euro
turnover hebben.
 */
select * from brewers where Turnover > 5000;
/*

(d) Toon nu enkel de naam en de stad van de brouwerijen die
minder dan 5000 Euro turnover, maar niet 0. Sorteer de lijst
op basis van de turnover. (53)
oRDER BY ordert de namen op basis van turnover van klein tot groot
 */
 select Name, City from brewers where Turnover < 5000 and Turnover > 0 ORDER BY Turnover;
 /*
(e) Geef een lijst van alle mogelijke alcoholgehaltes in de
beers tabel. Dus geen dubbels. En gesorteerd van groot naar
klein. (14)
*/
select distinct Alcohol from beers order by Alcohol DESC ;

  /*
(f) Toon alle namen van bieren waarvan de naam “wit” bevat
zonder dubbels, alfabetisch gesorteerd. (30)
 */
   SELECT DISTINCT Name FROM beers where Name LIKE '%WIT%' order by Name;
   /*
(g) Toon alle bieren met meer alcohol dan 3 en minder dan 7
zonder gebruik te maken van logische operatoren (<, >, ...)
(568)
*/
SELECT Name, Alcohol FROM beers WHERE Alcohol BETWEEN 4 AND 6;

/*
(h) Geef de top 3 van de sterkste bieren in onze database. (3)
 */
 select Alcohol FROM beers ORDER BY Alcohol DESC limit 3;
/*
 (i) Doordenker: Maak een lijst van de naam, straat, postcode en stad voor alle brouwers in 3 kolommen voor een adressenlijst.
M.a.w. combineer de postcode en de stad in 1 kolom.
 */
 select Name, Address, concat(ZipCode,SPACE(1),City) AS city FROM brewers ;

select count(*) from beers;/*we zien dat de naam van column count(*) is*/
select count(Alcohol) from beers;
select sum(Alcohol) FROM beers;
select count(*) AS AANTAL FROM beers;/* met AS GEVEN WE EEN COLUMNNAAM */
SELECT avg(Alcohol) AS GEMIDDELD, max(Alcohol) as MAXIMUM, MIN(Alcohol) as Minimum, SUM(Alcohol) AS SOM from beers;
select BrewerId, avg(Alcohol) AS GEMIDDELDE FROM beers group by BrewerId;/*?????*/
select avg(Alcohol), Name FROM beers GROUP BY BrewerId;/*?????*/

select count(*)from brewers;
select avg(Turnover) from brewers;
select min(Alcohol) as laagste, avg(Alcohol) as gemiddelde, max(Alcohol) as hoogste
from beers;
select avg(Turnover) from brewers where ZipCode like '1%' and Name not like 'palm';
select CategoryId, avg(Alcohol)from beers group by CategoryId ;
select MAX(Price), CategoryId from beers
where Stock >0 and Price > 3
group by CategoryId;

select beers.Name as NameBeers , brewers.name as NameBrewers from beers INNER JOIN brewers on beers.BrewerId = brewers.Id;/* 1 */
select beers.Name as NameBeers , brewers.Name as NameBrewers , categories.Category from beers
    INNER join brewers on beers.BrewerId = brewers.Id
    INNER join categories on beers.CategoryId = categories.Id;/* 2 */

select beers.Name, brewers.Name from beers, brewers where beers.BrewerId = brewers.Id;/* 1 */

select beers.Name as NameBeers, brewers.Name as NameBrewers, categories.Category from beers, brewers, categories
where beers.BrewerId = brewers.Id AND beers.CategoryId = categories.Id;/* 2 */

select Name, Category from categories left join beers  on categories.id = beers.CategoryId ;

SELECT b1.name, b2.Name
from brewers as b1 inner join brewers as b2
on b1.city = b2.City and b1.Id < b2.Id;
/*
 2.11 Oefeningen SELECT deel 4
(a) Toon een lijst van alle biernamen en hun categorie-naam van
alle bieren met 0% alcohol. (31)*/
SELECT Name AS BEERNAAM, Category AS CATEGORIENAAM
FROM beers INNER JOIN categories on beers.CategoryId = categories.Id  WHERE Alcohol = 0;

/*
(b) Toon een lijst van alle brouwers met de prijs van hun
duurste bier.
(records 113 - gedeeltelijk resultaat:
Achouffe - 3.06
Alken - 4.5)
 */
select brewers.Name, max(Price)from beers inner join brewers on beers.BrewerId = brewers.Id group by BrewerId;

/*
 (c) Toon ‘alle’ bieren met een id tussen 1500 en 1600 met hun
eventuele brouwer(naam). (41)*/
select beers.Name as beerName, beers.Id, brewers.Name as brewersName from beers inner join brewers  on beers.BrewerId = brewers.Id
where beers.Id between 1500 and 1600;
/*
(d) Toon de top 3 bieren (id en naam) met het meeste alcohol
samen met de naam van de brouwer en de categorienaam.
529 - Fitt - Wieze - Alcoholarm
229 - Bush de Noel - Dubuisson - Gerstewijn
511 - Fantome brewery (The best of) - Fantome - Massieve Ale
 */
 select beers.Name, beers.Id, Alcohol, brewers.Name
from beers inner join brewers on beers.BrewerId = brewers.Id where Alcohol = (select max(Alcohol),beers.Name  and count(Alcohol)= 3
union (select beers.Name, categories.Category from categories
inner join beers on beers.CategoryID = Categories.Id);

select b1.* FROM beers b1 WHERE b1.Alcohol < (select avg(b2.Alcohol) from beers b2 where b2.CategoryId = b1.CategoryId);
/*
 2.14 Oefeningen SELECT deel 5
(a) Selecteer de brouwers die een turnover hebben die hoger dan
het gemiddelde is. (16)*/
 SELECT * from brewers  where Turnover is not null and Turnover > (select AVG(Turnover) FROM brewers);
/*
(b) Toon alle bieren die het minimum of maximum alcohol gehalte
hebben. (33)*/
SELECT * FROM beers WHERE Alcohol in (select (max(Alcohol), min(Alcohol)) FROM beers);
/*
(c) Toon alle bieren met een alcohol hoger dan het gemiddelde
en waarvan de brouwers een turnover hebben dat boven het
gemiddelde ligt. (60)
*/
select * from beers  where Alcohol > (select avg(Alcohol) from beers ) and BrewerId in(select id from
brewers where Turnover > (select avg(Turnover) from brewers )) ;

select *
from beers
where Alcohol > (select avg(Alcohol) as average from beers)
and BrewerId in
(
select id
from brewers
where Turnover > (
select avg(Turnover) as a
from brewers));
/*
(d) Doordenker zonder search: Toon een lijst van alle brouwers
met de prijs en naam van hun duurste bier. Het is mogelijk
dat er meerdere bieren per brouwer geselecteerd worden. (266)
 */

select beers.price, beers.name from beers
inner join brewers  where brewers.Id = beers.BrewerId;









/*
 in de klas
 */

  select   Name , Category
FROM categories
LEFT JOIN beers ON categories.Id = beers.CategoryId;

SELECT * from beers
where Name like '%ale%'

/*
 we zien boven dat er geen semicolon is
 */
 SELECT name from beers
where Alcohol between 5 and 7;

SELECT name from beers
where Alcohol IN (0,5,8);
/*
 Ik wil de namen van beers als alcohol 0,5,8 bevat
 IN wordt als or gebruikt
 */
SELECT name from brewers
where City in ('Wevelgem','Antwerpen','Dendermonde','Halle');
/*
 IN multiple or
 */


SELECT name from beers
where Name NOT like '%wit%'
and Alcohol > 5;
/*

 .
 NOT like of like ...extra

pas het percentage op bij wit
we willen  het woord(wit) niet , daarrom hebben wij (Not like %) gebruiken
 */

SELECT name from brewers
where city= 'antwerpen' or City = 'Wevelgem'

SELECT  Name from beers
where Image is not null;
/*
Use the NOT keyword to select all records where Image is NOT null
in de table hebben we alle images not null
 */
SELECT Name,Alcohol
FROM beers
ORDER BY 1 DESC LIMIT 10 OFFSET 50;
/*
 ORDER BY Name DESC ;  ....extra
de nummers van onze colums krijgen

 ORDER BY 1 DESC LIMIT 5; OM alleen maar 5 resultaten te krijgen
 ORDER BY 1 DESC LIMIT 10 OFFSET 50; ......> EXTRA
 */
 SELECT * FROM categories;
SELECT Category FROM categories
ORDER BY Category DESC ;

SELECT * FROM brewers
WHERE Turnover > 5000;


SELECT Name,City from brewers
WHERE Turnover < 5000 and Turnover > 0 ORDER BY Turnover;

select DISTINCT AlCOHOL from beers
order by Alcohol DESC ;



SELECT Name from beers
where Name like '%wit%'
order by Name;


SELECT Name,Alcohol FROM beers
where Alcohol between  4 AND 6;

SELECT * from beers
ORDER BY Alcohol desc limit 3;

SELECT Name,Address,CONCAT(ZipCode,space(1),City) As City
FROM brewers;


/*

 (a) Geef een lijst van alle biercategorieen. (38)   
 (b) Toon de lijst van categorieen in dalende alfabetische  volgorde zonder de categorie-id’s. (38) 
   (c) Toon een lijst van alle brouwerijen die meer dan 5000 Euro  turnover hebben. (54) 
   (d) Toon nu enkel de naam en de stad van de brouwerijen die  minder dan 5000 Euro turnover, maar niet 0.
 Sorteer de lijst  op basis van de turnover. (53)   
 (e) Geef een lijst van alle mogelijke alcoholgehaltes in de  beers tabel. Dus geen dubbels. En gesorteerd van groot naar  klein.
 (14)    (f) Toon alle namen van bieren waarvan de naam “wit” bevat  zonder dubbels, alfabetisch gesorteerd. (30)    (g) Toon alle bieren met meer alcohol dan 3 en minder dan 7  zonder gebruik te maken van logische operatoren (<, >, …)  (568)    (h) Geef de top 3 van de sterkste bieren in onze database. (3)    (i) Doordenker: Maak een lijst van de naam, straat, postcode en 
SQL - 19/54
stad voor alle brouwers in 3 kolommen voor een adressenlijst.  M.a.w. combineer de postcode en de stad in 1 kolom
 */

 SELECT COUNT(*) AS Total FROM BEERS;
SELECT AVG(Alcohol) As Average,
       MAX(Alcohol) as Maximum,
       MIN(Alcohol) AS Minimum,
       SUM(Alcohol) as  sum,
       FROM BEERS;
/*
 WRITE A QUERY TO CALCULATE THE AVERAGE ALCOHOL ù PER BREWERiD
 */
SELECT AVG(Alcohol) , BrewerId
FROM beers
group by BrewerId;

/*SELECT Alcohol FROM beers where BrewerId = 110;
select sum(Alcohol) from beers where BrewerId = 110;
select sum(Alcohol) / 11 from beers*/


SELECT LEFT(Name,1) AS First,AVG(Alcohol) AS Average
FROM beers
GROUP BY First;
/* write a query to find the minimum alcohol % per brewerId from beers grouped by brewerId and has less than 5% alcohol

 */
 SELECT BrewerId, MIN(Alcohol) AS Minimum
 FROM beers
GROUP BY BrewerId
HAVING Minimum < 5;


/* write query to calculate avg alcohol % per brewerId
   for all the brewers that produce more than 10 beers
 */
 SELECT BrewerId, AVG(Alcohol) AS Minimum
 FROM beers
Group bY BrewerId
HAvING COUNT(*) > 10;

SELECT  Name,
       Turnover * 0.90 AS omzet_Dollar,
       Turnover * 1.12 as omzet_yen
FROM brewers;

/*
 2.8 Oefening SELECT deel 2   (a) Hoeveel verschillende brouwers zitten er in de database?  (118) 
 */
 SELECT COUNT(*) from brewers;

/*
 (b) Bereken de gemiddelde turnover van alle brouwers.    (114302.1525)
 */
 SELECT AVG(Turnover) FROM brewers;
/*
 (c) Geef het laagste, gemiddelde en hoogste alcoholgehalte uit  de beers tabel in 1 instructie.  (0, 5.8706, 15)
 */
 SELECT min(Alcohol),AVG(Alcohol) As Avarage ,MAX(Alcohol) from beers;
SELECT min(Alcohol) AS lock in share mode Minimum,
       AVG(Alcohol) AS AVerage

/*

 (d) Bereken de gemiddelde turnover van alle brouwers in de  provincie Brabant
 (postcodes die beginnen met een 1) maar  negeer de brouwerij ‘Palm’.  (39525.7143)
 */
 SELECT AVG(Turnover) FROM brewers
WHERE ZipCode  like '1%' AND Name  not LIKE 'Palm';

/*

(e) Bereken het gemiddelde alcohol per categorie(id).  (114 records)
 */
 SELECT avg(Alcohol),CategoryId
FROM beers group by CategoryId;

SELECT AVG(Alcohol) FROM beers
group by BrewerId;
/*

(f) Toon de hoogste bier prijs per categorie maar negeer alle  bieren die niet in stock zijn.
Sorteer het resultaat op  categorieid. Zorg er ook voor dat we enkel prijzen zien die  hoger zijn dan 3.  (5 records
 */
 SELECT MAX(Price) AS Price , Stock
from beers
 where Stock > 0
 GROUP BY CategoryId
 HAVING Price > 3;

select MAX(price) AS Max_price
FROM beers
where Stock > 0 AND Price > 3
GROUP BY CategoryId;


SELECT beers.Name, brewers.Name
FROM beers
INNER join brewers on beers.Name = brewers.Name;
/*
 join 2.9
 */

 SELECT beers.Name, b.Name , c.Category
from beers
INNER join brewers b on beers.BrewerId = b.Id
    INNER JOIN brewers br on beers.Name = br.Name
INNER JOIN categories c on beers.CategoryId = c.Id;

SELECT beers.Name, brewers.Name
FROM beers,brewers
WHERE beers.BrewerId = brewers.Id;

SELECT  * from beers, brewers;







