create database online_music_player;
use online_music_player;
create table users (user_id int primary key ,user_name varchar(50) ,email text);
insert into users(user_id,user_name,email)values (1,"Aarya","aarya123@gamil.com"),
(2,"Aarav","aarav231@gamil.com"),(3,"vansh","vanshah56@gamil.com"),(4,"veer","veer567@gamil.com"),(5,"kiara","kiara58@gamil.com"),
(6,"manvi","manvi56@gamil.com");
create table artist (artist_id int primary key ,artist_name varchar(50));
insert into artist (artist_id,artist_name)values (1,"Taylor Swift"),(2,"Arijit Singh"),(3,"weekend"),(4,"Ariana Grande"),(5,"Cold play"),
(6,"shreya goshal"),(7,"Drake"),(8,"Ed sheeran");
create table album (album_id int primary key ,album_name varchar(50),artist_id int ,foreign key(artist_id) 
references artist(artist_id),realease_year year);
insert into album (album_id,album_name ,artist_id,realease_year) values (1,"Midnights",1,2022),(2,"Folklore",1,2020),(3,"After hours",3,2020),
(4,"starboy",3,2016),(5,"Divide",8,2017),(6,"equals",8,2021),(7,"ghost stories",5,2014),(8,"Parachutes",5,2000),(9,"Aashiqui 2",2,2013)
,(10,"kalank",2,2019),(11,"thank you next",4,2019),(12,"views",7,2016);
create table songs (song_id int  primary key ,song_title varchar (60),
album_id int ,foreign key (album_id) references album(album_id),duration int,gerne varchar(40));
insert into songs (song_id,song_title,album_id,duration,gerne) values (1,"Anti hero",1,210,"pop"),
(2,"Lavender haze",1,202,"pop"),(3,"Blinding lights",3,200,"pop"),(4,"save your tears",3,215,"pop"),(5,"shape of u",5,235,"pop"),
(6,"perfect",5,260,"pop"),(7,"fix you",7,295,"rock"),(8,"yellow",8,270,"rock"),(9,"tum he ho",9,240,"romantic"),
(10,"kalank title track",10,260,"romantic"),(11,"7 rings",11,190,"pop"),(12,"gods plan",12,198,"hip pop"),(13,"photograph",5,230,"pop"),
(14,"sky full of starts",7,280,"pop"),(15,"channa mereya",9,270,"romantic"),(16,"kesariya",10,280,"romantic"),
(17,"starboy",4,240,"pop"),(18,"die for u",3,250,"pop"),(19,"bad habits",6,230,"pop"),(20,"happier",6,235,"pop");
create table playlist(playlist_id int primary key,user_id int ,foreign key(user_id) references 
users(user_id),playlist_name varchar(60),is_public boolean );
insert into playlist (playlist_id,user_id,playlist_name,is_public)values(1,1,"chill vibes",1),(2,1,"study time",0),(3,2,"workout hit",1),
(4,2,"love songs",1),(5,3,"late night",0),(6,3,"party mix",1),(7,4,"focus mode",0),(8,4,"travel songs",1),(9,5,"sad songs",0),
(10,5,"favourites",0),(11,6,"morning boost",1),(12,6,"relax & calm",0);
create table playlist_song (playlist_id int,foreign key(playlist_id) references playlist(playlist_id),song_id int , foreign key(song_id) 
references songs(song_id));
insert into playlist_song (playlist_id,song_id) values(1,1),(1,3),(1,5),(1,14),(2,9),(2,10),(3,3),(3,12),(3,17),(4,9),(4,15),(4,16),(6,11),
(6,18),(6,12),(8,7),(8,8),(8,14);
create table listening_history (history_id int primary key,user_id int ,foreign key(user_id) references
 users(user_id),song_id int, foreign key(song_id) references songs(song_id),listen_time date );
 insert into listening_history (history_id,user_id,song_id,listen_time) values (1,1,1,'2025-01-10'),(2,1,3,'2025-01-10'),(3,1,3,'2025-01-11'),
 (4,2,9,'2025-01-11'),(5,2,15,'2025-01-12'),(6,3,12,'2025-01-13'),(7,3,12,'2025-01-14'),(8,4,7,'2025-01-13'),(9,4,14,'2025-01-14'),
 (10,5,9,'2025-01-14'),(11,6,5,'2025-01-15'),(12,6,6,'2025-01-15');
 select p.playlist_name as playlist , u.user_name as users
 from playlist p
 join users u on p.user_id = u.user_id
 where p.is_public =1;
 select l.listen_time as listening_history ,u.user_id as users
 from listening_history l
 join users u on l.user_id = u.user_id;
 select s.song_title as songs ,a.album_name as album
 from songs s
 left join album a on a.album_id = s.album_id ;
 create view user_playlist_infoview as
 select u.user_id as users ,p.playlist_id as playlist,l.listen_time as listening_history
 from users u
 join listening_history l on l.user_id = u.user_id
 join playlist p on p.user_id = u.user_id;
 select*from user_playlist_infoview;
 
 create view user_infoview as
 select u.user_name as users ,p.playlist_name as playlist,l.listen_time as listening_history
 from users u
 join listening_history l on l.user_id = u.user_id
 join playlist p on p.user_id = u.user_id;
 select*from user_infoview;
 select s.gerne as songs ,count(*) as listens
 from listening_history l
 join songs s on s.song_id = l.song_id
 where l.user_id =1
 group by s.gerne
 order by listens desc;
 select distinct s.gerne
 from songs s
 where s.gerne =(select s2.gerne
 from listening_history l2
 join songs s2 on l2.song_id=s2.song_id
 where l2.user_id =1
 group by s2.gerne
 order by count(*)desc 
 limit 1)
 and s.song_id not in (select song_id 
 from listening_history 
 where user_id =1);
 
 
 
 

 
 
 
 
 
 
  
 
