    SecretSanta
Il Secret Santa di Estatecla 🌴
Questo programma serve quando si ha un gruppo di amici simpatici ma caotici che decidono di organizzare tutti assieme un Secret Santa per le festività di Natale ma si accorgono all'ultimo secondo che alcune persone non sono state inserite nel sorteggio, mentre altre hanno già acquistato il regalo per il nome già sorteggiato.
Lo scopo è quindi quello di risorteggiare tutti i nomi che non hanno ancora aquistato un regalo permettendo a chi l'ha già acquistato di non dover partecipare ad un secondo sorteggio e garantendo l'anonimato (e dunque il divertimento e la sorpresa) per tutti!

Nella cartella "files" bisogna inserire i file per i sorteggi già avvenuti.
Se, per esempio, Michele ha già comprato il regalo per Francesca, bisogna creare un file chiamato:
> Michele.txt

All'interno di questo file va scritto il nome di Francesca in usa sola linea:
> Francesca

Qusto è il risultato di un cat su Michele.txt:
> rossimic: echo "Francesca" > files/Michele.txt
> rossimic: cat files/Michele.txt
> Francesca

Dopo di che bisogna lanciare lo script bash ./SecretSanta.sh dalla cartella di lavoro:
> rossimic: ./SecretSanta.sh
> Secret Santa done!

A questo punto saranno disponibili i file con i nomi di chi deve comprare il regalo, da inviare a ciascun partecipante, ad esempio:
> rossimic: ls
> Alessio.txt  Alice.txt    Benedetta.txt  Dario.txt  files          Gambone.txt   Luca.txt    Michele.txt  Ruben.txt  SecretSanta.sh
> Alfredo.txt  Aufiero.txt  Christian.txt  Enzo.txt   Francesca.txt  Giuseppe.txt  Matteo.txt  Ramona.txt   Sara.txt   Stefu.txt

NOTA: per ora la lista dei partecipanti è scritta a mano all'interno di SecretSanta.sh.
NOTA: la lettura da file è non è case sensitive ed ignora tutti gli spazi spuri; e tutte le righe oltre la prima sono ignorate.
NOTA: se un nome non viene correttamente riconosciuto, lo script darà un errore e non genererà alcun output.
Vediamo cosa succede se, ad esempio, in Michele.txt al posto di "Benedetta" (il nome del partecipante indicato sulla lista) scriviamo "Benny" (il vezzeggiativo con cui gli amici sono soliti chiamarla)
> rossimic: echo "Benny" > files/Michele.txt
> rossimic: ./SecretSanta.sh
> Error: name in file Michele does not exist!
In questo modo possiamo segnalare a Michele di correggere l'errore senza venire a conoscenza di chi sia la persona a cui egli debba fare il regalo.
