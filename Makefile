.PHONY: run

run:
	nim c -r \
		--passL:'-Lbinaries -lraylib binaries/libraylib.a' \
		--passL:'-framework OpenGL -framework IOKit -framework AppKit -framework CoreVideo' \
		--cincludes:./binaries \
		--verbosity:2 \
		--out:binaries/demo demo.nim