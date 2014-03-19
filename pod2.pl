#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  pod2.pl
#
#        USAGE:  ./pod2.pl  
#
#  DESCRIPTION:  Parser na pod2man, pod2html, pod2text, pod2latex
#  Automatycznie dodaje opcję -u, przydatne przy diakrytykach
#
#      OPTIONS:  -i input|-o output|-d date|-c header|-r version|-h 
#      OPTIONS:  --i18n|--man only for pod2.pl
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Piotr Rogoża (piecia), rogoza.piotr@gmail.com
#      COMPANY:  dracoRP
#      VERSION:  1.0
#      CREATED:  31.05.2011 13:48:20
#     MODIFIED:  03.06.2011 09:27:07
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use Locale::gettext;
use POSIX;                                      # Needed for setlocale()
use Cwd qw(abs_path);

setlocale(LC_MESSAGES, "pl");
textdomain("pod2");
bindtextdomain("pod2","./locale");

#---------------------------------------------------------------------------
#  Zmienne globalne
#---------------------------------------------------------------------------
my ($input, $output, $date, $header, $version );         # parametry startowe: plik wejściowy, data modyfikacji, komentarz do strony man, nume wersji programu
my ($basedirectory, $basename);                 # bazowy katalog programu, bazowa nazwa wywoływanego programu bez rozszerzenia

sub help;                                       # deklaracja funkcji
sub init;

help unless @ARGV;
init;                                           # inicjacja $basedirectory i $basename

GetOptions(                                     # ustawienie parametrów startowych
	"i=s" => \$input,
	"o=s" => \$output,
	"d=s" => \$date,
	"c=s{,}" => \$header,
	"r=s" => \$version,
	"h" => \&help,
	"i18n" => \&i18n,
	"man" => \&man,
);
#---------------------------------------------------------------------------
#  Functions
#---------------------------------------------------------------------------
sub help { #{{{
	print gettext("Usage: pod2[man|html|text|latex] [-i inputfile|-o outputfile|-d date|-c header|-r version|-h] [--man|--i18n]\n");
	print gettext("\t-i inputfile - input file with POD data\n");
	print gettext("\t-o outputfile - e.g. '-o pod2.1.gz', by default program write to 'basename.1.gz'\n");
	print gettext("\t-d date - date of last modification\n");
	print gettext("\t-c header - header of page\n");
	print gettext("\t-r version - program's version \n");
	print gettext("\t-h -print this help. For more read 'man 1 pod2'\n");
	print gettext("\t--man - generates man page for pod2.pl\n"); 
	print gettext("\t--i18n - generates template pot file, which contains a list of all the translatable strings extracted from the sources, only for pod2.pl\n");
	print gettext("\nAt the beginning make a proper symlink to the program pod2.pl e.g.:\n\$ ln -s pod2.pl pod2man.pl\n");
	exit 0;
}	# ----------  end of subroutine help  ----------}}}
sub init { #{{{
#===  FUNCTION  ================================================================
#         NAME:  init
#  DESCRIPTION:  Ustawia $basedirectory na katalog w którym znajduje się pod2.pl, jeśli jest to "/usr/bin" to unieważnia $basedirectory
#  dodatkowo ustawia $basename wywoływanego programu
#===============================================================================
	$basedirectory = dirname(abs_path($0));
	if ($basedirectory =~ /^\/usr.*/) {                     # unieważnij $basedirectory jeśli pasuje do /usr
		$basedirectory = undef;
	}
	$basename = fileparse($0,qr/\.[^.]*/);
}	# ----------  end of subroutine init  ----------}}}
sub man { #{{{
#===  FUNCTION  ================================================================
#         NAME:  man
#  DESCRIPTION:  Generuje stronę man w oparciu o dane POD ze skryptu
#===============================================================================
	die "Base directory isn't defined" unless(-d "$basedirectory");
	die "Cann't write to $basedirectory/man1" unless(-w "$basedirectory/man1");
	my ( $VERSION, $DATE);
	open F,"<$0";
	while(<F>){
		if(/^#\s+MODIFIED:\s+([0-9\.]+)\s+/){
			$DATE = $1;
		}
		if(/^#\s+VERSION:\s+(.+)/){
			$VERSION = $1;
		}
	}
	close F;
	system("pod2man.pl -i $0 -o $basedirectory/man1/$basename.1.gz -d $DATE -c 'pod2* convert POD data' -r $VERSION");
	print "Failed to execute: $!\n" if ($? == -1);
}	# ----------  end of subroutine man  ----------}}}
sub i18n { #{{{
#===  FUNCTION  ================================================================
#         NAME:  i18n
#  DESCRIPTION:  Generuje szablon pliku tłumaczeń .pot w katalogu i18n
#===============================================================================
	die "Base directory isn't defined" unless(-d "$basedirectory");
	die "Missing directory i18n in $basedirectory" unless(-d "$basedirectory/i18n");
	my ($author, $email, $year, $options);
	open F,"<$0";
	while(<F>){
		if(/^#\s+CREATED:\s+([0-9\.]+)\s+/){
			$year = (split(/\./,$1))[2];
		}
		if(/^#\s+AUTHOR:\s+([^\s]++\s[^\s]+).*,\s+([^@]+@[^@\s]+)/){
			$author = $1;
			$email = $2;
		}
	}
	close F;
	my $copyrightholder="$year $author";
	$options="--add-comments=/ -L Perl --from-code=utf-8 --no-wrap -F --force-po --no-wrap --omit-header";
	if(-f "$basedirectory/i18n/$basename.pot"){
		$options .= " -j";
	}
	system("xgettext $options -d $basename --package-name=$basename --copyright-holder='$copyrightholder' --msgid-bugs-address=$email $0 -o $basedirectory/i18n/$basename.pot");
	print "Failed to execute: $!\n" if ($? == -1);
}	# ----------  end of subroutine i18n  ----------}}}
sub main { #{{{
#===  FUNCTION  ================================================================
#         NAME:  main
#  DESCRIPTION:  główna funkcja programu
#===============================================================================
    exit 0 if $basename eq "pod2";              # dla pod2.pl można już zakończyć pracę
	my ($options, $manname, $outputdir);
    my $mansection = 1;                         # sekcja man

	my @programs = qw(pod2man pod2html pod2text pod2latex); # dozwolone programy, symlinki
	for(@programs){
		`which $_ &>/dev/null`;
		if ($? != 0){
			die gettext("File "),$_,gettext(" not found in system");
		}
	}
	unless ($input){
		die gettext("Input file isn't defined");
	}
	unless (-r $input) {
		die gettext("I cann't use input file because it isn't readable");
	}
	unless (grep /$basename$/,@programs){
		print gettext("The name of running program must match to one of the following:\n");
		print "'@programs'";
		print gettext("\nand may be ending extension .pl[x]?");
		exit 1;
	}
	$manname = fileparse($input,qr/\.[^.]*/);
	$outputdir = dirname($input);
	if ($basename eq "pod2man"){
		$options = "-u ";
		$options .= "-r '$manname version $version' " if $version;
		$options .= "-c '$header' " if $header;
		$options .= "-d '$date' " if $date;
		$options .= "-n ".uc $manname." " if $manname;
		$options .= "$input " if $input;

		if($output){
			system("$basename $options | gzip - -c > $output");
		} else {
			if(-w $outputdir){
				system("$basename $options | gzip - -c > $outputdir/$manname.$mansection.gz"); # zapisz w tym samym katalogu co plik źródłowy
			} else {
				system("$basename $options | gzip - -c > $manname.$mansection.gz"); # zapisz w aktualnym katalogu w którym został wywołany program
			}
		}
		print "Failed to execute: $!\n" if ($? == -1);
	} else {
		print gettext("Other programs have not yet implemented");
		exit 0;
	}
}	# ----------  end of subroutine main  ----------}}}
#---------------------------------------------------------------------------
#  Main program
#---------------------------------------------------------------------------
main;
