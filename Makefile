default: bootstrap

RVERSION ?= 4.0.2

bootstrap:
	@~/R-${RVERSION}/bin/Rscript --vanilla bootstrap.R

installer:
	@makensis INSTALL_SCRIPT.nsi
