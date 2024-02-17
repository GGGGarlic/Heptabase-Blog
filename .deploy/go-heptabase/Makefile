install:
	helm -n blog upgrade frontend . \
 		-f local.values.yaml \
 		--create-namespace \
 		--install \
 		--kube-context kiila \
 		--set-string image.tag=$(shell git rev-parse --short HEAD)

uninstall:
	helm -n blog uninstall frontend --kube-context kiila

template:
	helm -n blog template frontend . -f local.values.yaml --kube-context kiila > template.yaml