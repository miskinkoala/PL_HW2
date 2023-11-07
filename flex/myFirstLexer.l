%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char    word[50];
char *keywords[] = {"and", "or", "not", "equal", "less", "nil", "list", "append",
                        "concat", "set", "def", "for", "if", "exit", "load", "display", "true", "false"};
char operator[] = {'+', '-', '/', '*', '(', ')', ','};
char *TOKEN_keywords[] = {"KW_AND", "KW_OR", "KW_ NOT", "KW_EQUAL", "KW_LESS", "KW_NIL", "KW_LIST",
                            "KW_APPEND", "KW_CONCAT", "KW_SET", "KW_DEF", "KW_FOR", "KW_IF",
                                "KW_EXIT", "KW_LOAD", "KW_DISPLAY", "KW_TRUE", "KW_FALSE"};
char *TOKEN_operator[] = {"OP_PLUS", "OP_MINUS", "OP_DIV", "OP_MULT", "OP_OP", "OP_CP", "OP_COMMA"};
int KEYWORD_NUM = 18;
int OPERATOR_NUM = 7;
int Flag_key = 0;
//declaration of variables and constants

int isNumeric(const char *str) {
    while (*str) {
        if (!isdigit(*str)) {
            return 0; // return 0 if a non-digit character is found
        }
        str++;
    }
    return 1; // return 1 if all characters are digits
}


%}

%%
";;".* {printf("comment: %s COMMENT\n", word);}
[0-9]+[b][0-9]+ { printf("division: %s VALUEF \n", word); }
[a-z]    { strcat(word, yytext); }
[A-Z]    { strcat(word, yytext); }
[0-9]     { strcat(word, yytext); }//concanate when it sees alphanumritical ccharss
[^a-zA-Z1-9] { 
                if(strlen(word) > 0)
                {
                    for (int i = 0; i < KEYWORD_NUM; i++)
                        if (strcmp(keywords[i], word) == 0)
                        {
                            printf("keyword: %s %s\n", word, TOKEN_keywords[i]);
                            Flag_key = 1;
                        }
                    if(isNumeric(word))
                        printf("integer: %s VALUEINT \n", word);
                    else if(!Flag_key){
                        if(((word[0] >= 65) && (word[0] <= 90)) || ((word[0] >= 97) && (word[0] <= 122)) || word[0] == '_')
                            printf("İdientifier: %s IDENTIFIER \n", word);
                        else{
                            printf("SYNTAX_ERROR: %s cannot be tokenized \n", word);
                            exit(1);
                            }   
                    }

                    Flag_key = 0;
                    strcpy(word, ""); 

                }   
                strcpy(word, "");
                for (int i = 0; i < OPERATOR_NUM; i++)
                    if (*yytext == operator[i]) printf("operator: %s %s\n", yytext, TOKEN_operator[i]);
            ;}


%%

int yywrap(){}
int main(){

    yylex();
    return 0;
}


/*
GETS WRONG WHEN YOU ENTER SPECİAL CHARATCER:

$aa


FILE AS INPUT HAVENT IMPLEMENTED:
input.txt

COMMENT IMPLEMENTATION SHOULD BE MODIFY:
soner TERMINATES IMMEDTIATLY
a;;
deneme;;
*/

