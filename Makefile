VC=v

fmt:
	find . -type f -name '*.v' | xargs -n1 $(VC) fmt -w

test:
	$(VC) test tests/hello_test.v

run:
	$(VC) run .

windows_build:
	$(VC) -os windows .

.PHONY: test format
