# by Alfredo Llanos
VERSION=1.5.0
DATE=$(shell date)
# BOOTSTRAP
BOOTSTRAP = ./css/bootstrap.css
BOOTSTRAP_MIN = ./css/bootstrap.min.css
BOOTSTRAP_LESS = ./components/bootstrap/less/bootstrap.less
# STYLECSS
STYLECSS = ./css/style.css
STYLECSS_MIN = ./css/style.min.css
STYLECSS_LESS = ./src/less/style.less

JQUERY_UI_CSS = ./components/jquery-ui/themes/ui-lightness/jquery-ui.css
JQUERY_UI_CSS_MIN = ./css/jquery-ui.min.css

HR = ###############___________________###################

# CONFIG
LESS_COMPRESSOR ?= `which lessc`
UGLIFY_JS ?= `which uglifyjs`
WATCHR ?= `which watchr`

build:
	@echo "\n${HR}"
	@echo "Building Style ..."
	@echo "${HR}\n"
	recess ${BOOTSTRAP_LESS} --compile > ./css/bootstrap.css
	recess ${BOOTSTRAP_LESS} --compress > ./css/bootstrap.min.css
	recess ${STYLECSS_LESS} --compile > ./css/style.css
	recess ${STYLECSS_LESS} --compress > ./css/style.min.css
	# Font-Awesome no compila con RECESS
	lessc ./components/Font-Awesome/less/font-awesome.less ./css/font-awesome.css; \
	lessc ./components/Font-Awesome/less/font-awesome.less > ./css/font-awesome.min.css --compress; \
	cat ${BOOTSTRAP} ./css/font-awesome.css ${STYLECSS} > ./css/full.css
	cat ${BOOTSTRAP_MIN} ./css/font-awesome.min.css ${STYLECSS_MIN} > ./css/full.min.css

	@echo "\n${HR}"
	@echo "Building JavaScript ..."
	@echo "${HR}\n"
	cat src/js/jquery.lettering.js src/js/jquery.fittext.js src/js/jquery.nanoscroller.js src/js/js.plugins.js src/js/js.script.js > ./js/script.js
	#cat src/js/js.script.js > ./js/script.js
	uglifyjs -nc ./js/script.js > ./js/script.min.js
	cat ./components/jquery/jquery.min.js ./js/bootstrap.min.js ./js/script.min.js > ./js/full.min.js
	#cat ./components/jquery/jquery.min.js > ./js/full.min.js
	echo "Script Full & Parts!"; \

Style:
	@echo "\n${HR}"
	@echo "Building Style ..."
	@echo "${HR}\n"
	recess ${BOOTSTRAP_LESS} --compile > ./css/bootstrap.css
	recess ${BOOTSTRAP_LESS} --compress > ./css/bootstrap.min.css
	recess ${STYLECSS_LESS} --compile > ./css/style.css
	recess ${STYLECSS_LESS} --compress > ./css/style.min.css
	# Font-Awesome no compila con RECESS
	lessc ./components/Font-Awesome/less/font-awesome.less ./css/font-awesome.css; \
	lessc ./components/Font-Awesome/less/font-awesome.less > ./css/font-awesome.min.css --compress; \
	cat ${BOOTSTRAP} ./css/font-awesome.css ${STYLECSS} > ./css/full.css
	cat ${BOOTSTRAP_MIN} ./css/font-awesome.min.css ${STYLECSS_MIN} > ./css/full.min.css
	@echo "\n${HR}"
	@echo "DONE Style ..."
	@echo "${HR}\n"
script:
	@echo "\n${HR}"
	@echo "Building JavaScript ..."
	@echo "${HR}\n"
	cat src/js/jquery.lettering.js src/js/jquery.fittext.js src/js/jquery.nanoscroller.js src/js/js.plugins.js src/js/js.script.js > ./js/script.js
	#cat src/js/js.script.js > ./js/script.js
	uglifyjs -nc ./js/script.js > ./js/script.min.js
	cat ./components/jquery/jquery.min.js ./js/bootstrap.min.js ./js/script.min.js > ./js/full.min.js
	#cat ./components/jquery/jquery.min.js > ./js/full.min.js
	echo "Script Full & Parts!"; \

bs:
	recess ${BOOTSTRAP_LESS} --compile > ./css/bootstrap.css
	recess ${BOOTSTRAP_LESS} --compress > ./css/bootstrap.min.css
	recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ./css/bootstrap-responsive.css
	recess --compress ${BOOTSTRAP_RESPONSIVE_LESS} > ./css/bootstrap-responsive.min.css

fa:
	recess ./components/components/Font-Awesome/less/font-awesome.css --compile > ./css/font-awesome.css
	recess ./components/components/Font-Awesome/less/font-awesome.css --compress > ./css/font-awesome.min.css

bs-script:
	cat ./components/bootstrap/js/bootstrap-transition.js ./components/bootstrap/js/bootstrap-alert.js ./components/bootstrap/js/bootstrap-button.js ./components/bootstrap/js/bootstrap-carousel.js ./components/bootstrap/js/bootstrap-collapse.js ./components/bootstrap/js/bootstrap-dropdown.js ./components/bootstrap/js/bootstrap-modal.js ./components/bootstrap/js/bootstrap-tooltip.js ./components/bootstrap/js/bootstrap-popover.js ./components/bootstrap/js/bootstrap-scrollspy.js ./components/bootstrap/js/bootstrap-tab.js ./components/bootstrap/js/bootstrap-typeahead.js ./components/bootstrap/js/bootstrap-affix.js > ./js/bootstrap.js
	uglifyjs -nc ./js/bootstrap.js > ./js/bootstrap.min.js

watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make style' }"

