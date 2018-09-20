select sid,sname,rating 
from Sailors
where rating>8;

select sname,rating
from Sailors;

select sname 
from Sailors
where rating>8;

select distinct sname
from Sailors
join Reserves
on Sailors.sid=Reserves.sid
where bid=103;

select distinct name
from Sailors, Reserves, Boats
where Sailors.sid=Reserves.sid AND Reserves.bid=Boats.bid AND Boats.color=`red`;

select color
from Sailors, Reserves, Boats
where Sailors.sid=Reserves.sid 
AND Reserves.date=today
AND Sailors.name='POI' 
AND Reserves.bid=Boats.bid;

select distinct sname
from Sailors,Reserves AS r1, Reserves AS r2
where Sailors.sid=R1.sid
AND Sailors.sid=R2.sid
AND R2.sid!=R1.sid;

select sname
from Sailors, Reserves
where S.sid!=R.sid
AND S.age>20;
