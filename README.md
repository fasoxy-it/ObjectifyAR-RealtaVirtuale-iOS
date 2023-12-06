# ObjectifyAR

> Progetto Esame Realtà Virtuale

## Idea

L’idea di base del progetto è quella di realizzare un'applicazione che consente di scansionare e creare modelli tridimensionali di oggetti del mondo reale e di interagire con essi mediante sessioni di realtà aumentata.

## Descrizione

ObjectifyAR è un'applicazione sviluppata per dispositivi iOS che consente agli utenti di effettuare la scansione di oggetti del mondo reale e di convertirli in modelli tridimensionali. L'applicazione offre inoltre funzionalità d’interazione mediante sessioni di realtà aumentata.

## Funzionalità

ObjectifyAR offre un'esperienza completa di scansione, modellazione 3D e realtà aumentata, consentendo di esplorare, documentare e interagire con il mondo reale in modo innovativo e personalizzato.

1. **Scansione e Creazione di Modelli 3D**: L’applicazione consente di scansionare oggetti del mondo reale mediante l’utilizzo della fotocamera e del sensore LIDAR, e di convertirli in modelli 3D. 
2. **Aggiunta di Informazioni**: L’applicazione offre, inoltre, la possibilità di aggiungere informazioni specifiche agli oggetti 3D generati.
3. **Realtà Aumentata Interattiva**: L’applicazione consente, infine, di avviare una sessione di realtà aumentata in cui è possibile interagire con gli oggetti 3D generati. Questa funzionalità consente di posizionare gli oggetti virtuali nell'ambiente fisico e di esplorarli in tempo reale.

## Views

<img width="492" alt="Main View" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/ead1f26a-83f4-4d1e-8357-d6f94ef39813"> | <img width="492" alt="Detail View" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/4fe61601-1cd4-4290-bf9c-b8862107dacf"> | <img width="492" alt="Acquisition View" src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/b34b29bc-3b41-4c4b-be87-1019bcdd48f5">
:-------------------------:|:-------------------------:|:-------------------------:
**Main** View | **Detail** View | **Acquisition** View

### Main View

La Main View è una sessione di AR all'interno della quale è possibile scegliere mediante uno scorrimento laterale l'oggetto che si intende inserire all'interno della scena. È possibile inserire più di un oggetto all'interno della stessa scena. Una volta inserito, l'oggetto potrà essere interagito secondo le seguenti modalità:

* **Tap Gesture**: Attraverso la Tap Gesture sarà possibile accedere alla Detail View dell'oggetto.
* **Long-Press Gesture**: Attraverso la Long-Press Gesture sarà possibile rimuovere dalla scena l'oggetto.
* **Pan Gesture**: Attraverso la Pan Gesture sarà possibile traslare l'oggetto all'interno della scena.
* **Pinch Gesture**: Attraverso la Pinch Gesture sarà possibile scalare l'oggetto all'interno della scena.
* **Rotation Gesture**: Attraverso la Rotation Gesture sarà possibile ruotare l'oggetto all'interno della scena.

### Detail View

La Detail View consente di visualizzare il modello 3D dell'oggetto e l'insieme di informazioni aggiuntive inserite in fase di acquisizione.

### Acquisition View

La Acquisition View consente di aggiungere il modello 3D di un nuovo oggetto all'insieme di modelli 3D degli oggetti già acquisiti.

## Demo

<video src="https://github.com/fasoxy-it/ObjectifyAR-RealtaVirtuale-iOS/assets/58709856/064eb6aa-fb72-47e6-9f5d-3e684c2d461a"/>
:-------------------------:
**Demo**

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
