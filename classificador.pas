{
============= Trabalho Prático 02 =============

Nome do Aplicativo: classificador

Nome: Bruno Tomé;       Matrícula: 0011254;
Nome: Ronan Nunes;      Matrícula: 0011919;
Data: 13/03/2014

========== Instruções de compilação ===========

Com o arquivo .pas e os arquivos de relacao
no Desktop abra o terminal e digite:

cd Desktop/

fpc classificador.pas -oclassificador.bin

./classificador.bin <NOME ARQUIVO DE ENTRADA.txt>

Limitação: O arquivo de entrada poderá ter cardinalidade
de até 99.

OBS: Não foi necessário o uso do ParamCount, pois usando
apenas ParamStr(1) foi possível realizar a leitura do arquivo
passado na linha de comando. (Onde o número entre parênteses
indica o parâmetro, se for 0 por exemplo, é o nome do programa,
e o 1 que está logo a frente é o nome do arquivo, os parâmetros
são separados por zero). Logo não se justifica o uso do ParamCount
em nosso programa.

========= Ambiente de desenvolvimento =========

Bruno Tomé: O.S: OS X 10.9.2
            IDE e compilador: fpc Lazarus

Ronan Nunes: O.S: Windows 8.1
             IDE e compilador: fpc Lazarus

Ambos também usaram Pages for iCloud para edição
compartilhada do código online.

============= Objetivo do Arquivo =============

Colocar os conhecimentos em prática adquiridos
em sala de aula, classificando relações do tipo AxA em:

* 1-Para-Um
* 1-Para-N
* N-Para-1
* N-Para-N

E também classificar quanto as suas propriedades:

*Reflexiva
*Simétrica

===== Funções auxiliares e procedimentos =====

A explicação de cada função e procedimento está
detalhada no momento em que são chamadas,para
facilitar o compreendimento das mesmas.

}
program classificador;
uses crt;
type matriz = array [1..99,1..99] of integer;

// Esta função lê o arquivo e recebe a cardinalidade da relação
function recebeCardinalidade():integer;
var  posicaoum,tam, error, cardinalidade : integer;
     f1 : text ;
     s,aux : string ;
begin
     assign (f1,(ParamStr(1)));
     reset (f1);
     cardinalidade:= 0;
     while (not eof(f1)) do
           begin //início while
                readln (f1,s);
                if cardinalidade = 0 then
                begin
                     if (s[1]='n') then
                     {Se a condição for verdadeira, ele salva a posição do 1º espaço
                     na variável posicaoum e salva também o tamanho da string, em seguida
                     ele salva em uma string aux o número da cardinalidade que está na
                     posição +1.

                     Depois irá converter o valor salvo na aux para um número inteiro,
                     retornando a cardinalidade.}
                     begin
                          posicaoum:=pos(' ', s);
                          tam:=length(s);
                          aux:=copy(s,posicaoum+1,tam);
                          val(aux,cardinalidade,error);
                          if (error > 0) then
                          begin
                               writeln ('erro de converção');
                          end;
                     end;
                end;
                if cardinalidade <> 0 then
                begin
                     break;
                end;
           end; // Fim while
close(f1);
recebeCardinalidade:= cardinalidade;
end;
// Fim da função recebeCardinalidade

function VerificaArquivo():boolean;
var verifica:boolean;
    tam,pos1,pos2,error,linha,coluna,cardinalidade:integer;
    linhastring,colunastring,s:string;
    f1:text;
begin
     assign (f1,(ParamStr(1)));
     reset (f1);
     read(f1);
     verifica:=true;
     while (not eof(f1) and verifica = true) do
     begin
          readln(f1,s);
          tam:=length(s);
          if (s[1] = 'n') then
          begin
               if (tam = 3) or (tam = 4) then
               begin
                    verifica:=true;
                    cardinalidade:= recebecardinalidade();
               end
               else
               begin
                    verifica:=false;
               end;
          end
          else
          if (s[1] = 'r') then
          begin
               if (tam = 5) or (tam = 6) or (tam = 7) then
                  begin
                       pos1:=pos(' ', s);
                       delete(s,1,(pos1));
                       pos2:=pos(' ', s);
                       linhastring:=copy(s,1,(pos2)-1);
                       val(linhastring,linha,error);
                       if (error > 0) then
                       begin
                            writeln ('erro de converção');
                       end;
                       delete(s,1,pos2);
                       colunastring:=s;
                       val(colunastring,coluna,error);
                       if (error > 0) then
                       begin
                            writeln ('erro de converção');
                       end;
                       if ((linha > cardinalidade) or (coluna > cardinalidade)) then
                       begin
                            verifica:=false;
                       end
                       else
                       begin
                            verifica:=true;
                       end;
                  end;
          end
          else if (s[1] = 'f') then
          begin
               if (tam = 1)then
               begin
                    verifica:=true;
               end
               else
               begin
                    verifica:=false;
               end;
          end
          else if (s[1] <> 'n') and (s[1] <> 'r') and (s[1] <> 'f') then
          begin
               verifica:=false;
          end;
     end; //Fim while

     VerificaArquivo:=verifica;
 end;    // Fim função VerificaArquivo

// Este procedimento irá imprimir a saída 1) Pares da relação
procedure paresRelacao(linha,coluna:integer);
begin  // Recebe linha e coluna diretamente da função criamatriz que virá a seguir
     writeln ('    (',linha,',',coluna,')');
end;
// Fim procedimento paresRelacao

// Função que criará a matriz e possibilitará imprimir os pares da relação
function criamatriz(var contador:integer):matriz;
var f1: text;
    s,colunastring,aux : string ;
    posicaoum,posicaodois,linha,coluna,error: integer;
begin
     assign (f1,(ParamStr(1)));
     reset (f1);
     while (not eof(f1)) do
           begin
                readln (f1,s);
                if (s[1]='r') then
                begin
                     {Se a condição for verdadeira, a variável posicaoum recebe
                     a posição do primeiro espaço da string, logo em seguida esta
                     posição é deletada. posicaodois recebe a posição do segundo
                     espaço lido na string. Logo após a variável aux recebe uma cópia
                     da posiçãodois -1, que é o número correspondente a linha.
                     Logo em seguida, este valor que até então era uma string será
                     convertida para um inteiro}
                     posicaoum:=pos(' ', s);
                     delete(s,1,(posicaoum));
                     posicaodois:=pos(' ', s);
                     aux:=copy(s,1,posicaodois-1);
                     val(aux,linha,error);
                     if (error > 0) then
                     begin
                          writeln ('erro de converção');
                     end;
                     {A posicaodois é deletada e a variável colunastring recebe a string
                     que é o valor referente a coluna, em seguida este valor é convertido
                     em un número inteiro, criando a matriz}
                     delete(s,1,posicaodois);
                     colunastring:=s;
                     val(colunastring,coluna,error);
                     criamatriz[linha,coluna]:= 1;
                     if linha = coluna then
                     begin
                          contador:= 1 + contador; // Usado para verificar se é reflexiva
                     end;
                     paresRelacao(linha,coluna);
                end;
           end;
close(f1);
end;
// Fim da função criamatriz

// Função irá somar as linhas da matriz para realizar os testes
function respostalinha(matrizaux:matriz; cardinalidade:integer): boolean;
var resposta: boolean;
    i,j,soma: integer;
    {Função usada para vefificar se a mais de uma relação na linha
    e retorna resposta true se tiver apenas um par e false se for mais que um par}
begin
     resposta:=true;
     for i:=1 to cardinalidade do
         begin
              soma:=0;
              for j:=1 to cardinalidade do
              begin
                   soma:=soma+matrizaux[i,j];
              end;
              if (soma > 1) then
              begin
                   resposta:=false;
                   break;
              end
              else
              begin
                   resposta:=true;
              end;
         end;
         respostalinha:= resposta;
end;
// Fim da função respostalinha

// Função irá somar as colunas para realizar os testes
function respostacoluna(matrizaux:matriz;cardinalidade:integer):boolean;
var resposta:boolean;
    i,j,soma: integer;
    {Função usada para vefificar se a mais de uma relação na coluna
    e retorna resposta true se tiver apenas um par e false se for mais que um par}
begin
     resposta:=true;
     for i:=1 to cardinalidade do
     begin
          soma:=0;
          for j:=1 to cardinalidade do
          begin
               soma:=soma+matrizaux[j,i];
          end;
          if (soma > 1) then
          begin
               resposta:=false;
               break;
          end
          else
          begin
               resposta:=true;
          end;
     end;
    respostacoluna:= resposta;
end;
// Fim da função respostacoluna

// Procedimento classifica o tipo da relação
procedure ClassificaTipoRelacao(respostalinha,respostacoluna:boolean);
begin {Recebe o verdadeiro ou falso dos procedimentos respostacoluna e
      respostalinha}

     //início teste 1-Para-1
     if respostacoluna and respostalinha then
     begin // Será um 1-Para-1 se na coluna e na linha tiver até uma relação
          writeln('    1-Para-1');
     end;
     //fim teste 1-Para-1

     //início teste 1-Para-N
     if (not(respostalinha)) and (respostacoluna) then
     begin // Se a linha contém mais que uma relação e a coluna até uma relação
          writeln('   1-Para-N');
     end;
     //fim teste 1-Para-N

     //início teste N-Para-1
     if (not(respostacoluna)) and (respostalinha) then
     begin // Se a coluna contém mais que uma relação e a linha até uma relação
          writeln('    N-Para-1');
     end;
     //fim teste N-Para-1

     //início teste N-Para-N
     if (not(respostalinha)) and (not(respostacoluna)) then
     begin // Coluna e linha contém mais que uma relação
          writeln('    N-Para-N');
     end;
     //fim teste N-Para-N
end;
//fim procedimento ClassificaTipoRelacao

// Procedimento verifica se a relação é reflexiva
procedure verificaReflexiva(cont,cardinalidade:integer;var reflexiva:boolean);
begin
     // Verifica reflexividade
     if (cont = cardinalidade) then
     begin {É reflexiva se todos os pares do tamanho da reflexividade forem iguais
           ao número de pares da relação onde linha e coluna forem iguais}
          writeln('    Reflexiva');
          reflexiva:=true;
     end;
end;
// Fim procedimento verificaReflexiva

// Procedimento verifica se a relação é simétrica
procedure verificaSimetria(matrizaux:matriz;cardinalidade:integer; var simetrica:boolean);
var verificador: boolean;
    i,j: integer;
begin
verificador:=true;
for i:= 1 to cardinalidade do
    begin  // trava linha
         for j:= 1 to cardinalidade do
         begin //trava coluna
              if matrizaux[i,j] = 1 then
              begin // Verifica se a relação existe
                   if matrizaux[j,i] <> 1 then
                      begin {Se a relação anterior existir então a relação contrária
                            também tem que existir, para ser simétrica}
                           verificador:= false;
                      end;
              end;
              if verificador = false then
              begin
                   break;
              end;
         end;
         if verificador = false then
         begin
              break;
         end;
    end;
    if verificador then
    begin
         simetrica:=true;
         writeln('    Simétrica');
    end;
end;
// Fim procedimento verificaSimetria

var cardinalidade,contador : integer;
    matrizaux : matriz  ;
    respostaum,respostadois,verifica,simetrica,reflexiva : boolean;
begin
    clrscr;
    contador:= 0;
    simetrica:= false;
    reflexiva:= false;
    writeln('Classificador');
    writeln('=============');
    verifica:= VerificaArquivo();
    if (not(verifica)) then
    begin
         writeln;
         writeln('Arquivo de entrada contém erro(s)!');
         writeln;
    end
    else
    begin
         writeln('1) Pares da relação');
         cardinalidade:= recebecardinalidade();
         matrizaux:= criamatriz(contador);
         respostaum:= respostalinha(matrizaux,cardinalidade);
         respostadois:=respostacoluna(matrizaux,cardinalidade);
         writeln;
         writeln('2) Classificação quanto ao tipo:');
         writeln;
         ClassificaTipoRelacao(respostaum,respostadois);
         writeln;
         writeln('3) Classificação quanto a propriedades:');
         writeln;
         verificaReflexiva(contador,cardinalidade,reflexiva);
         verificaSimetria(matrizaux,cardinalidade,simetrica);
         if (simetrica = false) and (reflexiva = false) then
         begin
              writeln ('    Não é Simétrica nem Reflexiva');
         end;
         writeln;
         writeln('Fim de processamento');
         readkey;
    end;
end.
