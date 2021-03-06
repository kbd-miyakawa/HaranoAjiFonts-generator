BIN = make_conv_table make_glyphorder make_kanji_table \
	make_jisx0208_table make_feature_table \
	merge_table \
	conv_name conv_cmap conv_CFF \
	conv_GDEF conv_GPOS conv_GSUB \
	conv_VORG conv_mtx \
	check_table_CMap

all: version.hh $(BIN)

#
# Libraries
#

PUGIXML_LIBS = -lpugixml
PUGIXML_CFLAGS =

LDLIBS += $(PUGIXML_LIBS)
CXXFLAGS += $(PUGIXML_CFLAGS)


#
# Objects
#

MAKE_CONV_TABLE_OBJS = make_conv_table_main.o \
	fontcmap_reverse.o prefer_unicode.o cmapfile.o
MAKE_GLYPHORDER_OBJS = make_glyphorder_main.o conv_table.o
MAKE_KANJI_TABLE_OBJS = make_kanji_table_main.o \
	AI0-SourceHan.o aj1x-kanji.o
MAKE_JISX0208_TABLE_OBJS = make_jisx0208_table_main.o \
	jisx0208_mapping.o
MAKE_FEATURE_TABLE_OBJS = make_feature_table_main.o \
	 conv_table.o gsub_single.o aj1x-gsub.o
MERGE_TABLE_OBJS = merge_table_main.o \
	conv_table.o
CONV_NAME_OBJS = conv_name_main.o
CONV_CMAP_OBJS = conv_cmap_main.o walker.o walker_conv.o walker_cmap.o \
	conv_table.o
CONV_CFF_OBJS = conv_CFF_main.o walker.o walker_conv.o walker_CFF.o \
	conv_table.o
CONV_GDEF_OBJS = conv_GDEF_main.o conv_table.o
CONV_GPOS_OBJS = conv_GPOS_main.o conv_table.o
CONV_GSUB_OBJS = conv_GSUB_main.o conv_table.o
CONV_VORG_OBJS = conv_VORG_main.o conv_table.o
CONV_MTX_OBJS = conv_mtx_main.o walker.o walker_conv.o conv_table.o
CHECK_TABLE_CMAP_OBJS = check_table_CMap_main.o conv_table.o cmapfile.o

OBJS = $(MAKE_CONV_TABLE_OBJS) $(MAKE_GLYPHORDER_OBJS) \
	$(MAKE_KANJI_TABLE_OBJS) $(MAKE_JISX0208_TABLE_OBJS) \
	$(MAKE_FEATURE_TABLE_OBJS) \
	$(MERGE_TABLE_OBJS) \
	$(CONV_NAME_OBJS) $(CONV_CMAP_OBJS) $(CONV_CFF_OBJS) \
	$(CONV_GDEF_OBJS) $(CONV_GPOS_OBJS) $(CONV_GSUB_OBJS) \
	$(CONV_VORG_OBJS) $(CONV_MTX_OBJS) \
	$(CHECK_TABLE_CMAP_OBJS)


#
# Programs and other settings
#

INSTALL = install
INSTALL_DIR = $(INSTALL) -m 755 -d
INSTALL_FILE = $(INSTALL) -m 644
INSTALL_EXE = $(INSTALL) -m 755

CXXFLAGS_STD = -std=c++11

CXXFLAGS += $(CXXFLAGS_STD)


#
# Dependencies
#

DEPS = $(OBJS:.o=.d)
CPPFLAGS += -MMD -MP -MF $(@:.o=.d) -MT $@
-include $(DEPS)


#
# Rules
#

.PHONY: all clean

clean:
	$(RM) *~ $(OBJS) $(DEPS) version.hh

make_conv_table: $(MAKE_CONV_TABLE_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

make_glyphorder: $(MAKE_GLYPHORDER_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

make_kanji_table: $(MAKE_KANJI_TABLE_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

make_jisx0208_table: $(MAKE_JISX0208_TABLE_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

make_feature_table: $(MAKE_FEATURE_TABLE_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

merge_table: $(MERGE_TABLE_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_name: $(CONV_NAME_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_cmap: $(CONV_CMAP_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_CFF: $(CONV_CFF_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_GDEF: $(CONV_GDEF_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_GPOS: $(CONV_GPOS_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_GSUB: $(CONV_GSUB_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_VORG: $(CONV_VORG_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

conv_mtx: $(CONV_MTX_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

check_table_CMap: $(CHECK_TABLE_CMAP_OBJS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

VERSION := $(shell cat ../version.txt)

version.hh: version.hh.in ../version.txt
	sed -e 's/@VERSION@/$(VERSION)/g' $< > $@

install: all
	$(INSTALL_DIR) ../bin
	$(INSTALL_EXE) $(BIN) ../bin


#
# Implicit variables (from `make -p`)
#

#CXX = g++
#RM = rm -f
#COMPILE.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
#LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
#OUTPUT_OPTION = -o $@


#
# Implicit rules (from `make -p`)
#

#%.o: %.cc
#	$(COMPILE.cc) $(OUTPUT_OPTION) $<
