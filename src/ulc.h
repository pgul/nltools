#ifndef ULC_H
#define ULC_H

#define REV "0.1"

enum { F_NODELIST, F_POINTS24 };

int ul_compile (FILE *fin, FILE *fout, int type, int defzone);
int ul_sort    (FILE *);

#endif