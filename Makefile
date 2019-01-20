.PHONY: run

run:
	-killall raylib_test
	nim c -r \
		--passL:'-Lbinaries -lraylib binaries/libraylib.a' \
		--passL:'-framework OpenGL -framework IOKit -framework AppKit -framework CoreVideo' \
		--cincludes:./binaries \
		--out:binaries/raylib_test demo.nim # --verbosity:2