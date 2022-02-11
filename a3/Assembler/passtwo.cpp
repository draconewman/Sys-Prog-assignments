#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>

using namespace std;
int main(int argc,char* argv[]) {
  char* filename_symbol=argv[1];
  char a[10], ad[10], label[10], opcode[10], operand[10], symbol[10];
  int st, diff, i, address, add, len, actual_len, finaddr, prevaddr, j = 0;
  char mnemonic[15][15] = {"LDA", "STA", "LDCH", "STCH"};
  char code[15][15] = {"33", "44", "53", "57"};
  FILE *fp1, *fp2, *fp3, *fp4;

  fp1 = fopen("ASSMLIST.DAT", "w");
  fp2 = fopen(filename_symbol, "r");
  fp3 = fopen("OUT.DAT", "r");
  fp4 = fopen("OBJCODE.DAT", "w");
  if (fp1 && fp2 && fp3 && fp4)
    cout << "File pointers OK" << endl;
  else {
    cout << "Error opening files" << endl;
    exit(1);
  }
  fscanf(fp3, "%s%s%s", label, opcode, operand);

  while (strcmp(opcode, "END") != 0) {
    prevaddr = address;
    fscanf(fp3, "%d%s%s%s", &address, label, opcode, operand);
  }
  finaddr = address;
  // fclose(fp3);

  // fp3 = fopen("OUT.DAT", "r");
  fseek(fp3, 0, SEEK_SET);

  fscanf(fp3, "%s%s%s", label, opcode, operand);
  printf("\n Generating the files assmlist.dat and objectcode.dat has started\n\n");
  if (strcmp(opcode, "START") == 0) {
    fprintf(fp1, "\t%s\t%s\t%s\n", label, opcode, operand);
    fprintf(fp4, "H^%s^00%s^00%d\n", label, operand, finaddr);
    fscanf(fp3, "%d%s%s%s", &address, label, opcode, operand);
    st = address;
    diff = prevaddr - st;
    fprintf(fp4, "T^00%d^%d", address, diff);
  }
  while (strcmp(opcode, "END") != 0) 
  {
    if (strcmp(opcode, "BYTE") == 0) 
    {
      fprintf(fp1, "%d\t%s\t%s\t%s\t", address, label, opcode, operand);
      len = strlen(operand);
      actual_len = len - 3;
      fprintf(fp4, "^");
      for (i = 2; i < (actual_len + 2); i++) 
      {
        // itoa(operand[i], ad, 16);
        sprintf(ad, "%0x", operand[i]);
        fprintf(fp1, "%s", ad);
        fprintf(fp4, "%s", ad);
      }
      fprintf(fp1, "\n");
    } else if (strcmp(opcode, "WORD") == 0) {
      len = strlen(operand);
      // itoa(atoi(operand), a, 10);
      sprintf(a, "%d", atoi(operand));
      fprintf(fp1, "%d\t%s\t%s\t%s\t00000%s\n", address, label, opcode, operand,
              a);
      fprintf(fp4, "^00000%s", a);
    } else if ((strcmp(opcode, "RESB") == 0) || (strcmp(opcode, "RESW") == 0))
      fprintf(fp1, "%d\t%s\t%s\t%s\n", address, label, opcode, operand);
    else {
      while (strcmp(opcode, mnemonic[j]) != 0){
        j++;
        if(j>3)
        {
          cout<< "\n.....Invalid opcode found...."<<opcode<<endl;
          exit(1);
        }
        
        }
      if (strcmp(operand, "COPY") == 0)
        fprintf(fp1, "%d\t%s\t%s\t%s\t%s0000\n", address, label, opcode,
                operand, code[j]);
      else {
        rewind(fp2);
        fscanf(fp2, "%s%d", symbol, &add);
        //cout<<"xyzzzzzzzzzzzz";
        while (strcmp(operand, symbol) != 0)
          fscanf(fp2, "%s%d", symbol, &add);
        // int c=1000,i=0;
        
        //cout<<"c:  "<<c<<endl;
       
        /*if(strcmp(operand,symbol) !=0) 
        {
          cout<<"error !!! Undefined reference ...."<<endl;
          exit(1);
        } */
        fprintf(fp1, "%d\t%s\t%s\t%s\t%s%d\n", address, label, opcode, operand,
                code[j], add);
        fprintf(fp4, "^%s%d", code[j], add);
      }
    }
    fscanf(fp3, "%d%s%s%s", &address, label, opcode, operand);
    //cout<<"end.............\n";
  }
  fprintf(fp1, "%d\t%s\t%s\t%s\n", address, label, opcode, operand);
  printf("\n ASSMLIST file has generated ...");
  fprintf(fp4, "\nE^00%d", st);
  printf("\n Object code has generated ...");
  printf("\n Finally Intermediate file is converted into object code\n\n");
  return 0;
}
