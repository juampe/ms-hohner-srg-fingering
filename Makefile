all: api2 api3

base%:
	mkdir artefact
	cp assets/* artefact/
	cp LICENSE artefact/LICENSE.txt
	rm artefact/*.zip
	markdown README.md 2>/dev/null > artefact/README.html

api%:
	$(eval VERSION := $(subst api,,$@))
	$(MAKE) base$(VERSION)
	rm -f "Hohner SRG Fingering-API-$(VERSION).x.zip" 2>/dev/null
	cp "Hohner SRG Fingering $(VERSION).qml" "artefact/Hohner SRG Fingering.qml"
	mv artefact "Hohner SRG Fingering"
	zip -r -9 "Hohner SRG Fingering-API-$(VERSION).x.zip" "Hohner SRG Fingering"
	rm -Rf "Hohner SRG Fingering" 2>/dev/null
	

	