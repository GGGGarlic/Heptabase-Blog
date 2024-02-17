PLATFORM_ARG=linux/amd64
VERSION=$(shell git describe --tags --always)
IMAGE_REGISTRY_URI=registry.kii.la/kiila/heptabase-frontend:${VERSION}

build_archive:
	buildctl --addr=tcp://172.20.20.1:31235 \
		build \
		--frontend=dockerfile.v0 \
		--opt platform=$(PLATFORM_ARG) \
		--opt filename=./.dockerfile \
		--local context=. \
		--local dockerfile=. \
		--export-cache type=inline \
	 	--import-cache type=registry,ref=$(IMAGE_REGISTRY_URI) \
		--progress=plain \
		--output type=image,name=$(IMAGE_REGISTRY_URI),push=true,oci-mediatypes=true