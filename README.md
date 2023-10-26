# ObjectifyAR

> Realtà Virtuale Exam Project

## Idea

L’idea di base del progetto è quella di realizzare un'applicazione che consente di scansionare e creare modelli tridimensionali di oggetti del mondo reale e di interagire con essi mediante sessioni di realtà aumentata.

## Descrizione

ObjectifyAR è un'applicazione sviluppata per dispositivi iOS che consente agli utenti di effettuare la scansione di oggetti del mondo reale e di convertirli in modelli tridimensionali. L'applicazione offre inoltre funzionalità d’interazione mediante sessioni di realtà aumentata.

## Funzionalità

ObjectifyAR offre un'esperienza completa di scansione, modellazione 3D e realtà aumentata, consentendo di esplorare, documentare e interagire con il mondo reale in modo innovativo e personalizzato.

1. **Scansione e Creazione di Modelli 3D**: L’applicazione consente di scansionare oggetti del mondo reale mediante l’utilizzo della fotocamera e del sensore LIDAR, e di convertirli in modelli 3D. 
2. **Aggiunta di Informazioni**: L’applicazione offre, inoltre, la possibilità di aggiungere informazioni specifiche agli oggetti 3D generati.
3. **Realtà Aumentata Interattiva**: L’applicazione consente, infine, di avviare una sessione di realtà aumentata in cui è possibile interagire con gli oggetti 3D generati. Questa funzionalità consente di posizionare gli oggetti virtuali nell'ambiente fisico e di esplorarli in tempo reale.

## Activities

 <img width="100%" alt="Main Activity" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/a3ebd69c-d441-48d6-b1f9-39b32897b38e"> | <img width="100%" alt="Details Activity" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/4f7afd6e-4311-4267-9b79-62e1bd2ef961"> | <img width="100%" alt="Adding Activity" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/8ea433d9-bb49-455d-9c2a-6219e6c4f491">
:-------------------------:|:-------------------------:|:-------------------------:
**Main** Activity | **Details** Activity | **Acquisition** Activity

### Main Activity

La Main Activity è una sessione di AR all'interno della quale è possibile scegliere mediante uno scorrimento laterale l'oggetto che si intende inserire all'interno della scena. È possibile inserire più di un oggetto all'interno della stessa scena. Una volta inserito, l'oggetto potrà essere interagito secondo le seguenti modalità:

* **Single Touch**: Attraverso un Single Touch sarà possibile accedere alla Details Activity dell'oggetto.
* **Force Touch**: Attraverso un Force Touch sarà, invece, possibile rimuovere dalla scena l'oggetto.

### Details Activity

La Details Activity consente di visualizzare il modello 3D dell'oggetto e l'insieme di informazioni aggiuntive inserite in fase di acquisizione.

### Acquisition Activity

_Work In Progress_...

## Target

L'applicazione ha il potenziale per servire diverse categorie di utenti, tra cui:

* **Artisti**: Gli artisti possono utilizzare ObjectifyAR per creare modelli 3D delle loro opere d'arte e renderle accessibili al pubblico mediante la realtà aumentata, offrendo nuove modalità di fruizione delle opere.
* **Appassionati di Realtà Aumentata**: Coloro che sono interessati alla realtà aumentata possono utilizzare l'applicazione per esplorare e interagire con oggetti virtuali nel loro ambiente fisico.
* **Ricercatori e Educatori**: ObjectifyAR può essere utilizzato nell'ambito dell'istruzione e della ricerca, offrendo nuove modalità di visualizzazione di oggetti e concetti 3D.

## Technologies

* XCode
* Adobe XD

## Tag

#iOS, #AR, #3D
