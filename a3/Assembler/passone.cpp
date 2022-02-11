#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc,char* argv[]) {
  char* filename=argv[1];

  // Define the necessary data structures for pass one of the assembler
  char opcode[10], operand[10], label[10], code[10][10];
  char mnemonic[10][10] = {"START", "LDA", "STA", "LDCH", "STCH", "END"};
  int locctr, start, i = 0, j = 0;
  FILE *fp1, *fp2, *fp3;

  // Opening the file for reading the input in order to generate the object code
  fp1 = fopen(filename, "r");
  fp2 = fopen("SYMTAB.DAT", "w");
  fp3 = fopen("OUT.DAT", "w");
  if (fp1 && fp2 && fp3)
    printf("File pointers OK\n");
  else {
    printf("Error opening files\n");
    exit(1);
  }
  printf("\nScanning from input file has started...\n");

  fscanf(fp1, "%s%s%s", label, opcode, operand);
  // Check if the label is start or not
  if (strcmp(opcode, "START") == 0) {
    start = atoi(operand);
    locctr = start;
    fprintf(fp3, "%s\t%s\t%s\n", label, opcode, operand);
    fscanf(fp1, "%s%s%s", label, opcode, operand);
  } else
    locctr = 0;
  while (strcmp(opcode, "END") != 0) {
    fprintf(fp3, "%d", locctr);
    if (strcmp(label, "**") != 0)
      fprintf(fp2, "%s\t%d\n", label, locctr);
    strcpy(code[i], mnemonic[j]);
    while (strcmp(mnemonic[j], "END") != 0) {
      if (strcmp(opcode, mnemonic[j]) == 0) {
        locctr += 3;
        break;
      }
      strcpy(code[i], mnemonic[j]);
      j++;
    }
    if (strcmp(opcode, "WORD") == 0)
      locctr += 3;
    else if (strcmp(opcode, "RESW") == 0)
      locctr += (3 * (atoi(operand)));
    else if (strcmp(opcode, "RESB") == 0)
      locctr += (atoi(operand));
    else if (strcmp(opcode, "BYTE") == 0)
      ++locctr;
   /* else
    {
      printf("Invalid opcode present: %s\n",opcode);
      exit(1);
    }*/
    fprintf(fp3, "\t%s\t%s\t%s\n", label, opcode, operand);
    fscanf(fp1, "%s%s%s", label, opcode, operand);
  }
  fprintf(fp3, "%d\t%s\t%s\t%s\n", locctr, label, opcode, operand);
  printf("\n !! corresponding symbol table and out.dat file is generated !!");
  return 0;
}
