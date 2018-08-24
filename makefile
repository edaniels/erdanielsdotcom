build:
	sgs .
	find dist -name '*.html' -type f -print -exec tidy -config ./tidy_conf.txt -m '{}' \;

setup:
	brew install tidy-html5
	npm install -g sgs

clean:
	rm -rf dist
