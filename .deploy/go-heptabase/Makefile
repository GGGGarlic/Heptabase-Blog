install:
	helm -n blog upgrade frontend $(CURDIR)/ \
 		-f $(CURDIR)/local.values.yaml \
 		--create-namespace \
 		--install \
 		--kube-context kiila \
 		--set-string image.tag=$(VERSION)

uninstall:
	helm -n blog uninstall frontend --kube-context kiila

template:
	helm -n blog template frontend $(CURDIR)/ -f $(CURDIR)/local.values.yaml --kube-context kiila > $(CURDIR)/template.yaml