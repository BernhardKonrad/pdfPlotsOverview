dir=$1
rm $dir/temp.*
rm $dir/overview.pdf
touch $dir/temp.tex
echo "\documentclass{article}" >> $dir/temp.tex
echo "\usepackage[english]{babel}" >> $dir/temp.tex
echo "\usepackage[margin=2cm]{geometry}" >> $dir/temp.tex
echo "\usepackage{graphicx}" >> $dir/temp.tex
echo "\begin{document}" >> $dir/temp.tex
echo "\begin{center}" >> $dir/temp.tex
for f in $(ls $dir/*.pdf)
do
    echo "\includegraphics[height=.45\textheight]{$f}" >> $dir/temp.tex
    echo " " >> $dir/temp.tex
    echo "\bigskip" >> $dir/temp.tex
    echo " " >> $dir/temp.tex
done
echo "\end{center}" >> $dir/temp.tex
echo "\end{document}" >> $dir/temp.tex
pdflatex $dir/temp.tex
mv temp.pdf overview.pdf
rm temp.*
if [ $(uname -a | grep mac | wc -l) = "1" ]; then
    open -a Preview $dir/overview.pdf
elif [ $(uname -a | grep linux | wc -l) = "1" ]; then
    acroread $dir/overview.pdf
fi