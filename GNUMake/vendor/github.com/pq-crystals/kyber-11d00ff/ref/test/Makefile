.DEFAULT_GOAL := tests
.PHONY: test tests build_tests build_test run-test runtest run-tests runtests

CC ?= /usr/bin/cc
CFLAGS += -Wall -Wextra -Wpedantic -Wmissing-prototypes -Wredundant-decls \
  -Wshadow -Wpointer-arith -O3 -fomit-frame-pointer -z noexecstack -fPIC

SRC_DIR := ../../../../../../../vendor/github.com/pq-crystals/kyber-11d00ff/ref/test

C_FILES := cpucycles.c speed_print.c test_kyber.c test_speed.c test_vectors.c

VARIANTS := 512 768 1024

BUILD_ROOT ?= build
ARCHIVE_ROOT ?= $(PREFIX)/lib
ARCHIVES := $(foreach sbits, $(VARIANTS), $(ARCHIVE_ROOT)/$(sbits)/libkyber$(sbits).a)
OBJECTS := $(foreach srcfile, $(C_FILES), $(BUILD_ROOT)/$(srcfile).o)

$(BUILD_ROOT):
	mkdir -p $@

$(OBJECTS): $(BUILD_ROOT)/%.o: $(SRC_DIR)/% $(BUILD_ROOT)
	$(CC) $(CFLAGS) -c $< -o $@ -I$(SRC_DIR)/../

$(BUILD_ROOT)/test_kyber: $(BUILD_ROOT)/test_kyber.c.o $(ARCHIVES)
	$(CC) -o $@ $^

$(BUILD_ROOT)/test_speed: $(BUILD_ROOT)/test_speed.c.o $(BUILD_ROOT)/cpucycles.c.o $(BUILD_ROOT)/speed_print.c.o $(ARCHIVES)
	$(CC) -o $@ $^

$(BUILD_ROOT)/test_vectors: $(BUILD_ROOT)/test_vectors.c.o $(BUILD_ROOT)/cpucycles.c.o $(ARCHIVES)
	$(CC) -o $@ $^

tests: $(BUILD_ROOT)/test_kyber $(BUILD_ROOT)/test_speed $(BUILD_ROOT)/test_vectors
	$(BUILD_ROOT)/test_kyber
	$(BUILD_ROOT)/test_speed
	$(BUILD_ROOT)/test_vectors

build_tests: $(BUILD_ROOT)/test_kyber $(BUILD_ROOT)/test_speed $(BUILD_ROOT)/test_vectors

test: tests
build_test: build_tests
run-test: tests
runtest: tests
run-tests: tests
runtests: tests
