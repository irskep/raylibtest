.PHONY: run

# --passL:'-L. -lraylib'
run:
	cd binaries && nim c -r \
		--passL:"-lraylib libraylib.a" \
		--cincludes:./binaries \
		../demo.nim