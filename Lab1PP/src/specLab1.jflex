// import sekcija

%%

// sekcija opcija i deklaracija
%class MPLexer
%function next_token
%line
%column
%debug
%type Yytoken

//%eofval{
//return new Yytoken( sym.EOF, null, yyline, yycolumn);
//%eofval}

%{
//dodatni clanovi generisane klase
KWTable kwTable = new KWTable();
Yytoken getKW()
{
	return new Yytoken( kwTable.find( yytext() ),
	yytext(), yyline, yycolumn );
}
%}

//stanja
%xstate KOMENTAR
//makroi
slovo = [a-zA-Z]
hexa = [a-fA-F]
octa = [0-7]
cifra = [0-9]

%%

// lexical rules
\/\*\* { yybegin( KOMENTAR ); }
<KOMENTAR>~"*/" { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }
\( { return new Yytoken( sym.LEFTPAR, yytext(), yyline, yycolumn ); }
\) { return new Yytoken( sym.RIGHTPAR, yytext(), yyline, yycolumn ); }
\{ { return new Yytoken( sym.LEFTVITIC, yytext(), yyline, yycolumn ); }
\} { return new Yytoken( sym.RIGHTVITIC, yytext(), yyline, yycolumn ); }

//operatori
\+ { return new Yytoken( sym.PLUS,yytext(), yyline, yycolumn ); }
\- { return new Yytoken( sym.MINUS,yytext(), yyline, yycolumn ); }
\* { return new Yytoken( sym.MUL,yytext(), yyline, yycolumn ); }
\/ { return new Yytoken( sym.DIV,yytext(), yyline, yycolumn ); }


//separatori
; { return new Yytoken( sym.SEMICOLON, yytext(), yyline, yycolumn ); }
, { return new Yytoken( sym.COMMA, yytext(), yyline, yycolumn ); }
= { return new Yytoken( sym.ASSIGN, yytext(), yyline, yycolumn ); }

//kljucne reci
{slovo}+ { return getKW(); }

//identifikatori
{slovo}({slovo}|{cifra})* { return new Yytoken(sym.ID, yytext(),yyline, yycolumn ); }


//konstante
{cifra}+ { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
'[^]' { return new Yytoken( sym.CONST,yytext(), yyline, yycolumn ); }
0x({cifra}| {hexa})+ { return new Yytoken( sym.CONST,yytext(), yyline, yycolumn ); } //CONSTINT
0{octa}+ { return new Yytoken( sym.CONST,yytext(), yyline, yycolumn ); } //CONSTINT
{cifra}"."{cifra}+(E(\+|\-)?{cifra}+)? { return new Yytoken( sym.CONST,yytext(), yyline, yycolumn ); } //CONSTREAL

//obrada gresaka
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }

