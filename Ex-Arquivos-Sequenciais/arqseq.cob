      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ARQSEQ.
      *
       ENVIRONMENT             DIVISION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT ARQIN ASSIGN TO
               "C:\Users\WIN 11\OneDrive\Desktop\Cob-Arq\ARQIN.txt"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-STATUS-IN.
      *
       DATA                    DIVISION.
      *
       FILE                    SECTION.
       FD  ARQIN.
       01  ARQ-REC             PIC X(21).
      *
       WORKING-STORAGE         SECTION.
      *  ORGANIZACAO DO ARQUIVO 
       01  WS-ARQIN.
           05 WS-ARQ-COD          PIC 9(04) VALUE ZEROS.
           05 WS-ARQ-NAME         PIC X(15) VALUE SPACES.
           05 WS-ARQ-AGE          PIC 99    VALUE ZEROS.
           
      * CONTROLE DOS ARQUIVOS     
       77  EOF-ARQ                PIC A     VALUE 'N'.
       77  WS-STATUS-IN           PIC XX. 
       
      * CONTROLE DE ERROS 
       77  WS-ABEND-CODE          PIC XX    VALUE SPACES.
       77  WS-ABEND-MESSAGE       PIC X(30) VALUE SPACES.
      *
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM 100-OPEN-FILE.
           PERFORM UNTIL EOF-ARQ EQUAL 'Y'
               PERFORM 200-PROCESS-FILE
           END-PERFORM.
           PERFORM 999-CLOSE-FILE.
           STOP RUN.
               
       100-OPEN-FILE.    
           OPEN INPUT ARQIN.
           IF WS-STATUS-IN NOT EQUAL '00'
               MOVE WS-STATUS-IN           TO WS-ABEND-CODE
               MOVE "FILE ARQIN IO/ERROR"  TO WS-ABEND-MESSAGE
               PERFORM 900-ABEND THRU 999-CLOSE-FILE
               STOP RUN
           END-IF.
               
       200-PROCESS-FILE.
           READ ARQIN INTO WS-ARQIN
               AT END
                   MOVE 'Y' TO EOF-ARQ
               NOT AT END
                   DISPLAY 'ARQ-COD:  ' WS-ARQ-COD
                   DISPLAY 'ARQ-NAME: ' WS-ARQ-NAME
                   DISPLAY 'ARQ-AGE:  ' WS-ARQ-AGE
                   DISPLAY '----------------------'
           END-READ.

       900-ABEND                  SECTION.
           DISPLAY "***************************************************"
           DISPLAY "****************  ABEND ROUTINE  ******************"
           DISPLAY "* ABEND CODE: " WS-ABEND-CODE.
           
       999-CLOSE-FILE.
            CLOSE ARQIN.
            
       END PROGRAM ARQSEQ.
