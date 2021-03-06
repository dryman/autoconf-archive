# ===========================================================================
#    http://www.gnu.org/software/autoconf-archive/ax_check_awk_split.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_AWK_SPLIT([ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Check if AWK supports split() function. If successful execute
#   ACTION-IF-SUCCESS otherwise ACTION-IF-FAILURE.
#
#   This work is heavily based upon testawk.sh script by Heiner Steven. You
#   should find his script (and related works) at
#   <http://www.shelldorado.com/articles/awkcompat.html>. Thanks to
#   Alessandro Massignan for his suggestions and extensive nawk tests on
#   FreeBSD.
#
# LICENSE
#
#   Copyright (c) 2009 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 8

AC_DEFUN([AX_CHECK_AWK_SPLIT], [
  AX_TRY_AWK_EXPOUT([split()],
    [],[ print split("A B", a, " ") ],[2],
    [$1],[$2])
])
