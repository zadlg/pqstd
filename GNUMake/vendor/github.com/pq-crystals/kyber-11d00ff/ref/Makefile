.DEFAULT_GOAL := all
.PHONY: all clean

CC ?= /usr/bin/cc
CFLAGS += -Wall -Wextra -Wpedantic -Wmissing-prototypes -Wredundant-decls \
  -Wshadow -Wpointer-arith -O3 -fomit-frame-pointer -z noexecstack -fPIC
NISTFLAGS += -Wno-unused-result -O3 -fomit-frame-pointer
CFLAGS += $(NISTFLAGS)

VARIANTS := 512 768 1024

SRC_DIR := ../../../../../../vendor/github.com/pq-crystals/kyber-11d00ff/ref
C_FILES := reduce.c cbd.c fips202.c indcpa.c kem.c ntt.c poly.c polyvec.c randombytes.c symmetric-shake.c verify.c
API_FILE := $(SRC_DIR)/api.h

BUILD_ROOT ?= build
BUILD_DIRS :=
OBJECTS :=
SHARED_LIBS :=
ARCHIVES :=
$(foreach sbits, $(VARIANTS), \
  $(eval BUILD_DIR$$(sbits) := $$(BUILD_ROOT)/$$(sbits)) \
  $(eval BUILD_DIRS += $$(BUILD_DIR$$(sbits))) \
  $(eval OBJECTS$$(sbits) := $$(foreach srcfile, $$(C_FILES), $$(BUILD_DIR$$(sbits))/$$(srcfile).o)) \
  $(eval OBJECTS += $$(OBJECTS$$(sbits))) \
  $(eval SHARED_LIBS += $$(BUILD_DIR$$(sbits))/libkyber$$(sbits).so) \
  $(eval ARCHIVES += $$(BUILD_DIR$$(sbits))/libkyber$$(sbits).a) \
)

$(BUILD_ROOT):
	mkdir -p $@
$(BUILD_DIRS): $(BUILD_ROOT)/%: $(BUILD_ROOT)
	mkdir -p $@

$(BUILD_ROOT)/512/%.o: $(SRC_DIR)/% $(BUILD_ROOT)/512
	$(CC) $(CFLAGS) -c $< -o $@ -I. -DKYBER_K=2
$(BUILD_ROOT)/768/%.o: $(SRC_DIR)/% $(BUILD_ROOT)/768
	$(CC) $(CFLAGS) -c $< -o $@ -I. -DKYBER_K=3
$(BUILD_ROOT)/1024/%.o: $(SRC_DIR)/% $(BUILD_ROOT)/1024
	$(CC) $(CFLAGS) -c $< -o $@ -I. -DKYBER_K=4

$(BUILD_ROOT)/512/libkyber512.so: $(OBJECTS512)
	$(CC) -o $@ -shared $^
$(BUILD_ROOT)/768/libkyber768.so: $(OBJECTS768)
	$(CC) -o $@ -shared $^
$(BUILD_ROOT)/1024/libkyber1024.so: $(OBJECTS1024)
	$(CC) -o $@ -shared $^
$(BUILD_ROOT)/512/libkyber512.a: $(OBJECTS512)
	$(AR) $(ARFLAGS) $@ $^
$(BUILD_ROOT)/768/libkyber768.a: $(OBJECTS768)
	$(AR) $(ARFLAGS) $@ $^
$(BUILD_ROOT)/1024/libkyber1024.a: $(OBJECTS1024)
	$(AR) $(ARFLAGS) $@ $^

all: $(OBJECTS) $(SHARED_LIBS) $(ARCHIVES)

$(PREFIX):
	mkdir -p $@

$(PREFIX)/lib: $(PREFIX)
	mkdir -p $@

$(PREFIX)/include: $(PREFIX)
	mkdir -p $@

install: $(SHARED_LIBS) $(ARCHIVES) $(PREFIX)/lib $(PREFIX)/include
	cp $(SHARED_LIBS) $(ARCHIVES) $(PREFIX)/lib
	cp $(API_FILE) $(PREFIX)/include/kyber.h

clean:
	$(foreach o, $(OBJECTS), $(shell rm -f $(o)))
	$(foreach sl, $(SHARED_LIBS), $(shell rm -f $(sl)))
	$(foreach ar, $(ARCHIVES), $(shell rm -f $(ar)))
	$(foreach sbits, $(VARIANTS), $(shell rmdir $(BUILD_ROOT)/$(sbits)))
	rmdir $(BUILD_ROOT)
