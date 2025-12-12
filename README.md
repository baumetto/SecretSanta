# SecretSanta
Il Secret Santa di Estatecla 🌴

Questo programma serve quando si ha un gruppo di amici simpatici ma caotici che decidono di organizzare tutti assieme un Secret Santa per le festività di Natale ma si accorgono all'ultimo secondo che alcune persone non sono state inserite nel sorteggio, mentre altre hanno già acquistato il regalo per il nome già sorteggiato.\
Lo scopo è quindi quello di risorteggiare tutti i nomi che non hanno ancora aquistato un regalo permettendo a chi l'ha già acquistato di non dover partecipare ad un secondo sorteggio e garantendo l'anonimato (e dunque il divertimento e la sorpresa) per tutti!

Anche senza le complicazioni appena presentate, il problema del sorteggio del Secret Santa è di per sè un problema matematico rilevante ed interessante.\
Per maggiori informazioni sul tema, [questo video](https://www.youtube.com/watch?v=5kC5k5QBqcc) di Numberphile aiuterà a chiarire ogni dubbio.

Nella cartella "santas" bisogna inserire il file contenente la lista dei partecipanti, ad esempio:
```
Estatecla.txt
```
La lista è una semplice sequenza di nomi:
```
01 Alessio
02 Alfredo
03 Alice
04 Aufiero
05 Benedetta
06 Christian
07 Dario
08 Enzo
09 Francesca
10 Gambone
11 Giuseppe
12 Luca
13 Matteo
14 Michele
15 Ramona
16 Ruben
17 Sara
18 Stefu
19
```
Nella cartella "files" bisogna inserire i file per i sorteggi già avvenuti.\
Se, per esempio, Michele ha già comprato il regalo per Francesca, bisogna creare un file chiamato:
```
Michele.txt
```

All'interno di questo file va scritto il nome di Francesca in usa sola linea:
```
1 Francesca
2
```

Qusto è il risultato di un cat su Michele.txt:
```
rossimic: echo "Francesca" > files/Michele.txt
rossimic: cat files/Michele.txt
Francesca
```

Dopo di che bisogna lanciare lo script bash ./SecretSanta.sh dalla cartella di lavoro:
```
rossimic: ./SecretSanta.sh
Secret Santa done!
```

A questo punto saranno disponibili i file con i nomi di chi deve comprare il regalo, da inviare a ciascun partecipante, ad esempio:
```
rossimic: ls
Alessio.txt  Alice.txt    Benedetta.txt  Dario.txt  files          Gambone.txt   Luca.txt    Michele.txt  Ruben.txt  SecretSanta.sh
Alfredo.txt  Aufiero.txt  Christian.txt  Enzo.txt   Francesca.txt  Giuseppe.txt  Matteo.txt  Ramona.txt   Sara.txt   Stefu.txt
```

NOTA: la lettura da file è non è case sensitive ed ignora tutti gli spazi spuri; e tutte le righe oltre la prima sono ignorate.\
NOTA: se un nome non viene correttamente riconosciuto, lo script darà un errore e non genererà alcun output.\
Vediamo cosa succede se, ad esempio, in Michele.txt al posto di "Benedetta" (il nome del partecipante indicato sulla lista) scriviamo "Benny" (il vezzeggiativo con cui gli amici sono soliti chiamarla):
```
rossimic: echo "Benny" > files/Michele.txt
rossimic: ./SecretSanta.sh
Error: name in file Michele does not exist!
```
In questo modo possiamo segnalare a Michele di correggere l'errore senza venire a conoscenza di chi sia la persona a cui egli debba fare il regalo.

E' anche possibile inviare i file via mail.
In tal caso il file dei nomi va aggiornato in questo modo per avere un database degli indirizzi:
```
01 Alessio:alessio@gmail.com
02 Alfredo:alfredo@gmail.com
03 Alice:alice@gmail.com
04 Aufiero:aufiero@gmail.com
05 Benedetta:benedetta@gmail.com
06 Christian:christian@gmail.com
07 Dario:dario@gmail.com
08 Enzo:enzo@gmail.com
09 Francesca:francesca@gmail.com
10 Gambone:gambone@gmail.com
11 Giuseppe:giuseppe@gmail.com
12 Luca:luca@gmail.com
13 Matteo:matteo@gmail.com
14 Michele:michele@gmail.com
15 Ramona:ramona@gmail.com
16 Ruben:ruben@gmail.com
17 Sara:sara@gmail.com
18 Stefu:stefu@gmail.com
19
```
Ovvero e' importante che sia utilizzato il carattere ":" come divisore tra nomi ed email.
Il programma chiedera' a video se si vuole inviare le mail:
```
Would you like to send the Santas by email? (Y/N): N
```
Le uniche risposte accettate sono "Y" o "N", qualsiasi altra stringa risultera' in un errore.