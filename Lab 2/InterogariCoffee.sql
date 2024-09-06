--Inteorgari CoffeeToGo

go
use CoffeeToGo
go

--1. Va cauta cafenelele in care exista cel putin o carte de aventura
-- Se va afisa id-ul cafenelei, numele si totalul cartilor de aventura, in ordine crescatoare a numarului de carti avute

SELECT A.IdCafenea, A.Nume,
COUNT(A.Gen) AS TotalCartiAventura
FROM
(SELECT caf.IdCafenea, caf.Nume, crt.Gen
FROM Cafenele caf INNER JOIN Carti crt ON caf.IdCafenea = crt.IdCafenea
WHERE Gen = 'Aventura')A
GROUP BY A.IdCafenea, A.Nume
ORDER BY TotalCartiAventura 

--2. Va cauta cafenelele in care toti angajatii au varste cuprinse intre 18 si 30 de ani
--Se va afisa id-ul cafenelei, numele, totalul de angajati si nr de angajati cu varste intre 18 si 30 de ani, 
--in ordine descrescatoare a acestui numar calculat

SELECT A.IdCafenea, A.Nume, A.NumarAngajati,
COUNT(A.Varsta) AS TotalAngajati1830
FROM
(SELECT c.IdCafenea, c.Nume, c.NumarAngajati, a.Varsta
FROM Cafenele c INNER JOIN Angajati a ON c.IdCafenea = a.IdCafenea
WHERE a.Varsta >= 18 AND a.Varsta <= 30) A
GROUP BY A.IdCafenea, A.Nume, A.NumarAngajati
HAVING COUNT(A.Varsta) = A.NumarAngajati


--3. Se va calcula numarul de cafenele pentru care livreaza fiecare furnizor
--sa va afisa pentru fiecare furnizor id-ul, numele, tipul de produs livrat dar si numarul de cafenele pentru care livreaza

SELECT A.IdFurnizor, A.Nume, A.ProduseLivrate,
COUNT(A.IdCafenea) AS TotalCafeneleDeservite
FROM
(SELECT f.IdFurnizor, f.Nume, cf.IdCafenea, f.ProduseLivrate
FROM Furnizori f INNER JOIN CafeneleFurnizori cf on f.IdFurnizor = cf.IdFurnizor 
INNER JOIN Cafenele c on c.IdCafenea=cf.IdCafenea)A
GROUP BY A.IdFurnizor, A.Nume, A.ProduseLivrate

--4. Se se gaseasca cafenelele pt care totalul stickerelor acumulate pe toate cardurile de fidelitate ale clientilor 
--este mai mare sau egal cu 10
--Se va afisa pentru fiecare cafenea id-ul, numele si nr total de stickere, in ordine descrescatoare dupa nr de stickere
SELECT A.IdCafenea, A.Nume,
SUM(A.NumarStickere) AS TotalStickerePerCafenea
FROM
(SELECT caf.IdCafenea, caf.Nume, crd.NumarStickere
FROM Cafenele caf INNER JOIN Clienti cl on caf.IdCafenea = cl.IdCafenea 
INNER JOIN CardFidelitate crd on crd.IdClient = cl.IdClient)A
GROUP BY A.IdCafenea, A.Nume
HAVING SUM(A.NumarStickere) >= 10
ORDER BY TotalStickerePerCafenea DESC

--5. Sa se gaseasca toate preturile distincte de cafele din meniu, cuprinse intre 10 si 15
SELECT DISTINCT Pret
FROM MeniuCafele
WHERE Pret >= 10 AND Pret <= 15

--6. Sa se gaseasca toate cafelele distincte din comenzile plasate de clienti, care au aroma de ciocolata 
--Se vor afisa codurile de produs, numele, paharul, aroma si tipul de cafea
SELECT DISTINCT A.CodProdus, A.Nume, A.Pahar, A.Aroma, A.TipCafea
FROM (SELECT c.IdComanda, mc.CodProdus, mc.Nume, mc.Pahar, mc.Aroma, mc.TipCafea
FROM Comenzi c INNER JOIN ComenziCafele cf on c.IdComanda = cf.IdComanda 
INNER JOIN MeniuCafele mc on mc.CodProdus = cf.CodProdus WHERE mc.Aroma = 'Ciocolata')A


--7. Se va calcula pretul mediu al unei comenzi de dulciuri 
SELECT
AVG(A.Pret) AS PretMediu
FROM
(SELECT c.IdComanda, cd.CodProdus, md.Pret
FROM Comenzi c INNER JOIN ComenziDulciuri cd on c.IdComanda = cd.IdComanda 
INNER JOIN MeniuDulciuri md on md.CodProdus = cd.CodProdus)A

--8. Se se caute comenzile de cafele ce contin produse cu tipul de cafea 'Arabica'
--Se va afisa id-ul comenzii, id-ul clientului, numele si tipul de cafea
SELECT A.IdComanda, A.IdClient, A.Nume, A.TipCafea
FROM
(SELECT cl.IdClient, cl.Nume, c.IdComanda, mc.TipCafea
FROM Clienti cl INNER JOIN Comenzi c on cl.IdClient = c.IdClient INNER JOIN 
ComenziCafele cf on c.IdComanda = cf.IdComanda INNER JOIN MeniuCafele mc on mc.CodProdus = cf.CodProdus
WHERE mc.TipCafea = 'Arabica')A
GROUP BY A.IdComanda, A.IdClient, A.Nume, A.TipCafea

--9. Se se numere comenzile de cafele cu pahare de dimensiune 'mare'
SELECT 
COUNT(A.IdComanda) as TotalComenzi
FROM
(SELECT c.IdComanda
FROM Comenzi c INNER JOIN ComenziCafele cf on c.IdComanda = cf.IdComanda 
INNER JOIN MeniuCafele mc on mc.CodProdus = cf.CodProdus
WHERE mc.Pahar = 'Mare')A

--10. Sa se calculeze pentru fiecare client pretul total al comenzilor sale de dulciuri
--Se va afisa id-ul clientului si pretul total
SELECT A.IdClient,
SUM(A.Pret) as TotalPretDulciuri
FROM
(SELECT cl.IdClient, cl.Nume, c.IdComanda, md.Pret
FROM Clienti cl INNER JOIN Comenzi c on cl.IdClient = c.IdClient INNER JOIN 
ComenziDulciuri cd on c.IdComanda = cd.IdComanda INNER JOIN MeniuDulciuri md on md.CodProdus = cd.CodProdus)A
GROUP BY A.IdClient