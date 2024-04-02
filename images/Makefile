earth.jpg:
	curl https://www.nasa.gov/wp-content/uploads/2023/03/135918main_bm1_high.jpg -o $@

example-comparison.png: earth.jpg earth_with_label.jpg
	../diff-image -o $@   $^

earth_with_label.jpg: earth.jpg
	convert $^ -gravity South -pointsize 60  -undercolor white -stroke gray -fill gray -annotate +30+30 'The earth seen from Apollo 17' $@
