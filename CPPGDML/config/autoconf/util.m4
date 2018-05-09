dnl
dnl m4 utility macros for GDML build system
dnl

# macro to check whether a test file exists
# FIXME: replace calls to this with autoconf's builtin _TEST_FILE macro
AC_DEFUN( GDML_CHECK_TEST_FILE, [

if test -z $1; then
  AC_MSG_ERROR([macro requires an argument of file to test]);
else
  arg_test_file=$1
fi

AC_CHECK_FILE($arg_test_file,
	[okay=yes],
	[okay=no])

if test $okay = no; then
  AC_MSG_ERROR([test file ${arg_test_file} was not found])
fi

])

# macro to check a package directory with an (optional) test file
#
# args:
# $1 = dir to check
# $2 = pkg name
# $3 = test file relative to $1
AC_DEFUN( GDML_CHECK_PKG_DIR, [

# pkg name
if test -z ${2}; then
  AC_MSG_ERROR([missing mandatory package name])
else
  arg_pkg=$2
fi

# dir to check
if test -z $1; then
  AC_MSG_ERROR([${arg_pkg} dir was not specified])
else
  arg_dir=$1
fi

# optional test file
if test -n ${3}; then
  arg_test_file=$3
fi

# never allow a 'no' choice for core packages
if test ${arg_dir} = "no"; then
  AC_MSG_ERROR(['no' is not a valid choice])
fi

# null arg, i.e. not specified
if test ${arg_dir} = ""; then
  AC_MSG_ERROR([${arg_pkg} was not specified])
fi

# dir does not exist
if ! test -e ${arg_dir}; then
  AC_MSG_ERROR([directory ${arg_dir} for package ${arg_pkg} does not exist])
else
  # not a directory
  if ! test -d ${arg_dir}; then
    AC_MSG_ERROR([$arg_dir is not a directory])
  fi
fi

# check test file relative to input path (optional)
if test -n ${arg_test_file}; then
  GDML_CHECK_TEST_FILE( [${arg_dir}/${arg_test_file}] )
fi

])
