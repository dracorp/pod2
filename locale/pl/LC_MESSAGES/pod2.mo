��          �      \      �  x   �  �   J  (   �     �  %     1   A  )   s  R   �  !   �  `     $   s     �     �  1   �     �  '   �  @   &  k   g  m   �  �  A       �   �  *   	  #   C	  &   g	  8   �	  2   �	  Z   �	     U
  [   t
  -   �
     �
       A         a  *   �  E   �  y   �  {   m                                   	                               
                                 	--i18n - generates template pot file, which contains a list of all the translatable strings extracted from the sources
 	--i18n - generates template pot file, which contains a list of all the translatable strings extracted from the sources, only for pod2.pl
 	--man - generates man page for pod2.pl
 	-c header - header of page
 	-d date - date of last modification
 	-h -print this help. For more read 'man 1 pod2'
 	-i inputfile - input file with POD data
 	-o outputfile - e.g. '-o pod2.1.gz', by default program write to 'basename.1.gz'
 	-r version - program's version 
 
At the beginning make a proper symlink to the program pod2.pl e.g.:
$ ln -s pod2.pl pod2man.pl
 
and may be ending extension .pl[x]?  not found in system File  I cann't use input file because it isn't readable Input file isn't defined Other programs have not yet implemented The name of running program must match to one of the following:
 Usage: pod2[man|html|text|latex] -i [inputfile|-o outputfile|-d date|-c header|-r version|-h] --man|--i18n
 Usage: pod2[man|html|text|latex] [-i inputfile|-o outputfile|-d date|-c header|-r version|-h] [--man|--i18n]
 Project-Id-Version: pod2
POT-Creation-Date: 
PO-Revision-Date: 2011-06-03 14:33+0100
Last-Translator: Piotr Rogoża <rogoza.piotr@gmail.com>
Language-Team: dracoRP
Language: pl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=3; plural=(n==1 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
X-Poedit-Language: Polish
X-Poedit-Country: POLAND
X-Poedit-SourceCharset: utf-8
 	--i18n - generuje szablon pliku pot, który zawiera listę wszystkich do przetłumaczenia słów wyciągniętych ze źródła
 	--i18n - generuje szablon pliku pot, który zawiera listę wszystkich do przetłumaczenia słów wyciągniętych ze źródłeł, tylko dla pod2.pl
 	--man - generuje stronę man dla pod2.pl
 	-c nagłówek - nagłówek strony
 	-d data - data ostatniej modyfikacji
 	-h wyświetl tą pomoc. Po więcej czytaj 'man 1 pod2'
 	-i plikwejściowy - plik wejściowy z danymi POD
 	-o plikwyjściowy - np. '-o pod2.1.gz', domyślnie program zapisze do 'nazwabazowa.1.gz'
 	-r wersja - wersja programu 
 
Na początku zrób właściwy symlink do programu pod2.pl np.:
$ ln -s pod2.pl pod2man.pl
 
i może się kończyć rozszerzeniem .pl[x]?  nie znaleziony w systemie Plik  Nie mogę użyć pliku wejściowego ponieważ nie jest do odczytu Plik wejściowy nie zdefiniowany Inne programy jeszcze nie zaimplementowane Nazwa uruchamianego programu musi pasować do jednego z poniższych:
 Użycie: pod2[man|html|text|latex] -i [plikwejściowy|-o plikwyjściowy|-d data|-c nagłówek|-r wersja|-h] --man|--i18n
 Użycie: pod2[man|html|text|latex] [-i plikwejściowy|-o plikwyjściowy|-d data|-c nagłówek|-r wersja|-h] [--man|--i18n]
 