PHONY: build deploy

build:
	flutter build web
	cp ./build/web/index.html ./functions/index.html

deploy:
	flutter build web
	cp ./build/web/index.html ./functions/index.html
	firebase deploy