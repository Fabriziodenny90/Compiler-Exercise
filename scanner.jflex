import java_cup.runtime.*;

%%

%state SECONDPART
%class scanner
%unicode
%cup
%line
%column


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
	
  }
%}


nl = \r|\n|\r\n
ws = [ \t]
separator = "###"("#")*

//token1
vowel = "a"|"e"|"i"|"o"|"u"
evennum = (2|4|6|8|0)
mynumtok1 = \-12|\-1{evennum}|\-8|\-6|\-4|\-2|0|{evennum}|[0-9]{evennum}|[1-2][0-9]{evennum}|13(0|2|4|6)
myword1 = [A-Z_][A-Z_][A-Z_][A-Z_]
myword2 = [A-Z_][A-Z_][A-Z_][A-Z_][A-Z_][A-Z_][A-Z_]
tok1 = {vowel}{vowel}{vowel}{vowel}({vowel}{vowel})*({mynumtok1})?({myword1}|{myword2})

//token2
gg = 0[1-9]|[1-2][0-9]|30|31
ggapr = 0[1-9]|[1-2][0-9]|30
ggfeb = 0[1-9]|1[0-9]|2[0-8]
ggdec = 1[2-9]|2(0|1|2|3|4|6|7|8|9)|30|31
datesep = \- | \_
mon = 0[1-6] 
mydate = 2014\/12\/{ggdec} |  2015\/01\/{gg} | 2015\/02\/{ggfeb} | 2015\/03\/{gg} | 2015\/04\/{ggapr} | 2015\/05\/{gg} | 2015\/06\/(0[1-6])
tok2 = {mydate}{datesep}{mydate}

//exam part
score = 0|1[0-9]|2[0-9]|30
integer =  ([1-9][0-9]*|0)
myfloat = {integer}   ((\.[0-9])   |    (\.[0-9][0-9]))*


%%
<YYINITIAL> {

{tok1}	{return symbol(sym.TOK1);}
{tok2}	{return symbol(sym.TOK2);}
{separator} {yybegin(SECONDPART); return symbol(sym.SEPARATOR);}
";" {return symbol(sym.S);}
":" {return symbol(sym.C);}
"/*" ~ "*/"     {;}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: \""+yytext()+"\" line " + yyline + " col " + yycolumn);}
}

<SECONDPART> {

"PRINT" {return symbol(sym.PRINT);}
"END_IF" {return symbol(sym.END_IF);}
"EXAM" {return symbol(sym.EXAM);}
"ELSE" {return symbol(sym.ELSE);}
"THEN" {return symbol(sym.THEN);}
"IF" {return symbol(sym.IF);}
"SCORES" {return symbol(sym.SCORES);}
\" ~ \" {return symbol(sym.QT, new String(yytext()));}
{score} {return symbol(sym.MARK, new Float(yytext()));}
{myfloat} {return symbol(sym.MYFLOAT, new Float(yytext()));}
":" {return symbol(sym.C);}
"," {return symbol(sym.CM);}
";" {return symbol(sym.S);}
"." {return symbol(sym.PNT);}
")" {return symbol(sym.SC);}
"(" {return symbol(sym.SO);}
"min" {return symbol(sym.MIN);}
"max" {return symbol(sym.MAX);}
"/*" ~ "*/"     {;}
"avg" {return symbol(sym.AVG);}
"OR" {return symbol(sym.OR);}
"AND" {return symbol(sym.AND);}
"<" {return symbol(sym.MINORE);}
">" {return symbol(sym.MAGGIORE);}

{ws}|{nl}       {;}

. {System.out.println("SCANNER ERROR: \""+yytext()+"\" line " + yyline + " col " + yycolumn);}
}

