PLATFORM_ARG=linux/amd64
VERSION=$(shell git describe --tags --always)
IMAGE_REGISTRY_URI=registry.kii.la/kiila/heptabase-frontend:${VERSION}

.PHONY: all build install uninstall template

all: build install
	@echo "Build completed, version: $(VERSION)"

.PHONY: build
build:
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

.PHONY: install
install: build
	helm -n blog upgrade frontend $(CURDIR)/.deploy/go-heptabase/ \
 		-f $(CURDIR)/.deploy/go-heptabase/local.values.yaml \
 		--create-namespace \
 		--install \
 		--kube-context kiila \
 		--set-string image.tag=$(VERSION)

.PHONY: uninstall
uninstall:
	helm -n blog uninstall frontend --kube-context kiila

.PHONY: template
template:
	helm -n blog template frontend $(CURDIR)/.deploy/go-heptabase/ \
		-f $(CURDIR)/.deploy/go-heptabase/local.values.yaml \
		--kube-context kiila > \
			$(CURDIR)/.deploy/go-heptabase/template.yaml