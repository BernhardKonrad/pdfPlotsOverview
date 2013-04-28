rm temp.*
rm overview.pdf
touch temp.tex
echo "\documentclass{article}" >> temp.tex
echo "\usepackage[english]{babel}" >> temp.tex
echo "\usepackage[margin=2cm]{geometry}" >> temp.tex
echo "\usepackage{graphicx}" >> temp.tex
echo "\begin{document}" >> temp.tex
echo "\begin{center}" >> temp.tex
for f in *.pdf
do
    echo "\includegraphics[height=.45\textheight]{$f}" >> temp.tex
    echo " " >> temp.tex
    echo "\bigskip" >> temp.tex
    echo " " >> temp.tex
done
echo "\end{center}" >> temp.tex
echo "\end{document}" >> temp.tex
pdflatex temp.tex
mv temp.pdf overview.pdf
rm temp.*
if [ $(uname -a | grep mac | wc -l) = "1" ]; then
    open -a Preview overview.pdf
elif [ $(uname -a | grep linux | wc -l) = "1" ]; then
    acroread overview.pdf
fi
