default: bootstrap

RVERSION ?= 3.6.0

bootstrap:
	@~/R-${RVERSION}/bin/Rscript --vanilla bootstrap.R

installer:
	@makensis INSTALL_SCRIPT.nsi

