.DEFAULT_GOAL := all
.PHONY: all kyber_ref kyber_avx2 tests build_tests

$(CURDIR)/build:
	mkdir -p $@
$(CURDIR)/build/ref: $(CURDIR)/build
	mkdir -p $@
$(CURDIR)/build/avx2: $(CURDIR)/build
	mkdir -p $@

VARIANTS := 512 768 1024

ARCHIVES_REF := $(foreach sbits, $(VARIANTS), $(CURDIR)/build/ref/$(sbits)/libkyber$(sbits).a)
SHARED_REF := $(foreach sbits, $(VARIANTS), $(CURDIR)/build/ref/$(sbits)/libkyber$(sbits).so)
ARCHIVES_AVX2 := $(foreach sbits, $(VARIANTS), $(CURDIR)/build/avx2/$(sbits)/libkyber$(sbits).a)
SHARED_AVX2 := $(foreach sbits, $(VARIANTS), $(CURDIR)/build/avx2/$(sbits)/libkyber$(sbits).so)

$(ARCHIVES_REF): kyber_ref
$(ARCHIVES_AVX2): kyber_avx2

kyber_ref: $(CURDIR)/build/ref
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/ref BUILD_ROOT=$(CURDIR)/build/ref

kyber_avx2: $(CURDIR)/build/avx2
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/avx2 BUILD_ROOT=$(CURDIR)/build/avx2

build_ref_tests: $(ARCHIVES_REF)
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/ref/test build_tests ARCHIVE_ROOT=$(CURDIR)/build/ref BUILD_ROOT=$(CURDIR)/build/ref

build_avx2_tests: $(ARCHIVES_AVX2)
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/avx2/test build_tests ARCHIVE_ROOT=$(CURDIR)/build/avx2 BUILD_ROOT=$(CURDIR)/build/avx2

build_tests: build_ref_tests build_avx2_tests

ref_tests: $(ARCHIVES_REF)
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/ref/test tests ARCHIVE_ROOT=$(CURDIR)/build/ref BUILD_ROOT=$(CURDIR)/build/ref

avx2_tests: $(ARCHIVES_AVX2)
	$(MAKE) -C vendor/github.com/pq-crystals/kyber-11d00ff/avx2/test tests ARCHIVE_ROOT=$(CURDIR)/build/avx2 BUILD_ROOT=$(CURDIR)/build/avx2

tests: ref_tests avx2_tests

all: kyber_ref kyber_avx2 build_tests
