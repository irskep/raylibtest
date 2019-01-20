.PHONY: run

run:
	-killall raylib_test
	nim c -r \
		--passL:'-Lbinaries -lraylib binaries/libraylib.a' \
		--passL:'-framework OpenGL -framework IOKit -framework AppKit -framework CoreVideo' \
		-d:glfwJustCdecl \
		-d:runningForReal \
		--out:binaries/raylib_test src/raylibtests.nim # --verbosity:2