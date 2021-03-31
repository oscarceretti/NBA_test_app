# NBA_test_app
NBA app

## Architettura
Il pattern scelto è MVVM 

## CompositionRoot
 
il compito del compositionRoot è quello di gestire l'iniezione delle dipendenze esse sono definite, costruite e iniettate il prima possibile nel loro container questo process può rallentare di alcuni secondi l'init della scena, ma a fronte di questo piccolo svantaggio si ottiene una struttura dove la catena di dipendeze è precostruita accorciando i tempi di risposta e il consumo di memoria un altro importante vantaggio di questa scelta implementativa è il fatto che esiste un unico punto per la costruzione di tutte le scene questo tipo di pattern aiuta a mantenere anche i progetti più grossi facilitando la comprensione architetturale dell'intero progetto
    
## Interactor
 
il compito di questo layer è quello di ricevere i dati grezzi dal manager e attuare la business logic necessaria per estrapolare i dati e formattarli nelle entità necessarie per effettuare la logica di presentazione, il vantaggio di separare in maniera così netta la business logic da quella di presentazione è che eventuali modifiche alla logica di business non si riperquoteranno sul viewModel fintanto che l'output dei dati fornit dall' interactor non varierà. su questo layer è stata applicata la dependecy inversion 


