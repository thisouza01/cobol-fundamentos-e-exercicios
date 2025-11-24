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
           ORGANIZATION IS LINE SEQUENTIAL.
      *
       DATA                    DIVISION.
      *
       FILE                    SECTION.
       FD  ARQIN.
       01  ARQ-REC             PIC X(21).
      *
       WORKING-STORAGE         SECTION.
       01  WS-ARQIN.
           05 WS-ARQ-COD          PIC 9(04) VALUE ZEROS.
           05 WS-ARQ-NAME         PIC X(15) VALUE SPACES.
           05 WS-ARQ-AGE          PIC 99    VALUE ZEROS.

       77  EOF-ARQ                PIC A     VALUE 'N'.
       77  WS-STATUS-IN           PIC XX.
      *
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM 100-OPEN-FILE.
           PERFORM UNTIL EOF-ARQ EQUAL 'Y'
               PERFORM 200-PROCESS-FILE
           END-PERFORM.
           PERFORM 900-CLOSE-FILE.
           STOP RUN.
               
       100-OPEN-FILE.    
           OPEN INPUT ARQIN.
           IF WS-STATUS-IN EQUAL '00'
               CONTINUE
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

       900-CLOSE-FILE.
            CLOSE ARQIN.
            
       END PROGRAM ARQSEQ.
