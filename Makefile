start:
	bundle exec jekyll serve -H 0.0.0.0 -P 3000 --livereload

build:
	bundle exec jekyll build

# Checks the built site for broken internal links and images.
test:
	bundle exec htmlproofer _site --disable-external --ignore-missing-alt --no-enforce-https

.PHONY: start build test
