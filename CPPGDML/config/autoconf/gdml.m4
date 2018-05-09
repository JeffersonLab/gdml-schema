# function to set whether shared libs should be built
AC_DEFUN(GAC_ENABLE_SHARED_LIBS, [

AC_MSG_CHECKING(whether to build shared libs)

AC_ARG_ENABLE(shared-libs,
	AC_HELP_STRING([--enable-shared-libs], [enable building of shared libs]),
	[BUILD_SHARED_LIBS=$enable_shared_libs],
	[BUILD_SHARED_LIBS=yes])

# default to not building shared libs
if test -z "$BUILD_SHARED_LIBS"; then
  BUILD_SHARED_LIBS=no
fi

AC_MSG_RESULT($BUILD_SHARED_LIBS)

AC_SUBST(BUILD_SHARED_LIBS)

])

# function to set whether static libs should be built
AC_DEFUN(GAC_ENABLE_STATIC_LIBS, [

AC_MSG_CHECKING(whether to build static libs)

AC_ARG_ENABLE(static-libs,
	AC_HELP_STRING([--enable-static-libs], [enable building of static libs]),
	[BUILD_STATIC_LIBS=$enable_static_libs],
	[BUILD_STATIC_LIBS=yes])

# default to not building static libs
if test -z "$BUILD_STATIC_LIBS"; then
  BUILD_STATIC_LIBS=no
fi

AC_MSG_RESULT($BUILD_STATIC_LIBS)

AC_SUBST(BUILD_STATIC_LIBS)

])

# libs setup
AC_DEFUN(GAC_SETUP_LIBS, [

GAC_ENABLE_SHARED_LIBS
GAC_ENABLE_STATIC_LIBS

if test "${BUILD_STATIC_LIBS}" = "no" && test "${BUILD_SHARED_LIBS}" = "no"; then
  AC_MSG_ERROR([At least one of --enable-static-libs and --enable-shared-libs must be selected.])
fi

GAC_WITH_LIBNAME_PREFIX

])

AC_DEFUN(GAC_WITH_LIBNAME_PREFIX, [

AC_MSG_CHECKING(for libname prefix)

AC_ARG_WITH(libname-prefix,
	AC_HELP_STRING([--with-libname-prefix=<prefix>], [prefix target libs with a string identifier, e.g. 'lcg_']),
	[TARGET_LIB_PREFIX=$with_libname_prefix],
	[TARGET_LIB_PREFIX=])

if test "${with_libname_prefix}" = "no"; then
  TARGET_LIB_PREFIX=
fi

if test -n "${TARGET_LIB_PREFIX}"; then
  AC_MSG_RESULT($TARGET_LIB_PREFIX)
else
  AC_MSG_RESULT(none)
fi

AC_SUBST(TARGET_LIB_PREFIX)

])

# function to check the OS
AC_DEFUN(GAC_CHECK_OS, [

AC_MSG_CHECKING(for supported OS)

# to lowercase
#host_os=`uname -s | tr [[:upper:]] [[:lower:]]`
host_os=`uname -s`

supported_os=yes

case "$host_os" in

Linux*            ) host_os="Linux";; 
CYGWIN*           ) host_os="CYGWIN";;
DARWIN*           ) host_os="DARWIN";;
*                 ) supported_os=no;;

esac

AC_MSG_RESULT([$supported_os])

if test "$supported_os" = "no"; then
  AC_MSG_ERROR( [$host_os is not in the list of supported operating systems] )
fi

])

# function to check the compiler
AC_DEFUN(GAC_CHECK_COMPILER, [

AC_MSG_CHECKING(the compiler setting)

if test -n $CXX; then
  host_compiler=$CXX
# Don't know why this would happen, but we will default to g++ if CXX is not set.
else
  host_compiler=g++
fi

COMPILER=$host_compiler

AC_MSG_RESULT([$COMPILER])

AC_MSG_CHECKING([for the compiler gmk file])

COMPILER_GMK_FILE=${make_compiler_dir}/${COMPILER}.gmk

if ! test -e $COMPILER_GMK_FILE; then
  AC_MSG_RESULT(no)
  AC_MSG_ERROR([$COMPILER_GMK_FILE does not exist for compiler $COMPILER])
else
  AC_MSG_RESULT($COMPILER_GMK_FILE)
fi

AC_SUBST(COMPILER)
AC_SUBST(COMPILER_GMK_FILE)

])

# function to set whether compile should be verbose
AC_DEFUN( GAC_ENABLE_COMPILE_VERBOSE, [

AC_SUBST(COMPILE_VERBOSE_USE)

AC_MSG_CHECKING(whether to compile and link in verbose mode)

AC_ARG_ENABLE([compile-verbose],
	AC_HELP_STRING([--enable-compile-verbose=<setting>], [set compile verbose to on or off]),
	[COMPILE_VERBOSE_USE=$enable_compile_verbose],
	[COMPILE_VERBOSE_USE=no])

AC_MSG_RESULT($COMPILE_VERBOSE_USE)

if test "${COMPILE_VERBOSE_USE}" != yes && test "${COMPILE_VERBOSE_USE}" != no; then
  AC_MSG_ERROR([$COMPILE_VERBOSE_USE is not a valid setting for --enable-compile-verbose])
fi

if test "${COMPILE_VERBOSE_USE}" = yes; then
  CXXFLAGS="${CXXFLAGS} -v -Wl,--verbose"
fi

])

# function for PLATFORM with arg or env var
AC_DEFUN(GAC_WITH_PLATFORM, [

AC_MSG_CHECKING([for PLATFORM setting])

AC_ARG_WITH([platform],
	AC_HELP_STRING([--with-platform=<platform>],[description of platform, e.g. linux]),
	[PLATFORM=${with_platform}],
	[PLATFORM=${host_os}"-"${host_compiler}])

# check for gmk file
AC_MSG_RESULT($PLATFORM)

AC_MSG_CHECKING([for the PLATFORM gmk file])

PLATFORM_GMK_FILE=${make_platform_dir}/${PLATFORM}.gmk

# invalid platform gmk or user failed to create it
if ! test -e $PLATFORM_GMK_FILE; then
  AC_MSG_RESULT(no)
  AC_MSG_ERROR([$PLATFORM_GMK_FILE does not exist for PLATFORM=$PLATFORM])
else 
  AC_MSG_RESULT($PLATFORM_GMK_FILE)
fi

# substitute to output
AC_SUBST(PLATFORM)
AC_SUBST(PLATFORM_GMK_FILE)

])

# initialize some "global" variables for configuration
AC_DEFUN(GAC_INIT, [

# make includes directories
make_inc_dir=config/make
make_platform_dir=${make_inc_dir}/platform
make_compiler_dir=${make_inc_dir}/compiler
make_ext_dir=${make_inc_dir}/ext

])

AC_DEFUN(GAC_WITH_BUILDDIR, [

AC_MSG_CHECKING(for build directory)

AC_ARG_WITH([build-dir],
	AC_HELP_STRING([--with-build-dir=<path>],[target directory for base build]),
	[TARGET_BUILD_DIR=$with_build_dir],
	[TARGET_BUILD_DIR=${srcdir}/build/${PLATFORM}])

AC_SUBST(TARGET_BUILD_DIR)

])

AC_DEFUN(GAC_SETUP_INSTALL_DIRS, [

AC_MSG_CHECKING(for prefix)

if test "${prefix}" = "NONE"; then
  prefix=/usr/local
fi

exec_prefix=${prefix}

AC_MSG_RESULT($prefix)

AC_SUBST(prefix)
AC_SUBST(exec_prefix)
AC_SUBST(libdir)
AC_SUBST(includedir)

])

AC_DEFUN(GAC_ENABLE_GDML_VERBOSE, [

AC_MSG_CHECKING(whether to enable GDML diagnostic output)

AC_ARG_ENABLE([gdml-verbose],	
	AC_HELP_STRING([--enable-gdml-verbose=<setting>], [Turn GDML diagnostic output on or off.]),
	[GDML_VERBOSE_USE=$enable_gdml_verbose],
	[GDML_VERBOSE_USE=no])

if test "${GDML_VERBOSE_USE}" = "yes"; then
  AC_DEFINE(GDML_VERBOSE)
fi

AC_MSG_RESULT($GDML_VERBOSE_USE)

])

# function to setup GDML package
AC_DEFUN(GAC_SETUP_GDML, [

GAC_CHECK_OS
GAC_CHECK_COMPILER
GAC_ENABLE_COMPILE_VERBOSE
GAC_WITH_PLATFORM
GAC_SETUP_LIBS
GAC_SETUP_INSTALL_DIRS
GAC_ENABLE_GDML_VERBOSE

])