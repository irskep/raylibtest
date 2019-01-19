.PHONY: run

run:
	cd binaries && nim c -r \
		--passL:'-L. -lraylib libraylib.a -framework OpenGL -framework IOKit -framework AppKit -framework CoreVideo' \
		--cincludes:./binaries \
		--verbosity:2 \
		--out:demo ../demo.nim