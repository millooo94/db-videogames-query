-- join

-- 1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
select [name], lastname, nickname, city, COUNT(players.id) as n_recensioni
from players
join reviews
on players.id = reviews.player_id
group by players.[name], players.lastname, players.nickname, players.city

-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
select distinct videogames.id, videogames.name
from videogames
join tournament_videogame
on videogames.id = tournament_videogame.videogame_id
join tournaments
on tournament_videogame.tournament_id = tournaments.id
where year like 2016

-- 3- Mostrare le categorie di ogni videogioco (1718)
select videogames.[name], categories.[name]
from videogames
join category_videogame
on videogames.id = category_videogame.videogame_id
join categories
on category_videogame.category_id = categories.id

-- 4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
select distinct software_houses.[name]
from software_houses
join videogames
on software_houses.id = videogames.software_house_id
where year(videogames.release_date) > 2020

-- 5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
select awards.[name],software_houses.[name]
from software_houses
join videogames
on software_houses.id = videogames.software_house_id
join award_videogame
on videogames.id = award_videogame.videogame_id
join awards
on award_videogame.award_id = awards.id

-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
select categories.[name],pegi_labels.[name],videogames.[name]
from videogames
join category_videogame
on videogames.id = category_videogame.videogame_id
join categories
on category_videogame.category_id = categories.id
join pegi_label_videogame
on videogames.id = pegi_label_videogame.videogame_id
join pegi_labels
on pegi_label_videogame.pegi_label_id = pegi_labels.id
join reviews
on videogames.id = reviews.videogame_id
where reviews.rating > 3
group by categories.[name],pegi_labels.[name],videogames.[name]

-- 7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
select distinct videogames.id, videogames.name
from videogames
join tournament_videogame 
on videogames.id = tournament_videogame.videogame_id
join tournaments 
on tournament_videogame.tournament_id = tournaments.id
join player_tournament 
on tournaments.id = player_tournament.tournament_id
join players 
on player_tournament.player_id = players.id
where players.name LIKE 'S%'

-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
select distinct tournaments.city
from tournaments
join tournament_videogame 
on tournaments.id = tournament_videogame.tournament_id
join videogames 
on tournament_videogame.videogame_id = videogames.id
join award_videogame 
on videogames.id = award_videogame.videogame_id
where award_videogame.year = '2018'

-- 9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
select distinct players.nickname, tournaments.id
from players
join player_tournament 
on players.id = player_tournament.player_id
join tournaments 
on player_tournament.tournament_id = tournaments.id
join tournament_videogame 
on tournaments.id = tournament_videogame.tournament_id
join videogames 
on tournament_videogame.videogame_id = videogames.id
join award_videogame 
on videogames.id = award_videogame.videogame_id
where tournaments.year = '2019'
and award_videogame.year = '2018'


--GROUP BY

--1- Contare quante software house ci sono per ogni paese (3)
select software_houses.country, COUNT(software_houses.country) as n_software_houses
from software_houses
group by software_houses.country

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
select videogames.[name], COUNT(reviews.id) as n_recensioni
from reviews
join videogames
on reviews.videogame_id = videogames.id
group by reviews.videogame_id, videogames.[name]

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
select pegi_labels.[name] ,COUNT(pegi_label_videogame.videogame_id) as n_videogiochi
from pegi_labels
join pegi_label_videogame 
on pegi_labels.id = pegi_label_videogame.pegi_label_id
group by pegi_labels.[name]

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
select DATEPART(year, release_date), COUNT(id) as n_videogiochi
from videogames
group by DATEPART(YEAR, release_date)

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
select devices.name, COUNT(device_videogame.videogame_id) as n_videogiochi
from devices
join device_videogame 
on devices.id = device_videogame.device_id
group by devices.name

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
select videogames.name, AVG(reviews.rating)
from videogames
join reviews ON videogames.id = reviews.videogame_id
group by videogames.name
order by AVG(reviews.rating)


--SELECT

--1- Selezionare tutte le software house americane (3)
select *
from software_houses
where country like 'United States'

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
select *
from players
where city like 'Rogahnland'

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
select *
from players
where name LIKE '%a'

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
select *
from reviews
where player_id = 800

--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
select COUNT(id) as n_tornei
from tournaments
where year = 2015

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
select *
from awards
where description like '%facere%'

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
select distinct videogames.name
from videogames
join category_videogame 
on videogames.id = category_videogame.videogame_id
where category_videogame.category_id = 2 OR category_videogame.category_id = 6

--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
select * 
from reviews
where rating >= 2 AND rating <= 4

--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
select *
from videogames
where DATEPART(YEAR, release_date) = 2020

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)
select distinct videogames.id
from videogames
join reviews 
on videogames.id = reviews.videogame_id
where reviews.rating = 5

--BONUS

--n11
select COUNT(rating) as n_reating, AVG(rating)as media
from reviews
where videogame_id = 412

--n12
select COUNT(id) as n_videogiochi
from videogames
where software_house_id = 1 
and DATEPART(YEAR, release_date) = 2018