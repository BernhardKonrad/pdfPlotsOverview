function latexHeader()
{
echo "\documentclass{article}"
echo "\usepackage[english]{babel}"
echo "\usepackage[margin=2cm]{geometry}"
echo "\usepackage{graphicx}"
echo "\begin{document}"
echo "\begin{center}"
}

function latexIncludeGraphics()
{
echo "\includegraphics[height=.45\textheight]{$1}"
echo " "
echo "\bigskip"
echo " "
}

function latexFooter()
{
echo "\end{center}"
echo "\end{document}"
}


dir=$1

if [ -z "$2" ]; then
outputName=overview.pdf
else
outputName=$2
fi

rm temp.*
rm overview.pdf
touch temp.tex
latexHeader >> temp.tex
for f in $(ls $dir/*.pdf)
do
	echo $f
	latexIncludeGraphics $f >> temp.tex
done
latexFooter >> temp.tex
pdflatex temp.tex
mv temp.pdf $outputName
rm temp.*
if [ $(uname -a | grep mac | wc -l) = "1" ]; then
    open -a Preview $outputName
elif [ $(uname -a | grep linux | wc -l) = "1" ]; then
    acroread $outputName
fi