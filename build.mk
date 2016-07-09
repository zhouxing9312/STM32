# obj is come from external
target		:= $(obj)
PHONY		+= $(target)

obj-y		:=
target-dir	:= $(dir $(target))
sub-makefile	:= $(patsubst %/, %/Makefile, $(target-dir))
include $(sub-makefile)

# Clear these variable for build.include
export target-dir
subdir		:=
subdir-obj	:=
objs		:=

# build.include will parse the $(target)
include build.include

PHONY		+= $(subdir)

__build: $(subdir) $(objs)
	$(Q)$(LD) -r -o $(target-dir)built-in.o $(objs) $(subdir-obj)

#
#	$(Q)rm -rf $(target-dir)built-in.o
#	$(Q)$(AR) rcs $(target-dir)built-in.o $(objs) $(subdir-obj)

PHONY		+= __build

$(subdir):
	$(Q)$(MAKE) $(build)=$@

any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
if-changed = $(if $(strip $(any-prereq)), \
		@set -e; echo "    $(quiet_cmd_$1)"; ${cmd_$1})

space := $(empty)        $(empty)

quiet_cmd_cc_o_c = CC $(space) $(notdir $@)
      cmd_cc_o_c = $(CC) $(CFLAGS) $($@_c_flags) -c -o $@ $<
%.o:%.c
	$(call if-changed,cc_o_c)

quiet_cmd_cc_o_S = CC $(space) $(notdir $@)
      cmd_cc_o_S = $(CC) $(AFLAGS) $($@_a_flags) -c -o $@ $<
%.o:%.S
	$(call if-changed,cc_o_S)

quiet_cmd_cc_o_s = CC $(space) $(notdir $@)
      cmd_cc_o_s = $(CC) $(AFLAGS) $($@_a_flags) -c -o $@ $<
%.o:%.s
	$(call if-changed,cc_o_s)

quiet_cmd_cc_a_o = AR $(space) $(notdir $@)
      cmd_cc_a_o = $(AR) rcs $@ $<
%.a:%.o
	$(call if-changed,cc_a_o)

%:
	echo $@=$($@)

.PHONY: FORCE $(PHONY)
