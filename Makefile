.PHONY: test format

VC=v

fmt:
	$(VC) fmt -w .

test:
	$(VC) test tests

run:
	$(VC) run cmd/vish

windows_build:
	$(VC) -os windows .


