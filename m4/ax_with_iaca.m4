# ===========================================================================
#       http://www.gnu.org/software/autoconf-archive/ax_with_iaca.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_WITH_IACA()
#
# DESCRIPTION
#
#   Enables support for IACA (Intel Architecture Code Analyzer). The
#   configure script would have an option "--with-iaca=<iaca_home>", and
#   user can specify iaca installation path to enable IACA. This macro also
#   export if the IACA header were found or not with the variable
#   "HAVE_IACAMARKS_H". In your source code you should include the iaca
#   header like so:
#
#     #ifdef HAVE_IACAMARKS_H
#     #include <iacaMarks.h>
#     #endif
#
#   If the IACA installation or iacaMarks.h were not found, the IACA mark
#   macros (IACA_START, IACA_END, IACA_MSC64_START, IACA_MSC64_END) will be
#   defined as empty macro.
#
#   By default the IACA_MARKS_OFF option is turned on in CPPFLAGS, but you
#   can undefine it by specify -UIACA_MARKS_OFF in your object specific flag
#   setting. See the following example.
#
#   Say you have two source files foo.c and bar.cc.  Both has IACA marks and
#   you want to generate two object files to run with iaca. You can create
#   .PHONEY make target and name the object files with prefix "iaca_", and
#   create the following rules to compile it in a generic way. Note that for
#   the "iaca_" prefixed target the CPPFLAGS has "-UIACA_MARKS_OFF"
#   appended, which enables the IACA marks in the target objects.
#
#     # foo will compiled with -DIACA_MARKS_OFF
#     bin_PROGRAMS = foo
#     foo_SOURCES = foo.c bar.cc
#
#     .PHONEY:iaca
#     iaca: iaca_foo.o iaca_bar.o
#
#     # iaca_* will compiled with -DIACA_MARKS_OFF -UIACA_MARKS_OFF
#     iaca_%.o:       CPPFLAGS += -UIACA_MARKS_OFF
#     iaca_%.o:       %.c 
#             $(COMPILE.c) $(OUTPUT_OPTION) $<
#     iaca_%.o:       %.C 
#             $(COMPILE.C) $(OUTPUT_OPTION) $<
#     iaca_%.o:       %.cc
#             $(COMPILE.cc) $(OUTPUT_OPTION) $<
#     iaca_%.o:       %.cpp
#             $(COMPILE.cpp) $(OUTPUT_OPTION) $<
#
#   When running make, the normal build will not have the IACA marks enabled
#   and can be run as normal program. You can also run "make iaca" to
#   produce the IACA marks enabled object files.
#
# LICENSE
#
#   Copyright (c) 2016 Felix Chern <idryman@gmail.com>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 1

AC_DEFUN([_AX_IACA_DEFINE_EMPTY_MACRO],
 [AC_DEFINE([IACA_START],[],[Defined if IACA is enabled])
  AC_DEFINE([IACA_END],[],[Defined if IACA is enabled])
  AC_DEFINE([IACA_MSC64_START],[],[Defined if IACA is enabled])
  AC_DEFINE([IACA_MSC64_END],[],[Defined if IACA is enabled])
])

AC_DEFUN([AX_WITH_IACA],[
  AC_ARG_WITH([iaca],
   [AS_HELP_STRING([--with-iaca=<iaca_home>],
     [Enable support for IACA (Intel Architecture Code Analyzer)])],
   [],
   [with_iaca=no])
  AS_IF([test "X$with_iaca" != "Xno"], [
    AC_CHECK_FILE(["$with_iaca/include"],
      [CPPFLAGS="$CPPFLAGS -I$with_iaca/include"])
    AC_CHECK_HEADER([iacaMarks.h],
      [CPPFLAGS="$CPPFLAGS -DIACA_MARKS_OFF"],
      [_AX_IACA_DEFINE_EMPTY_MACRO()])
    ],
    [_AX_IACA_DEFINE_EMPTY_MACRO()]
  )
])
