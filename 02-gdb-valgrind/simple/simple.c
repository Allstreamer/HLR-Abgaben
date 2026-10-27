/*
** simple error demonstration to demonstrate power of valgrind
** Julian M. Kunkel - 17.04.2008
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int *mistakes1(void) {
  /* FEHLER buf war ein lokales Array auf dem Stack.
     return buf gab dessen Adresse zurueck; nach dem return ist der Stack-Frame
     ungueltig (dangling pointer). Der Compiler ersetzte die Rueckgabe sogar durch
     NULL, daher p[0] = 0x4 in main.
     FIX: Speicher mit malloc auf dem Heap anlegen und Werte hineinkopieren.
     Freigabe in main mit free(p[0] - 1), da main auf buf[1] zeigt. */
  int *buf = malloc(sizeof(int) * 6);
  int init[] = {1, 1, 2, 3, 4, 5};
  memcpy(buf, init, sizeof(init));
  return buf;
}

int *mistakes2(void) {
  /* FEHLER malloc(sizeof(char) * 4) reserviert nur 4 Byte,
     also Platz fuer genau 1 int.
     FEHLER buf[2] liegt ausserhalb des reservierten Speichers
     (Heap-Overflow). Ausserdem liest main ueber &mistakes2()[1] den Index 1.
     FIX: sizeof(int) verwenden und den Wert an Index 1 schreiben. */
  int *buf = malloc(sizeof(int) * 4);
  buf[1] = 2;
  return buf;
}

int *mistakes3(void) {
  /* In dieser Funktion darf kein Speicher direkt d.h. explizit allokiert werden. */
  /* FEHLER (int *)&mistakes2 ist die Adresse der FUNKTION
     mistakes2 (Code-Segment, schreibgeschuetzt) und nicht die der Variable
     mistakes2_. Das Schreiben in Original fuehrt zum SIGSEGV.
     &mistakes2_ waere ebenfalls falsch (lokale Variable, dangling pointer).
     FIX: mistakes2() aufrufen, das gueltigen Heap-Speicher liefert
     (kein direktes malloc hier). Freigabe in main mit free(p[2]). */
  int *buf = mistakes2();
  buf[0] = 3;
  return buf;
}

int *mistakes4(void) {
  /* FEHLER malloc(sizeof(char) * 4) reserviert nur 4 Byte.
     FEHLER buf[4] liegt ausserhalb (Heap-Overflow); main nutzt
     mistakes4() direkt, liest also Index 0.
     FEHLER free(buf) vor return buf; der zurueckgegebene
     Zeiger ist ungueltig (use-after-free beim printf in main).
     FIX: Platz fuer 1 int, Wert an Index 0, free entfernt und nach main verlegt. */
  int *buf = malloc(sizeof(int));
  buf[0] = 4;
  return buf;
}

int *mistakes5(void) {
  /* FEHLER malloc(4 * 5) setzt sizeof(int) == 4 voraus
     (nicht optimal); ersetzt durch sizeof(int) * 5.
     FEHLER buf[44] liegt weit ausserhalb der 5 ints
     (Heap-Overflow). main nutzt mistakes5()+4, liest also Index 4.
     FIX: Wert an Index 4 schreiben. Freigabe in main mit free(p[4] - 4). */
  int *buf = malloc(sizeof(int) * 5);
  buf[4] = 5;
  return buf;
}

int main(void) {
  /* Diese Zeile darf NICHT verändert werden! */
  int *p[5] = {&mistakes1()[1], &mistakes2()[1], mistakes3(), mistakes4(), mistakes5()+4};

  /* Die printf-Aufrufe dürfen NICHT verändert werden*/
  printf("1: %d\n", *p[0]);
  printf("2: %d\n", *p[1]);
  printf("3: %d\n", *p[2]);
  printf("4: %d\n", *p[3]);
  printf("5: %d\n", *p[4]);

  /* TODO */
  /* Fügen sie hier die korrekten aufrufe von free() ein */
  /* FEHLER free(p[1]) gab nicht den Anfangszeiger von malloc
     frei (Offset +1 int), das ist ein ungueltiges free. Die uebrigen Bloecke wurden
     gar nicht freigegeben (Speicherleck).
     FIX: jeden Block genau einmal mit dem Originalzeiger von malloc freigeben;
     p[0], p[1] und p[4] zeigen sind versetzt in ihren Block, daher - 1 bzw. - 4. */
  free(p[0] - 1);
  free(p[1] - 1);
  free(p[2]);
  free(p[3]);
  free(p[4] - 4);

  return 0;
}
